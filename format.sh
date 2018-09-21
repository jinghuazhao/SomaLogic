#!/bin/bash
# 21-9-2018 JHZ
# Reformatting files into directories

function module ()
{
  eval `/usr/bin/modulecmd bash $*`
}

module load parallel/20131222

## raw and reformatted SUMSTATS
export SomaLogic=/scratch/jhz22/SomaLogic
export box=$SomaLogic/box
export sumstats=$SomaLogic/sumstats

## Each cohort is formatted and output with its AWK program.

export run_cohort=$1
export SLURM_ARRAY_TASK_ID=$2
export sl=27

function FHS()
{

echo --- FHS ---
join -j1 $sumstats/FHS.list doc/FHS.txt | \
awk 'NR==(v-1)*sl+1, NR==v*sl' v=SLURM_ARRAY_TASK_ID sl=$sl | \
parallel -j1 -C' ' --env box --env sumstats 'gunzip -c $box/FHS/X_{1}.txt.gz | \
awk -vFS="," -vOFS="\t" -f doc/FHS.awk | \
sort -k2,2n -k3,3n | \
gzip -f > $sumstats/FHS/FHS.{2}.txt.gz'

}

function KORA()
{

echo --- KORA ---

sort -k2,2 $box/KORA/KORA.bim > $sumstats/KORA.bim
cat $sumstats/KORA.list | \
awk 'NR==(v-1)*sl+1, NR==v*sl' v=SLURM_ARRAY_TASK_ID sl=$sl | \
parallel -j1 -C' ' --env box --env sumstats 'gunzip -c $box/KORA/KORA_pGWAS.{}.assoc.linear.gz | \
sort -k2,2 | \
join -j2 - $sumstats/KORA.bim | \
awk -vOFS="\t" -f doc/KORA.awk | \
sort -k2,2n -k3,3n | \
gzip -f > $sumstat/KORA/KORA.{}.txt.gz'

}

function Malmo()
{

sort -k3,3 doc/MDCs.txt | \
join -11 -23 -t$'\t' $sumstats/Malmo.list - | \
awk '{print $1, $2}' | \
awk 'NR==(v-1)*sl+1, NR==v*sl' v=SLURM_ARRAY_TASK_ID sl=$sl | \
parallel -j1 -C' ' --env box --env sumstats 'gunzip -c $box/Malmo/zln{1}_summary.csv.gz | \
awk -vFS="," -vOFS="\t" -f doc/Malmo.awk | \
sort -k2,2n -k3,3n | \
gzip -f > $sumstats/Malmo/Malmo.{2}.txt.gz'

}

function QMDiab()
{

echo -- QMDiab ---
export src=$box/QMDiab/PGWAS_Results
sort -k2,2 $src/QMDiab.bim > $sumsstats/QMDiab.bim
cat $sumstats/QMDiab.list | \
awk 'NR==(v-1)*sl+1, NR==v*sl' v=SLURM_ARRAY_TASK_ID sl=$sl | \
parallel -j1 -C' ' --env src --env sumstats 'gunzip -c $src/QMDiab_pGWAS.{}.assoc.linear.gz | \
sort -k2,2 | \
join -j2 - $sumstats/QMDiab.bim | \
awk -vOFS="\t" -f doc/QMDiab.awk | \
sort -k2,2n -k3,3n | \
gzip -f > $sumstat/QMDiab/QMDiab.{}.txt.gz'
}

$run_cohort
