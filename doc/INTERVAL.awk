($2==chr) {
  CHR=$2
  POS=$3
  A1=$4
  A2=$5
  if(A1<A2) {A1A2="_" A1 "_" A2} else {A1A2="_" A2 "_" A1}
  SNPID="chr" CHR ":" POS A1A2
  print SNPID, A1, A2, $8, $10
}

# head -1 box/INTERVAL/box/round_all_chrom_merged_lite_INFO.snpstats | awk '{gsub(/\t/, "\n",$0)};1'| awk '{print "#" NR, $1}'
#1 SNPID
#2 chromosome
#3 position
#4 A_allele
#5 B_allele
#6 minor_allele
#7 MAF
#8 A_allele_freq
#9 plink_snp_id
#10 INFO
#11 missing_calls
#12 updated_rsid
