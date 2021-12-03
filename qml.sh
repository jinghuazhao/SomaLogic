# 26-3-2020 JHZ

export rt=$HOME/SomaLogic
(
  echo -e "chrom\tstart\tend\tgene\tprot"
  grep -f ${rt}/doc/SomaLogic.list ${rt}/doc/SOMALOGIC_Master_Table_160410_1129info.tsv | \
  awk -vFS="\t" -vOFS="\t" '($15=="X"||$15=="Y"||($15!="X" && $15!="Y" && $15>0 && $15<23)){print $15,$16,$17,$4}' | \
  sort -k1,1n -k2,2n
) > st.bed

cat ${rt}/doc/SomaLogic.list | \
parallel -j1 -C' ' '
(
   echo -e "MarkerName\tP-value\tWeight"
   grep -w {} st.bed | \
   awk -vOFS="\t" -vM=1000000 "{start=\$2-M;if(start<0) start=0;end=\$3+M;\$2=start;\$3=end};1" > st.tmp; \
   read chrom start end gene prot < st.tmp; \
   gunzip -c METAL/{}-1.tbl.gz | \
   awk -vOFS="\t" -vchr=$chrom -vstart=$start -vend=$end "(\$1 == chr && \$2 >= start && \$2 <= end){split(\$3,a,\"_\");print a[1],\$12,\$18}"
)  > METAL/{}.lz
grep -w {} st.bed | \
awk -vOFS="\t" -vM=1000000 "{start=\$2-M;if(start<0) start=0;end=\$3+M;\$2=start;\$3=end};1" > st.tmp; \
read chrom start end gene prot < st.tmp; \
cd METAL; \
rm -f ld_cache.db; \
locuszoom --source 1000G_Nov2014 --build hg19 --pop EUR --metal {}.lz \
          --plotonly --chr $chrom --start $start --end $end --no-date --rundir .; \
mv chr${chrom}_${start}-${end}.pdf {}.lz.pdf; \
pdftopng -r 300 {}.lz.pdf {}; \
mv {}-000001.png {}.lz-1.png; \
mv {}-000002.png {}.lz-2.png; \
cd -
'

sbatch qml.sb

# convert OPG.lz-1.png -resize 130% OPG.lz-3.png
# convert \( OPG.qq.png -append OPG.manhattan.png -append OPG.lz-3.png -append \) +append OPG-qml.png
