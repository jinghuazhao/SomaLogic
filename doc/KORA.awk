{

# gunzip -c KORA/KORA_pGWAS.4292-5_3.assoc.linear.gz | head -1 > ~/1

#1	CHR
#2	SNP
#3	BP
#4	A1
#5	TEST
#6	NMISS
#7	BETA
#8	STAT
#9	P
  if (NR==1) print "SNPID","CHR","POS","STRAND","N","EFFECT_ALLELE","REFERENCE_ALLELE","CODE_ALL_FREQ","BETA","SE","PVAL","RSQ","RSQ_IMP","IMP"
  else print $2,$1,$3,"+",$4,"A2","EAF",$7,"SE",$9,"RSQ","RSQ_IMP","IMP"
}
