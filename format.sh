# 20-9-2018 JHZ
#  Reformatting files into directories

## raw and reformatted SUMSTATS
export box=/scratch/jhz22/box
export sumstats=/scratch/jhz22/sumstats

module load parallel/20131222

## Each cohort is formatted and output with its AWK program,.

function FHS()
{

echo --- FHS ---
join -j1 $sumstats/FHS.list doc/FHS.txt | \
parallel --dry-run -j4 -C' ' --env box --env sumstats 'gunzip -c $box/FHS/X_{1}.txt.gz | \
awk -f doc/FHS.awk > $sumstats/FHS/FHS.{2}.txt'

}

function KORA()
{

echo --- KORA ---

cat $sumstats/KORA.list | \
parallel --dry-run -j4 -C' ' --env box --env sumstats 'gunzip -c $DEPICT/KORA_pGWAS.{}.assoc.linear.gz | \
awk -vOFS="\t" -f doc/KORA.awk > $sumstat/KORA/KORA.{}.txt'

}

function Malmo()
{

sort -k3,3 doc/MDCs.txt | \
join -11 -23 -t$'\t' $sumstats/Malmo.list - | \
awk '{print $1, $2}' | \
parallel --dry-run -j4 -C' ' --env box --env sumstats 'gunzip -c $box/zln{1}_summary.csv.gz | \
awk -vOFS="\t" -f doc/Malmo.awk > $sumstats/Malmo/Malmo.{}.txt'

}

function QMDiab()
{

echo -- QMDiab ---
# See KORA above
cat $sumstats/KORA.list | \
parallel --dry-run -j5 -C' ' --env box --env sumstats 'gunzip -c $box/QMDiab/PGWAS_Results/QMDiab_pGWAS.{}.assoc.linear.gz | \
awk -vOFS="\t" -f doc/QMDiab.awk > $sumstat/QMDiab/QMDiab.{}.txt'
}

FHS
KORA
Malmo
QMDiab
