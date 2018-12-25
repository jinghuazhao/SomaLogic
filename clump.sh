# 25-12-2018 JHZ

echo "--> clumping"

export rt=$HOME/SomaLogic/METAL
ls METAL/*tbl.gz | \
sed 's/-1.tbl.gz//g' | \
xargs -l basename | \
parallel -j2 --env rt -C' ' '
if [ -f $rt/{}.clumped ]; then rm $rt/{}.clumped; fi; \
plink --bfile /scratch/jhz22/data/INTERVAL/INTERVAL \
      --clump $rt/{}-1.tbl.gz \
      --clump-snp-field MarkerName \
      --clump-field P-value \
      --clump-kb 500 \
      --clump-p1 5e-10 \
      --clump-p2 0.01 \
      --clump-r2 0 \
      --mac 50 \
      --out $rt/{}
'
(
  grep CHR $rt/*.clumped | \
  head -1
  grep -v CHR $rt/*.clumped
) | \
sed 's|'"$rt"'/||g;s/.clumped://g' | \
awk '(NF>1){$3="";print}' | \
awk '{$1=$1;if(NR==1)$1="prot";print}' > SomaLogic.clumped
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
