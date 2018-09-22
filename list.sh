# 22-9-2018 JHZ
# Generation of file lists and directories

export SomaLogic=/scratch/jhz22/SomaLogic
export box=$SomaLogic/box
export sumstats=$SomaLogic/sumstats

if [ ! -d $sumstats ]; then
   mkdir $sumstats
fi
cd $sumstats
for s in FHS INTERVAL KORA Malmo QMDiab
do
   if [ ! -d $s ]; then
      mkdir $s
   fi
done
cd -

# FHS, 1118 items, 16m imputed genotypes by "-"-stripped AptamerId

ls $box/FHS | sed 's/X_//g;s/.txt.gz//g' | sort -k1,1 > $sumstats/FHS.input
join -j1 $sumstats/FHS.input doc/FHS.txt > $sumstats/FHS.list

# INTERVAL, A1CF results for imputed genotypes by chromosome

ls $box/INTERVAL/A1CF.12423.38.3/ | sed 's/12423.38.3_chrom_//g;s/_meta_final_v1.tsv.gz//g' > $sumstats/INTERVAL.list

# KORA, 1131 panel, PLINK outputs on 8m imputed genotypes by AptamerId

ls $box/KORA | sed 's/KORA_pGWAS.//g;s/.assoc.linear.gz//g' | awk 'NR>2' > $sumstats/KORA.input
sort -k2,2 $box/KORA/KORA.bim > $sumstats/KORA.bim
cat $sumstats/KORA.input > $sumstats/KORA.list

# Malmo, 1306 panel, 15m imputed genotypes by EntrezGeneSymbol

ls $box/Malmo | sed 's/^zln//g;s/_summary.csv.gz//g' | sort -k1,1 > $sumstats/Malmo.input
sort -k3,3 doc/MDCs.txt | \
join -11 -23 -t$'\t' $sumstats/Malmo.input - | \
awk '{print $1, $2}' > $sumstats/Malmo.list

# QMDiab, PLINK outputs (4+1141) 20m imputed genotypes by AptamerId

ls $box/QMDiab/PGWAS_Results | \
sed 's/QMDiab_pGWAS.//g;s/.assoc.linear.gz//g;s/.assoc.linear//g' | awk 'NR>2' > $sumstats/QMDiab.input
export src=$box/QMDiab/PGWAS_Results
sort -k2,2 $src/QMDiab.bim > $sumsstats/QMDiab.bim
cat $sumstats/QMDiab.input > $sumstats/QMDiab.list
