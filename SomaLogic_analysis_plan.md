# SomaLogic analysis plan

*Last updated 20/12/2018*

## Overview

This analysis attempts to collect and analyse GWAS summary statistics for proteins on SomaLogic SOMAscan assays.

## Data

* Phenotypes. Rank-inverse Normal transformation of residuals from `ln(Relative protein abundance) ~ age + sex + PCs`, e.g., via `invnormal` function,
```r
invnormal <- function(x) qnorm((rank(x,na.last="keep")-0.5)/sum(!is.na(x)))
```
* Genotypes. Genechip and imputed genotypes with build37 (hg19) coordinates.

## Model

* Multiple linear regression for all samples with covariates.
* Additive genetic model.
* For case-control studies, please conduct analysis for cases and controls separately.

## Software

It is preferable to use software which account for genotype uncertainty, such as SNPTEST, QUICKTEST, and BOLT-LMM.

## Summary statistics

### SNP-level association results

These are summaised in the following table, with missing values coded as “NA”.

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

Cohorts may opt to report sppedy results from PLINK with the following information, then it is desirable to provide SNP-level information:

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

\* may be taken from the PLINK --hardy option and .bim file, see http://zzz.bwh.harvard.edu/plink/anal.shtml#glm.

In this case, please provide for each SNP information on strand, effect allele, effect allele frequency, and the information measures for imputation -- the information
measure can be on the genotype level obtained once for a cohort rather than from phenotype-genotype regression through software such as SNPTEST. SNP and sample based
statistics can be greatly facilitated with software qctool, http://www.well.ox.ac.uk/~gav/qctool_v2/, e.g. 
```bash
qctool -g INTERVAL.bgen -s INTERVAL.sample -snp-stats -osnp INTERVAL.snp-stats -sample-stats -osample INTERVAL.sample-stats
```
See Appendix for a full example using SLURM.

When a dosage format is used, PLINK can also gives an INFO measure, see http://zzz.bwh.harvard.edu/plink/dosage.shtml.

### Descriptive statistics

This would include cohort-level summary statistics, brief description of the protein assays, genechips, quality controls, imputation. Please provide details of imputation panels.

A [Google sheet](https://tinyurl.com/y7vjd8lo) has been set up to enable assembling of the information online.

[https://tinyurl.com/yd8tck8y](https://tinyurl.com/yd8tck8y)

Alternatively, an [Excel spreadsheet](doc/SomaLogic.xlsx) is also available for download.

### File-naming convention

It is recommended to use format 

* *STUDY_analyst_SomaLogic_protein_SeqID_UniProtID_date.gz* for SNP-based results. See the [SomaLogic Master Table](doc/SOMALOGIC_Master_Table_160410_1129info.tsv) for SeqID and also https://www.uniprot.org/ for additional information on UniProt IDs.
* *STUDY_analyst_SomaLogic_Descriptive_Information_date.txt* for cohort level information.

## Data upload

Please contact us for details.

## Meta-analysis

Meta-analysis will be performed centrally using the inverse-N weighted analysis of regression betas and standard errors, as implemented in the software METAL (https://github.com/statgen/METAL).

Genomic control and appropriate marker filters will be applied at this stage.

 * Marker exclusion filters: we will apply imputation quality filters at the meta-analysis stage, so provide unfiltered results.
 * Genomic control (GC): genomic control will be applied to each study at the meta-analysis stage (single GC), so GC-correction is needed for each cohort.
 * Significance: the Bonferroni threshold for the genome-wide analyses will be set at 5 x 10<sup>-11</sup>. The results will be replicated in independent cohorts.

## Participating cohorts

FHS, INTERVAL, KORA, Malmo, QMDiab, TwinsUK.

## References

Cotton RJ, Graumann J (2016) readat: An R package for reading and working with SomaLogic ADAT files.
*BMC Bioinformatics*, https://doi.org/10.1186/s12859-016-1007-8, [Bioconductor](https://bioconductor.org/packages/release/bioc/html/readat.html) and [bitbucket](https://bitbucket.org/graumannlabtools/readat).

Stacey D, et al. (2018), ProGeM: a framework for the prioritization of candidate causal genes 
at molecular quantitative trait loci. *Nucleic Acids Research*, https://doi.org/10.1093/nar/gky837, [GitHub](https://github.com/ds763/ProGeM) and [bioRxiv](http://dx.doi.org/10.1101/230094).

Sun BB, et al. (2018). Genomic atlas of the human plasma proteome. *Nature* 558: 73–79, SomaLogic plasma protein GWAS summary statistics, https://app.box.com/s/u3flbp13zjydegrxjb2uepagp1vb6bj2, [EGA entry](https://ega-archive.org/studies/EGAS00001002555).
**Notes**: [SERPINA1.R](doc/SERPINA1.R) creates ![**an artist's SERPINA1**](doc/SERPINA1.pdf) similar to [RCircos version by Jimmy](doc/fig2.R), and [Methods.md](doc/Methods.md) is the Markdown version of the Methods section of the paper.

## Appendix

**SLURM script for qctool 2.0.1**

This is called with `sbatch qctool.sb`, where `qctool.sb` contains the following lines:

```bash
#!/bin/bash --login

#SBATCH -J qctool
#SBATCH -o qctool.log
#SBATCH -p long
#SBATCH -t 4-0:0
#SBATCH --export ALL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

export DIR=/scratch/bp406/data_sets/interval_subset_olink/genotype_files/unrelated_4994_pihat_0.1875_autosomal_typed_only
export INTERVAL=$DIR/interval_olink_subset_unrelated_4994_pihat_0.1875_autosomal_typed_only
ln -sf $INTERVAL.bgen INTERVAL.bgen
ln -sf $INTERVAL.sample INTERVAL.sample

# to obtain SNP-specific statistics as in .bgen and .sample format

qctool -g INTERVAL.bgen -s INTERVAL.sample -snp-stats -osnp INTERVAL.snp-stats

# Note in particular: the # option allows for chromosome-specific analysis; the -strand option will enable results in positive strand.
```
The following script obtain SNP-statistics for each chromosome,
```bash
#!/bin/bash --login

#SBATCH -J qctool
#SBATCH -o qctool.log
#SBATCH -p long
#SBATCH -a 1-22
#SBATCH -t 4-0:0
#SBATCH --export ALL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

export DIR=/scratch/bp406/data_sets/interval_subset_olink/genotype_files/unrelated_4994_pihat_0.1875_autosomal_typed_only/per_chr
export INTERVAL=$DIR/interval_olink_subset_unrelated_4994_pihat_0.1875_autosomal_typed_only_chr_
export chr=$SLURM_ARRAY_TASK_ID

qctool -g ${INTERVAL}${chr}.bgen -s ${INTERVAL}${chr}.sample -snp-stats -osnp INTERVAL-${chr}.snp-stats
```
