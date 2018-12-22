# 22-12-2018 JHZ

export SomaLogic=/scratch/jhz22/SomaLogic
export sumstats=$SomaLogic/sumstats
export METAL=$SomaLogic/METAL

## generation of protein-specific METAL entries

if [ ! -d $METAL ]; then mkdir $METAL; fi
(
for study in FHS KORA Malmo QMDiab
do
   ls $sumstats/$study | sed 's/'"$study".'//g' | awk -vstudy=$study '{
      s=$1;gsub(/.gz|@/,"",s);
      p=s;gsub(/\.txt/,"",p);
      print p " " ENVIRON["sumstats"] "/" study "/" study "." s ".gz"
   }'
done
) | \
awk '{print $0, NR}' > METAL/METAL.tmp

sort -k1,1 $METAL/METAL.tmp > $METAL/METAL.list
for p in $(cat doc/SomaLogic.list | tr '\n' ' ')
do
(
   echo SEPARATOR TAB
   echo COLUMNCOUNTING STRICT
   echo CHROMOSOMELABEL CHR
   echo POSITIONLABEL POS
   echo CUSTOMVARIABLE N
   echo LABEL N as N
   echo TRACKPOSITIONS ON
   echo AVERAGEFREQ ON
   echo MINMAXFREQ ON
   echo ADDFILTER N ">=" 10
   echo MARKERLABEL SNPID
   echo ALLELELABELS EFFECT_ALLELE REFERENCE_ALLELE
   echo EFFECTLABEL BETA
   echo PVALUELABEL PVAL
   echo WEIGHTLABEL N
   echo FREQLABEL CODE_ALL_FQ
   echo STDERRLABEL SE
   echo SCHEME STDERR
   echo GENOMICCONTROL OFF
   echo OUTFILE $METAL/${p}- .tbl
   echo $p | join METAL/METAL.list - | sort -k3,3n | awk '{print "PROCESS", $2}'
   echo ANALYZE
   echo CLEAR
) > $METAL/$p.metal
done

## all in one directory to get ready for QCGWAS

if [ ! -d $sumstats/work ]; then mkdir $sumstats/work; fi
parallel --env sumstats -j10 -C' ' 'ln -vsf {} $sumstats/work/$(basename {})' ::: $(cut -d' ' -f2 $METAL/METAL.tmp)

sbatch metal.sb
