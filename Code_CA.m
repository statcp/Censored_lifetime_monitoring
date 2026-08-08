clear

Alpha=0.0027; % Acceptable probability of type-I error
n=10; % Sample size
a0=1; % IC Weibull distribution shape parameter
b0=10; % IC Weibull distribution scale parameter
ICSimNum=10^7; % Number of Monte Carlo simulations for IC scenario
OCSimNum=10^5; % Number of Monte Carlo simulations for OC scenario

% This part of the code computes the control limit for a given c using Monte Carlo simulation.​
rng('default')
ICSample_save=random('Weibull', b0, a0, [n ICSimNum]);

c=10; % Censoring time
ICSample=ICSample_save;
ICFailNum=sum(ICSample<=c);
ICSample(ICSample>c)=c;
X=(sum(ICSample.^a0)./ICFailNum).^(1/a0);
H=quantile(X,Alpha); % Control limit
fprintf('%g %6.4f\n',c,H);

% This part of the code computes the probability of occurrence of CAs, and OC ATS metric using Monte Carlo simulation.
rng('default')
a1=a0; % OC Weibull distribution shape parameter
b1=b0*0.5; % OC Weibull distribution scale parameter
iTS1=zeros(1,OCSimNum);
iTS2=zeros(1,OCSimNum);
TS1=zeros(1,OCSimNum);
TS2=zeros(1,OCSimNum);
Sign_ca=zeros(1,OCSimNum);
for loop_outer=1:OCSimNum
    Y=H;
    count_inner=0;
    while Y>=H
        OCSample=random('Weibull', b1, a1, [n 1]);
        FailNum=sum(OCSample<=c);
        OCSample(OCSample>c)=c;
        Y=(sum(OCSample.^a0)./FailNum).^(1/a0);
        count_inner=count_inner+1;
    end
    iM=max(OCSample);
    iTS1(loop_outer)=count_inner;
    iTS2(loop_outer)=iM;
    OCSample=random('Weibull', b1, a1, [n floor(iM)]);
    FailNum=sum(OCSample<=c);
    OCSample(OCSample>c)=c;
    Y=(sum(OCSample.^a0)./FailNum).^(1/a0);
    Id=find(Y<H);
    if isempty(Id)
        Sign_ca(loop_outer)=1;
        TS1(loop_outer)=count_inner;
        TS2(loop_outer)=iM;
    else
        M=max(OCSample(:,Id));
        MM=min([iM,M+Id]);
        Sign_ca(loop_outer)=find([iM,M+Id]==MM,1,'first');
        if Sign_ca(loop_outer)==1
            TS1(loop_outer)=count_inner;
            TS2(loop_outer)=iM;
        else
            TS1(loop_outer)=count_inner+Id(Sign_ca(loop_outer)-1);
            TS2(loop_outer)=M(Sign_ca(loop_outer)-1);
        end
    end
end
iATS1=mean(iTS1)-0.5;
iATS2=mean(iTS2);
ATS_bl=iATS1+iATS2; % OC ATS ignoring CAs
ATS1=mean(TS1)-0.5;
ATS2=mean(TS2);
ATS_ca=ATS1+ATS2; % OC ATS accounting for CAs
p_ca=length(find(Sign_ca>1))/OCSimNum; % Probability of occurrence of CAs
fprintf('%g %6.2f %6.2f\n',p_ca,ATS_bl,ATS_ca);