{
#1	MarkerName: chr:pos (:<ref>_<nonref> for indels)
#2	Allele1: (please ignore this column)
#3	Allele2: (please ignore this column)
#4	Beta: effect size (from meta analyze two FHS batch samples)
#5	StdErr: standard error of Beta
#6	P.value: p-value of testing Beta=0
#7	Direction: the effect size direction of two FHS batches
#8	InGene(s): SNP in any gene
#9	NearestGene(s): Nearest gene to the SNP
#10	DistanceToNearestGene(s): distance of the SNP to nearest gene
#11	GenesWithin60kb: genes within 60,000 basepair of the SNP
#12	chr: chromosome (hg19)
#13	pos: basepair position (hg19)
#14	rs: rsID
#15	effect: effect allele for Beta
#16	noneffect: noneffect allele for Beta
#17	ref_eaf: effect allele frequency in reference sample
#18	obs_eaf: effect allele frequency in observed sample
#19	obs_var: observed variance of the genotype score
#20	exp_var: expected variance of the genotype score
#21	oevar: the ratio of obs_var to exp_var, an indicator of imputation quality
#22	ratio: equivalent to oevar but compute slightly different
#23	MarkerName2: SNP ID in the format chromosome:position(:I, D,R for indels)
#24	seg:(please ignore this column)
  if (NR==1) print "SNPID","CHR","POS","STRAND","N","EFFECT_ALLELE","REFERENCE_ALLELE","CODE_ALL_FREQ","BETA","SE","PVAL","RSQ","RSQ_IMP","IMP"
  else print $14,$12,$13,"STRAND","N",$15,$16,$18,$4,$5,$6,"RSQ",$21,"IMP"
  
}
