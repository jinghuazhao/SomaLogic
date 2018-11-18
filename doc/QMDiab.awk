{
  if (NR==1) print "SNPID","CHR","POS","STRAND","N","EFFECT_ALLELE","REFERENCE_ALLELE","CODE_ALL_FQ","BETA","SE","PVAL","RSQ","RSQ_IMP","IMP"
  else {
    if ($7!="NA" && $8!="NR") print $1,$2,$3,"NA",$6,$14,$4,"NA",$7,$7/$8,$9,"NA","NA","NA";
    else print $1,$2,$3,"NA",$6,$14,$4,"NA",$7,"NA",$9,"NA","NA","NA"
  }
}

# merge of the following two sources,
# --- from .gz
#1 CHR
#2 SNP
#3 BP
#4 A1
#5 TEST
#6 NMISS
#7 BETA
#8 STAT
#9 P
# --- from KORA.bim
#1 CHR
#2 SNP
#3 0
#4 POS
#5 A1
#6 A2
