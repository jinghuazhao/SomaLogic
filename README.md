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
[format.sh](format.sh) | GWAS summary statistics reformat using GNU Parallel, e.g., `format.sh FHS`
[format.sb](format.sb) | [SLURM](https://slurm.schedmd.com/) scripts
[format.subs](format.subs) | Processing of a particular study and array job
[list.sh](list.sh) | Generation of received and output file lists and directories
[metal.sh](metal.sh) | Generation and execution of individual METAL entries
[metal.sb](metal.sb) | SLURM routine
[QCGWAS.sb](QCGWAS.sb) | QCGWAS -- SLURM
[QCGWAS.sh](QCGWAS.sh) | QCGWAS -- Bash
[QCGWAS.R](QCGWAS.R) | QCGWAS -- R

## Miscellaneous notes

File [box.md](doc/box.md) describes ways to handle data with Box server.

[SomaLogic.list](doc/SomaLogic.list) gives a list of proteins available from studies.

## A featured article

Behar M (2018). Proteomics might have saved my mother’s life and it may yet save mine. *The New York Times Magazine*,
https://www.nytimes.com/interactive/2018/11/15/magazine/tech-design-proteomics.html, 
also [here](http://www.michaelbehar.com/articles/the-new-york-times-november-18-2018/)
([PDF](http://www.michaelbehar.com/wp-content/uploads/2012/09/The-Everything-Test-The-New-York-Times-Magazine.pdf)).
