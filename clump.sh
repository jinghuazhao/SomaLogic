# 27-12-2018 JHZ

echo "--> clumping"

sbatch --wait clump.sb
(
  grep CHR $rt/*.clumped | \
  head -1
  grep -v CHR $rt/*.clumped
) | \
sed 's|'"$rt"'/||g;s/.clumped://g' | \
awk '(NF>1){$3="";print}' | \
awk '{$1=$1;if(NR==1)$1="prot";print}' > SomaLogic.clumped
# a panel similar to inf1 needs to be set up below
R --no-save -q <<END
  require(gap)
  clumped <- read.table("SomaLogic.clumped",as.is=TRUE,header=TRUE)
  hits <- merge(clumped[c("CHR","BP","SNP","prot")],inf1[c("prot","uniprot")],by="prot")
  names(hits) <- c("prot","Chr","bp","SNP","uniprot")
  cistrans <- cis.vs.trans.classification(hits)
  sink("SomaLogic.clumped.out")
  with(cistrans,table)
  sink()
  sum(with(cistrans,table))
  pdf("SomaLogic.circlize.pdf")
  circos.cis.vs.trans.plot(hits="SomaLogic.clumped")
  dev.off()
END
(
awk 'NR>1' SomaLogic.clumped | \
cut -d' ' -f1,3 | \
parallel -j2 -C' ' '
  export direction=$(zgrep -w {2} METAL/{1}-1.tbl.gz | cut -f13)
  echo $direction
  let j=1
  for i in $(grep "Input File" METAL/{1}-1.tbl.info | cut -d" " -f7)
  do
     export n=$(awk -vj=$j "BEGIN{split(ENVIRON[\"direction\"],a,\"\");print a[j]}")
     if [ "$n" != "?" ]; then
        echo $i
        zgrep -w {2} $i
     fi
     let j=$j+1
  done
'
) > SomaLogic.clumped.all
