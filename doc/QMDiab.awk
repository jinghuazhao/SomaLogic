{
  if (NR==1) print "SNPID","CHR","POS","STRAND","N","EFFECT_ALLELE","REFERENCE_ALLELE","CODE_ALL_FREQ","BETA","SE","PVAL","RSQ","RSQ_IMP","IMP"
  else print $2,$1,$3,"+",$4,"A2","EAF",$7,"SE",$9,"RSQ","RSQ_IMP","IMP"
}
