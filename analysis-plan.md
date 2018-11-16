# Analysis plan

*Last updated 16/11/2018*

## Overview

This analysis attempts to collect and analyse GWAS summary statistics for proteins on the following SomaLogic SOMAscan assays,

* **1129 assay** ([1129.tsv](doc/1129.tsv), derived from [SSM-011-Rev-11-SOMAscan-Assay-V1-1k-Content.pdf](http://www.somalogic.com/wp-content/uploads/2016/10/SSM-011-Rev-11-SOMAscan-Assay-V1-1k-Content.pdf))
* **1310 assay** ([1310.tsv](doc/1310.tsv), derived from [SSM-045-REV-1-SOMAscan-Assay-1-3k-Content-1.pdf](http://somalogic.com/wp-content/uploads/2016/09/SSM-045-REV-1-SOMAscan-Assay-1-3k-Content-1.pdf)) and [Rev-2](doc/SSM-045-Rev-2-SOMAscan-Assay-1.3k-Content.xlsx)

## Data

* Phenotypes. Protein levels.
* Genotypes. Genechip and imputed genotypes with build37 (hg19) coordinates.
* Covariates. Age, sex, principal components.

## Model

*  Rank-based inverse normal transformation on the raw measurement of proteins including those below lower limit of detection, e.g., via `invnormal` function,
```r
invnormal <- function(x)
  qnorm((rank(x,na.last="keep")-0.5)/sum(!is.na(x)))
```
* Multiple linear regression for all samples with covariates.
* Additive genetic model.
* For case-control studies, please conduct analysis for cases and controls separately.

## Software

It is preferable to use software which account for genotype uncertainty, such as SNPTEST, QUICKTEST, and BOLT-LMM.

## SNP-level summary statistics

SNP table for association results. Missing values are coded as “NA”.

No. | Variable name | Description
--|---------------|-----------------------------------------------------------------------------------
1 | SNPID | CHR:POS_A1_A2 (where A1<A2) or rsid
2 | CHR | Chromosome number (1-22)
3 | POS | Physical position for the reference sequence (please indicate NCBI build in descriptive file)
4 | STRAND | Indicator of strand direction. Please specify “+” if positive or forward strand and “-” if negative or reverse strand. 
5 | N | Number of non-missing observations
6 | EFFECT_ALLELE | Allele for which the effect (beta coefficient) is reported. For example, in an A/G SNP in which AA = 0, AG=1, and GG=2, the coded allele is G.
7 | REFERENCE_ALLELE | Second allele at the SNP (the other allele). In the example above, the non-coded allele is A. 
8 | EAF | Effect allele frequency – “NA” if not available
9 | BETA | Effect size for the coded allele, beta estimate from the genotype-phenotype association, with at least 5 decimal places. Note: if not available, please report “NA” for this variable.
10 | SE | Standard error of the beta estimate, to at least 5 decimal places - “NA” if not available. 
11 | PVAL | p-value of Wald test statistic – “NA” if not available
12 | RSQ | Residual phenotypic variance explained by SNP. “NA” if not available
13 | RSQ_IMP| Observed divided by expected variance for imputed allele dosage.
14 | IMP | Please specify whether the SNP was imputed or genotyped: 1: imputed SNP, 0: directly genotyped SNP

### PLINK results

Cohorts may opt to report results from PLINK, with the following information, then SNP-level information as appropriate:

No | Name | Description | Additional comment
--|----------|----------|-------------------------------------
1 | BP | Position in base pairs
2 | CHR | Chromosome
3 | SNP | CHR:POS_A1_A2 or rsid
4* | HWE | Hardy-Weinberg equilibrium P-value
5* | MAF | Minor allele frequency | Please indicate if this is the effect allele frequency
6 | A1 | Allele 1 | Please indicate if this is the effect/reference allele
7* | A2 | Allele 2 | Please indicate if this is the effect/reference allele
8 | NMISS | Sample size
9 | BETA | Regression coefficient
10 | STAT | Regression test statistic
11 | P | P value

\* may be taken from the PLINK --hardy option and .bim file.

In this case, please provide for each SNP information on strand, effect allele, effect allele frequency, and the information measures for imputation -- the information
measure can be on the genotype level obtained once for a cohort rather than from phenotype-genotype regression through software such as SNPTEST. SNP and sample based
statistics can be greatly facilitated with software qctool, http://www.well.ox.ac.uk/~gav/qctool_v2/.

## Descriptive statistics

This would include cohort-level summary statistics, brief description of the protein assays, genechips, quality controls, imputation. Please provide details of imputation panels.

## Data upload

Please contact us for details.

## Participating cohorts

FHS, INTERVAL, KORA, Malmo, QMDiab.

## References

[SomaLogic](https://somalogic.com/), [wiki](https://en.wikipedia.org/wiki/SomaLogic), [GenomeWeb reports](https://www.genomeweb.com/resources/new-product/somalogic-somascan-assay-13k), and [the whie paper](http://somalogic.com/wp-content/uploads/2017/06/SSM-002-Technical-White-Paper_010916_LSM1.pdf).

Cotton RJ, Graumann J (2016) readat: An R package for reading and working with SomaLogic ADAT files.
*BMC Bioinformatics*, https://doi.org/10.1186/s12859-016-1007-8, [Bioconductor](https://bioconductor.org/packages/release/bioc/html/readat.html) and [bitbucket](https://bitbucket.org/graumannlabtools/readat).

Stacey D, et al. (2018), ProGeM: a framework for the prioritization of candidate causal genes 
at molecular quantitative trait loci. *Nucleic Acids Research*, https://doi.org/10.1093/nar/gky837, [GitHub](https://github.com/ds763/ProGeM) and [bioRxiv](http://dx.doi.org/10.1101/230094).

Sun BB, et al. (2018). Genomic atlas of the human plasma proteome. *Nature* 558: 73–79, SomaLogic plasma protein GWAS summary statistics, https://app.box.com/s/u3flbp13zjydegrxjb2uepagp1vb6bj2, [EGA entry](https://ega-archive.org/studies/EGAS00001002555).
**Notes**: [SERPINA1.R](doc/SERPINA1.R) creates ![**an artist's SERPINA1**](doc/SERPINA1.pdf) similar to [RCircos version by Jimmy](doc/fig2.R), and [Methods.md](doc/Methods.md) is the Markdown version of the Methods section of the paper.
