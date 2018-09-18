# 18-9-2018 JHZ

#  Reformatting files into directories

export box=/scratch/jhz22/box

# FHS

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

# KORA
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

# Malmo
# gunzip -c $box/gunzip -c Malmo/zlnX6Phosphogluconatedehydrogenase_summary.csv.gz | \
# head -1 | awk '{gsub(/,/,"\n");print}' | awk '{OFS="\t";print "#" NR,$1}' > ~/1

#1	SNP
#2	chr
#3	position
#4	coded
#5	ref
#6	beta_b1
#7	beta_b2
#8	se_b1
#9	se_b2
#10	p_b1
#11	p_b2
#12	n_b1
#13	n_b2
#14	beta_meta
#15	se_meta
#16	p_meta
#17	n
#18	af_coded_b1
#19	maf_b1
#20	af_coded_b2
#21	maf_b2

# QMDiab
# See KORA above
