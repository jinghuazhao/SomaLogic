# SomaLogic
SomaLogic data analysis

## Installation

The repository can be downloaded locally with
```bash
git clone https://github.com/jinghuazhao/SomaLogic
```

## A summary of files and their use

File  | Description
-------------|----------------------------------------------------------------------------------------
[doc/](doc) | Documents and auxiliary files
[SomaLogic_analysis_plan.md](SomaLogic_analysis_plan.md) | Analysis plan
[SomaLogic.R](SomaLogic.R) | Generation of axuiliary files such as [SomaLogic.list](doc/SomaLogic.list) for a list of proteins
[format.sh](format.sh) | GWAS summary statistics reformat using GNU Parallel, e.g., `format.sh FHS`
[format.sb](format.sb) | [SLURM](https://slurm.schedmd.com/) scripts
[format.subs](format.subs) | Processing of a particular study and array job
[list.sh](list.sh) | Generation of received and output file lists and directories
[metal.sh](metal.sh) | Generation and execution of individual METAL entries
[metal.sb](metal.sb) | SLURM routine
[QCGWAS.sb](QCGWAS.sb) | QCGWAS -- SLURM
[QCGWAS.R](QCGWAS.R) | QCGWAS -- R
[clump.sh](clump.sh) | PLINK clumping
[clump.sb](clump.sb) | SLURM routine
[qml.sb](qml.sb) | Q-Q, Manhattan ([qqman.R](qqman.R)) and LocusZoom plots

The workflows involve the following components,

1. Data are downloaded from the Box server to dedicated directories; as noted in [box.md](doc/box.md).
2. Available entries are catalogued in a list, as done by `list.*`.
3. GWAS summary statistics associated with the list are reformatted by `format.*` according to the analysis plan.
4. When necessary, the summary statistics are examined with R/QCGWAS.
5. Batch scripts for metal analysis are then generated and executed with `metal.*`.
6. Downstream analysis according to plan.

## Additional information

[SomaLogic](https://somalogic.com/), [wiki](https://en.wikipedia.org/wiki/SomaLogic), [GenomeWeb reports](https://www.genomeweb.com/resources/new-product/somalogic-somascan-assay-13k), the **1129 assay** ([1129.tsv](doc/1129.tsv), derived from [SSM-011-Rev-11-SOMAscan-Assay-V1-1k-Content.pdf](http://www.somalogic.com/wp-content/uploads/2016/10/SSM-011-Rev-11-SOMAscan-Assay-V1-1k-Content.pdf)), **1310 assay** ([1310.tsv](doc/1310.tsv), derived from [SSM-045-REV-1-SOMAscan-Assay-1-3k-Content-1.pdf](http://somalogic.com/wp-content/uploads/2016/09/SSM-045-REV-1-SOMAscan-Assay-1-3k-Content-1.pdf), and [Rev-2](doc/SSM-045-Rev-2-SOMAscan-Assay-1.3k-Content.xlsx)),
and [SOMAscan Proteomic Assay Technical Whie Paper](http://somalogic.com/wp-content/uploads/2017/06/SSM-002-Technical-White-Paper_010916_LSM1.pdf).

Behar M (2018). Proteomics might have saved my mother’s life and it may yet save mine. *The New York Times Magazine*,
https://www.nytimes.com/interactive/2018/11/15/magazine/tech-design-proteomics.html, 
also [here](http://www.michaelbehar.com/articles/the-new-york-times-november-18-2018/)
([PDF](http://www.michaelbehar.com/wp-content/uploads/2012/09/The-Everything-Test-The-New-York-Times-Magazine.pdf)).

Ganz P, et al. (2016). Development and validation of a protein-based risk score for cardiovascular outcomes among patients with stable coronary heart disease. *JAMA* 315(23):2532-2541. doi:10.1001/jama.2016.5951,
https://jamanetwork.com/journals/jama/fullarticle/2529627
