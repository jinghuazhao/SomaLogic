# SomaLogic
SomaLogic data analysis

## Installation

The repository can be downloaded locally with
```bash
git clone https://github.com/jinghuazhao/SomaLogic
```

## A summary of files and their use

File  | Description
-------------|---------------------------------
[doc/](doc) | Documents and auxiliary files
[SomaLogic_analysis_plan.md](SomaLogic_analysis_plan.md) | Analysis plan
[SomaLogic.R](SomaLogic.R) | Generation of auxiliary files from curated databases
[format.sh](format.sh) | GWAS summary statistics reformat using GNU Parallel, e.g., `format.sh FHS`
[format.sb](format.sb) | [SLURM](https://slurm.schedmd.com/) scripts
[format.subs](format.subs) | Processing of a particular study and array job
[list.sh](list.sh) | Generation of received and output file lists and directories
[metal.sh](metal.sh) | Generation and execution of individual METAL entries
[metal.sb](metal.sb) | SLURM routine
[QCGWAS.sb](QCGWAS.sb) | QCGWAS -- SLURM
[QCGWAS.sh](QCGWAS.sh) | QCGWAS -- Bash
[QCGWAS.R](QCGWAS.R) | QCGWAS -- R

The workflows involve the following components,

1. Data are downloaded from the Box server to dedicated directories; as noted in [box.md](doc/box.md).
2. available entries are catalogued in a list, as done by list.*.
3. GWAS summary statistics associated with the list are reformatted by format.* according to the analysis plan.
4. Then necessary, the summary statistics are examined with R/QCGWAS.
5. Batch scripts for metal analysis are then generated and executed with metal.*.
6. Downstream analysis according to plan.

[SomaLogic.list](doc/SomaLogic.list) is an auxilliary file conaining a list of proteins available from studies.

## A featured article

Behar M (2018). Proteomics might have saved my mother’s life and it may yet save mine. *The New York Times Magazine*,
https://www.nytimes.com/interactive/2018/11/15/magazine/tech-design-proteomics.html, 
also [here](http://www.michaelbehar.com/articles/the-new-york-times-november-18-2018/)
([PDF](http://www.michaelbehar.com/wp-content/uploads/2012/09/The-Everything-Test-The-New-York-Times-Magazine.pdf)).
