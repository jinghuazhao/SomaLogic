# 22-9-2018 JHZ
## generation of individual METAL entries

function module ()
{
  eval `/usr/bin/modulecmd bash $*`
}

module load parallel/20131222

export SomaLogic=/scratch/jhz22/SomaLogic
export sumstats=$SomaLogic/sumstats
export METAL=$SomaLogic/METAL

if [ ! -d $METAL ]; then mkdir $METAL; fi

rm -f $METAL/METAL.tmp
touch $METAL/METAL.tmp
for study in FHS KORA Malmo QMDiab
do
   ls $sumstats/$study | sed 's/'"$study".'//g' | awk -vstudy=$study '{
      s=$1
      gsub(/.gz|@/,"",s);print s " " ENVIRON["sumstats"] study "/" study "." s ".gz"
   }' >> $METAL/METAL.tmp
done
sort -k1,1 $METAL/METAL.tmp > $METAL/METAL.list
for p in $(cut -f1 SomaLogic.list)
do
   export run=METAL/$p.run
   echo MARKERLABEL SNPID > $run
   echo ALLELELABELS EFFECT_ALLELE REFERENCE_ALLELE >> $run
   echo EFFECTLABEL BETA >> $run
   echo PVALUELABEL PVAL >> $run
   echo WEIGHTLABEL N >> $run
   echo FREQLABEL CODE_ALL_FQ >> $run
   echo STDERRLABEL SE >> $run
   echo SCHEME SAMPLESIZE >> $run
   echo GENOMICCONTROL OFF >> $run
   echo OUTFILE $METAL/$p- .tbl >> $run
   echo $p | join $METAL/METAL.list - | awk '{$1="PROCESS"; print}' >> $run;
   echo ANALYZE >> $run
   echo CLEAR >> $run
done
