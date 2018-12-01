# 1-12-2018 JHZ
## generation of protein-specific METAL entries

export SomaLogic=/scratch/jhz22/SomaLogic
export sumstats=$SomaLogic/sumstats
export METAL=$SomaLogic/METAL

if [ ! -d $METAL ]; then mkdir $METAL; fi
(
for study in FHS KORA Malmo QMDiab
do
   ls $sumstats/$study | sed 's/'"$study".'//g' | awk -vstudy=$study '{
      s=$1
      gsub(/.gz|@/,"",s);print s " " ENVIRON["sumstats"] study "/" study "." s ".gz"
   }'
done
) > $METAL/METAL.tmp
sort -k1,1 $METAL/METAL.tmp > $METAL/METAL.list
for p in $(cut -f1 doc/SomaLogic.list)
do
(
   echo MARKERLABEL SNPID
   echo ALLELELABELS EFFECT_ALLELE REFERENCE_ALLELE
   echo EFFECTLABEL BETA
   echo PVALUELABEL PVAL
   echo WEIGHTLABEL N
   echo FREQLABEL CODE_ALL_FQ
   echo STDERRLABEL SE
   echo SCHEME SAMPLESIZE
   echo GENOMICCONTROL OFF
   echo OUTFILE $METAL/$p- .tbl
   echo $p | join $METAL/METAL.list - | awk '{$1="PROCESS"; print}'
   echo ANALYZE
   echo CLEAR
) > METAL/$p.run
done
