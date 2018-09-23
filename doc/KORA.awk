{
  if ($2!="") SNPID=$2; else SNPID=$1 ":" $3
  if (NR==1) print "SNPID","CHR","POS","STRAND","N","EFFECT_ALLELE","REFERENCE_ALLELE","CODE_ALL_FREQ","BETA","SE","PVAL","RSQ","RSQ_IMP","IMP"
  else print SNPID,$1,$3,"NA",$6,$4,"A2","NA",$7,$7/$8,$9,"NA","NA","NA"
}

#1 CHR
#2 SNP
#3 BP
#4 A1
#5 TEST
#6 NMISS
#7 BETA
#8 STAT
#9 P
# ---- from KORA.bim
#10 CHR
#11 0
#12 POS
#13 A1
#14 A2

# gunzip -c KORA/KORA_pGWAS.4292-5_3.assoc.linear.gz | head -1 > ~/1
