# 22-9-2018 JHZ
# Generation of auxiliary files from curated databases

# Sequence data for the Somalogic SOMAscan assay
# Comments - it is sensible to work with SeqID to avoid uncertainty in UniProt ID at this stage

setwd("doc")
# 1129 and 1310 SOMAscan assays
assay1129 <- read.delim("1129.tsv",as.is=TRUE) # 72, 677 are duplicates
assay1310 <- read.delim("1310.tsv",as.is=TRUE)
setdiff(with(assay1129,SOMAmer.SeqID),with(assay1310,SOMAmer.SeqID))
SOMAmer.SeqID <-unique(c(with(assay1129,SOMAmer.SeqID),with(assay1310,SOMAmer.SeqID)))
length(SOMAmer.SeqID)
cat(sort(SOMAmer.SeqID),sep="\n",file="SomaLogic.list")

# from Jimmy|/scratch/public_databases/SOMALOGIC/LatestVersion
m <- read.delim(paste0("SOMALOGIC_Master_Table_160410_1129info.tsv"),as.is=TRUE)

# from Adam|Bioconductor
library(readat)
aptamers <- within(aptamers, {apt=1})
a <- aptamers[c("SomaId","Units","IsIn1310Panel","IsIn1129Panel","PlasmaDilution","SerumDilution")]
ma <- merge(m,a,by="SomaId")
library(dplyr)
mapt <- left_join(m,aptamers)

# from Qiong on FHS and Malmo
pan <- read.csv("MalmoProteomicsKeyCleaned_tab1.csv",as.is=T)
pan <- within(pan, aptamer <-gsub("-","",SeqId..no.underscore))
dim(pan)
require(xlsx)
x <- "170724- List of uniprot, target, aptamer ID info with proteins f....xls"
map <- read.xlsx(x,sheetName="Proteins")
dim(map)
map <- within(map,aptamer2 <- gsub("_","",as.character(aptamer2)))
ord <- with(map,order(as.character(aptamer2)))
write.table(map[ord,c("aptamer2","SeqId")],file="FHS.tsv",quote=FALSE,row.names=FALSE,col.names=FALSE,sep="\t")
