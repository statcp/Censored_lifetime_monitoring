# Reproducibility Materials for "Statistical Monitoring of Censored Lifetime Data: Insights into Two Special Alarm Phenomena"

This repository contains the MATLAB code and numerical data used to support the computational results reported in the paper:

**Statistical Monitoring of Censored Lifetime Data: Insights into Two Special Alarm Phenomena**

**Authors:** Chenglong Li, Xun Xiao, and Piao Chen

The materials are provided to facilitate reproducibility of the numerical results reported in the associated *IISE Transactions* manuscript.

## Repository Contents

| File             | Description                                                                                                                                                  | Related Results         |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- |
| `Code_CA.m`      | MATLAB code for evaluating the occurrence of CAs and the out-of-control average time to signal (ATS), including results with and without accounting for CAs. | Figures 4–6             |
| `Data_CA.xlsx`   | Numerical results used for the CA analysis.                                                                                                                  | Figures 4–6             |
| `Code_CAPA.m`    | MATLAB code for evaluating the occurrence of CAs and PAs and the corresponding out-of-control ATS.                                                           | Figures 7–9 and Table 1 |
| `Data_CAPA.xlsx` | Numerical results used for the joint CA and PA analysis.                                                                                                     | Figures 7–9 and Table 1 |

## Data Files

Both Excel workbooks contain numerical results obtained from the Monte Carlo simulations.

Each workbook contains 18 worksheets corresponding to combinations of

* Weibull shape parameter: (\gamma = 0.5, 1, 3)
* Weibull scale parameter: (\eta = 10, 20)
* Sample size: (n = 5, 10, 30)

Within each worksheet, results are reported for

[
\rho = 0.1,;0.25,;0.5,;0.75
]

over a range of censoring times (c).

### `Data_CA.xlsx`

The main reported quantities are:

* `c`: censoring time
* `H`: control limit
* `p_ca`: estimated probability of occurrence of CAs
* `ATS_bl`: out-of-control ATS when CAs are ignored
* `ATS_ca`: out-of-control ATS when CAs are accounted for

### `Data_CAPA.xlsx`

The main reported quantities are:

* `c`: censoring time
* `H`: control limit
* `p_ca`: estimated probability of occurrence of CAs
* `p_pa`: estimated probability of occurrence of PAs
* `ATS_ca`: out-of-control ATS accounting for CAs
* `ATS_capa`: out-of-control ATS accounting for both CAs and PAs

## Computational Environment

The numerical results reported in the paper were generated using:

* **MATLAB:** R2022b
* **Operating system:** Windows 11 Home
* **Processor:** 13th Gen Intel Core i7-1360P
* **Memory:** 32 GB RAM

Other MATLAB versions and operating systems may also be able to run the code, but MATLAB R2022b corresponds to the computational environment used to generate the reported results.

## Reproducing the Results

1. Clone or download this repository.

2. Open MATLAB and set the repository directory as the current working folder.

3. Select the MATLAB script corresponding to the results to be reproduced:

   * Run `Code_CA.m` for the CA analysis in Figures 4–6.
   * Run `Code_CAPA.m` for the CA and PA analysis in Figures 7–9 and Table 1.

4. Set the desired parameter values near the beginning of the MATLAB script.

   The parameters in the code correspond to the notation used in the data files as follows:

   * `a0` corresponds to the Weibull shape parameter (\gamma)
   * `b0` corresponds to the Weibull scale parameter (\eta)
   * `n` is the sample size
   * `c` is the censoring time
   * `b1/b0` corresponds to the shift parameter (\rho)

   For example, the supplied scripts use the default setting

   ```matlab
   Alpha = 0.0027;
   n = 10;
   a0 = 1;
   b0 = 10;
   c = 10;
   b1 = b0*0.5;
   ```

   which corresponds to

   [
   \gamma=1,\qquad \eta=10,\qquad n=10,\qquad c=10,\qquad \rho=0.5.
   ]

5. Run the selected script.

   `Code_CA.m` first computes the control limit (H), and then reports:

   ```text
   p_ca   ATS_bl   ATS_ca
   ```

   `Code_CAPA.m` first computes the control limit (H), and then reports:

   ```text
   p_ca   p_pa   ATS_capa
   ```

6. Compare the resulting values with the corresponding entries in `Data_CA.xlsx` or `Data_CAPA.xlsx`.

## Monte Carlo Settings

The supplied code uses the following simulation settings:

```matlab
Alpha    = 0.0027;
ICSimNum = 10^7;
OCSimNum = 10^5;
```

where:

* `Alpha` is the acceptable probability of a Type-I error;
* `ICSimNum` is the number of Monte Carlo replications used for the in-control scenario and control-limit calculation;
* `OCSimNum` is the number of Monte Carlo replications used for the out-of-control scenario.

The MATLAB random-number generator is initialized using

```matlab
rng('default')
```

to facilitate reproducibility.

Because the reported results are based on Monte Carlo simulation, changing the simulation sizes or random-number settings may lead to numerical differences from the values provided in the Excel files.

## Expected Runtime

Depending on the selected values of (n), (c), and (\rho), a simulation run may take approximately **5 seconds to 5 minutes** on the computational environment described above.

