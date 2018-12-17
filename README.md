# SomaLogic
SomaLogic data analysis

## Installation

The repository can be downloaded locally with
```bash
git clone https://github.com/jinghuazhao/SomaLogic
```

## A summary of files

File  | Description
-------------|---------------------------------
[doc/](doc) | Documents and auxiliary files
[SomaLogic_analysis_plan.md](SomaLogic_analysis_plan.md) | Analysis plan
[SomaLogic.R](SomaLogic.R) | Generation of auxiliary files from curated databases
[list.sh](list.sh) | Generation of submitted and renamed file lists and directories
[format.sb](format.sb) | [SLURM](https://slurm.schedmd.com/) scripts which call [format.subs](format.subs)
[format.sh](format.sh) | Reformatting GWAS summary statistics using GNU Parallel, e.g., `format.sh FHS`
[QCGWAS.sb](QCGWAS.sb) | QCGWAS -- SLURM
[QCGWAS.sh](QCGWAS.sh) | QCGWAS -- Bash
[QCGWAS.R](QCGWAS.R) | QCGWAS -- R
[metal.sh](metal.sh) | Generation and execution of individual METAL entries
[metal.sb](metal.sb) | SLURM routine

## A featured article

Behar M (2018). Proteomics might have saved my mother’s life and it may yet save mine. *The New York Times Magazine*,
https://www.nytimes.com/interactive/2018/11/15/magazine/tech-design-proteomics.html, 
also [here](http://www.michaelbehar.com/articles/the-new-york-times-november-18-2018/)
([PDF](http://www.michaelbehar.com/wp-content/uploads/2012/09/The-Everything-Test-The-New-York-Times-Magazine.pdf)).
