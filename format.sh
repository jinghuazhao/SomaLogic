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

function FHS()
{

echo --- FHS ---
join -j1 $sumstats/FHS.list doc/FHS.txt | \
parallel -j4 -C' ' --env box --env sumstats 'gunzip -c $box/FHS/X_{1}.txt.gz | \
awk -f doc/FHS.awk > $sumstats/FHS/FHS.{2}.txt'

}

function KORA()
{

echo --- KORA ---

export src=$box/KORA
sort -k2,2 $src/KORA.bim > $sumstats/KORA.bim
cat $sumstats/KORA.list | \
parallel -j4 -C' ' --env src --env sumstats 'gunzip -c $src/KORA_pGWAS.{}.assoc.linear.gz | \
sort -k2,2 | \
join -j2 - $sumstats/KORA.bim | \
awk -vOFS="\t" -f doc/KORA.awk > $sumstat/KORA/KORA.{}.txt'

}

function Malmo()
{

sort -k3,3 doc/MDCs.txt | \
join -11 -23 -t$'\t' $sumstats/Malmo.list - | \
awk '{print $1, $2}' | \
parallel -j4 -C' ' --env box --env sumstats 'gunzip -c $box/zln{1}_summary.csv.gz | \
awk -vOFS="\t" -f doc/Malmo.awk > $sumstats/Malmo/Malmo.{}.txt'

}

function QMDiab()
{

echo -- QMDiab ---
export src=$box/QMDiab/PGWAS_Results
sort -k2,2 $src/QMDiab.bim > $sumsstats/QMDiab.bim
cat $sumstats/QMDiab.list | \
parallel -j4 -C' ' --env src --env sumstats 'gunzip -c $src/QMDiab_pGWAS.{}.assoc.linear.gz | \
sort -k2,2 | \
join -j2 - $sumstats/QMDiab.bim | \
awk -vOFS="\t" -f doc/QMDiab.awk > $sumstat/QMDiab/QMDiab.{}.txt'
}

FHS
KORA
Malmo
QMDiab
