# 31-12-2018 JHZ

export rt=$HOME/SomaLogic
(
  echo -e "chrom\tstart\tend\tgene\tprot"
  sort -k2,2 $rt/inf1.list > inf1.tmp
  cut -f2,3,7-10 $rt/doc/olink.inf.panel.annot.tsv  | \
  awk -vFS="\t" -vOFS="\t" '(NR>1){
      gsub(/\"/,"",$0)
      if($2=="Q8NF90") $3="FGF5"
      if($2=="Q8WWJ7") $3="CD6"
      print
  }' | \
  sort -t$'\t' -k2,2 | \
  join -t$'\t' -j2 inf1.tmp - | \
  awk -vFS="\t" -vOFS="\t" '{print $5,$6,$7,$4,$2}' | \
  sort -k1,1n -k2,2n
) > st.bed

sbatch qml.sb
