# SomaLogic
SomaLogic data analysis

## SomaLogic SOMAscan assays

The [SomaLogic](https://somalogic.com/) ([wiki](https://en.wikipedia.org/wiki/SomaLogic)) SOMAscan assay
[GenomeWeb reports](https://www.genomeweb.com/resources/new-product/somalogic-somascan-assay-13k) and 
[white paper](http://somalogic.com/wp-content/uploads/2017/06/SSM-002-Technical-White-Paper_010916_LSM1.pdf).

* **1129 assay** ([1129.tsv](doc/1129.tsv), derived from [SSM-011-Rev-11-SOMAscan-Assay-V1-1k-Content.pdf](http://www.somalogic.com/wp-content/uploads/2016/10/SSM-011-Rev-11-SOMAscan-Assay-V1-1k-Content.pdf))
* **1310 assay** ([1310.tsv](doc/1310.tsv), derived from [SSM-045-REV-1-SOMAscan-Assay-1-3k-Content-1.pdf](http://somalogic.com/wp-content/uploads/2016/09/SSM-045-REV-1-SOMAscan-Assay-1-3k-Content-1.pdf)) and [Rev-2](doc/SSM-045-Rev-2-SOMAscan-Assay-1.3k-Content.xlsx)

## Analysis

* [Environment modules](https://www.ch.cam.ac.uk/computing/software/environment-modules)
* [SLURM usage](https://www.ch.cam.ac.uk/computing/slurm-usage)
* [Bright Cluster Management](https://www.ch.cam.ac.uk/computing/files/clusters/cv-admin-manual.pdf))

## A summary of files

File  | Description
-------------|---------------------------------
[doc/](doc) | Documents and auxiliary files
[analysis-plan.md](analysis-plan.md) | Analysis plan
[SomaLogic.R](SomaLogic.R) | Generation of auxiliary files from curated databases
[list.sh](list.sh) | Generation of submitted and renamed file lists and directories
[format.sh](format.sh) | Reformatting GWAS summary statistics from login node, e.g., `format.sh FHS`
[format.sbatch](format.sbatch), [array.sbatch](array.sbatch) | [SLURM](https://slurm.schedmd.com/) scripts which call [array.subs](array.subs)
[metal.sh](metal.sh) | Generation of individual METAL entries

## References

Cotton RJ, Graumann J (2016) readat: An R package for reading and working with SomaLogic ADAT files.
*BMC Bioinformatics*, https://doi.org/10.1186/s12859-016-1007-8, [Bioconductor](https://bioconductor.org/packages/release/bioc/html/readat.html) and [bitbucket](https://bitbucket.org/graumannlabtools/readat).

Stacey D, et al. (2018), ProGeM: a framework for the prioritization of candidate causal genes 
at molecular quantitative trait loci. *Nucleic Acids Research*, https://doi.org/10.1093/nar/gky837, [GitHub](https://github.com/ds763/ProGeM) and [bioRxiv](http://dx.doi.org/10.1101/230094).

Sun BB, et al. (2018). Genomic atlas of the human plasma proteome. *Nature* 558: 73–79, SomaLogic plasma protein GWAS summary statistics, https://app.box.com/s/u3flbp13zjydegrxjb2uepagp1vb6bj2, [EGA entry](https://ega-archive.org/studies/EGAS00001002555).
**Notes**: [SERPINA1.R](doc/SERPINA1.R) creates ![**an artist's SERPINA1**](doc/SERPINA1.pdf) similar to [RCircos version by Jimmy](doc/fig2.R), and [Methods.md](doc/Methods.md) is the Markdown version of the Methods section of the paper.
