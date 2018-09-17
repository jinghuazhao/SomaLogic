# 17-9-2018 JHZ

# Generation of file list and directory

# Sequence data for the Somalogic SOMAscan assay
R --no-save <<END
library(readat)
write.table(aptamers,file="/home/jhz22/work/aptamers.txt",quote=FALSE,row.names=FALSE,sep="\t")
chrpos <- as.data.frame(chromosomalPositions)
write.table(chrpos,file="/home/jhz22/work/chrpos.txt",quote=FALSE,row.names=FALSE,sep="\t")
END
