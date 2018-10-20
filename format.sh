#!/bin/bash
# 20-10-2018 JHZ
# Reformatting files into directories

function module ()
{
  eval `/usr/bin/modulecmd bash $*`
}

# module load parallel/20131222
# This version has problem with TEMPDIR, https://stackoverflow.com/questions/24398941/gnu-parallel-unlink-error
# The lastest is here, http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2

## raw and reformatted SUMSTATS
export SomaLogic=/scratch/jhz22/SomaLogic
export box=$SomaLogic/box
export sumstats=$SomaLogic/sumstats
export threads=4

## Each cohort is formatted and output with its AWK program.
## block size can be refined
export bs=27

function FHS()
{
  echo --- FHS ---
  cat $sumstats/FHS.list | \
  parallel -j$threads -C' ' --env box --env sumstats 'gunzip -c $box/FHS/X_{1}.txt.gz | \
  awk -vFS="," -vOFS="\t" -f doc/FHS.awk | \
  sort -k2,2n -k3,3n | \
  awk -f doc/order.awk | \
  gzip -f > $sumstats/FHS/FHS.{2}.txt.gz'
}

function KORA()
{
  echo --- KORA ---
  cat $sumstats/KORA.list | \
  parallel -j$threads -C' ' --env box --env sumstats 'gunzip -c $box/KORA/KORA_pGWAS.{}.assoc.linear.gz | \
  sort -k2,2 | \
  join -j2 - $sumstats/KORA.bim | \
  awk -vOFS="\t" -f doc/KORA.awk | \
  sort -k2,2n -k3,3n | \
  awk -f doc/order.awk | \
  gzip -f > $sumstats/KORA/KORA.{}.txt.gz'
}

function Malmo()
{
  cat $sumstats/Malmo.list | \
  parallel -j$threads -C' ' --env box --env sumstats 'gunzip -c $box/Malmo/zln{1}_summary.csv.gz | \
  awk -vFS="," -vOFS="\t" -f doc/Malmo.awk | \
  sort -k2,2n -k3,3n | \
  awk -f doc/order.awk | \
  gzip -f > $sumstats/Malmo/Malmo.{2}.txt.gz'
}

function QMDiab()
{
  echo -- QMDiab ---
  export src=$box/QMDiab/PGWAS_Results
  cat $sumstats/QMDiab.list | \
  parallel -j$threads -C' ' --env src --env sumstats 'gunzip -c $src/QMDiab_pGWAS.{}.assoc.linear.gz | \
  sort -k2,2 | \
  join -j2 - $sumstats/QMDiab.bim | \
  awk -vOFS="\t" -f doc/QMDiab.awk | \
  sort -k2,2n -k3,3n | \
  awk -f doc/order.awk | \
  gzip -f > $sumstat/QMDiab/QMDiab.{}.txt.gz'
}

export TMPDIR=/scratch/jhz22/tmp
$1
