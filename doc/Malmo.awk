{

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
}
