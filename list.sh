# 17-9-2018 JHZ

# Generation of file list and directory

R --no-save <<END
library(readat)
write.table(aptamers,file="/home/jhz22/work/aptamers.txt",quote=FALSE,row.names=FALSE,sep="\t")
END
