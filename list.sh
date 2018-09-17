# 17-9-2018 JHZ

# Generation of file list and directory

# Sequence data for the Somalogic SOMAscan assay
R --no-save <<END
library(readat)
write.table(aptamers,file="/home/jhz22/work/aptamers.txt",quote=FALSE,row.names=FALSE,sep="\t")
chrpos <- as.data.frame(chromosomalPositions)
write.table(chrpos,file="/home/jhz22/work/chrpos.txt",quote=FALSE,row.names=FALSE,sep="\t")
END

export box=/scratch/jhz22/box

# FHS

ls $box/FHS | sed 's/X_//g;s/.txt.gz//g'

# INTERVAL

ls $box/INTERVAL/A1CF.12423.38.3/ | sed 's/12423.38.3_chrom_//g;s/_meta_final_v1.tsv.gz//g'

# KORA

ls $box/KORA | sed 's/KORA_pGWAS.//g;s/.assoc.linear.gz//g'

# Malmo

ls $box/Malmo | sed 's/^zln//g;s/_summary.csv.gz//g'

# QMDiab

ls $box/QMDiab $box/QMDiab/PGWAS_Results | sed 's/QMDiab_pGWAS.//g;s/.assoc.linear.gz//g;s/.assoc.linear//g'
