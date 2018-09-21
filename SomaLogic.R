# 21-9-2018 JHZ
# Generation of auxiliary files from curated databases

# Sequence data for the Somalogic SOMAscan assay
# Comments - it is sensible to work with SeqID to avoid uncertainty in UniProt ID at this stage

## from Bioconductor
setwd("doc")
library(readat)
vars <- c("AptamerId","SomaId","Target","TargetFullName","UniProt","EntrezGeneID","EntrezGeneSymbol")
write.table(aptamers[vars],file="aptamers.txt",quote=FALSE,row.names=FALSE,sep="\t")
chrpos <- as.data.frame(chromosomalPositions)
vars <- c("group","group_name","AptamerId","UniProt","EntrezGeneID")
write.table(chrpos[vars],file="chrpos.txt",quote=FALSE,row.names=FALSE,sep="\t")
ord <- with(aptamers,order(AptamerId))
UniProt <- aptamers[ord,c("AptamerId","UniProt")]
write.table(UniProt,file="UniProt.txt",quote=FALSE,row.names=FALSE,col.names=FALSE,sep="\t")
## from Jimmy|/scratch/public_databases/SOMALOGIC/LatestVersion
m <- read.delim(paste0("SOMALOGIC_Master_Table_160410_1129info.tsv"),as.is=TRUE)
sl <-merge(m,aptamers[c("AptamerId","Units","IsIn1310Panel","IsIn1129Panel","PlasmaDilution","SerumDilution")],
           by.x="Seq",by.y="AptamerId")
library(dplyr)
mapt <- left_join(m,aptamers)
## from FHS
pan <-read.csv("MalmoProteomicsKeyCleaned_tab1.csv",as.is=T)
pan <- within(pan, aptamer <-gsub("-","",SeqId..no.underscore))
dim(pan)
require(xlsx)
x <- "170724- List of uniprot, target, aptamer ID info with proteins f....xls"
map <- read.xlsx(x,sheetName="Proteins")
dim(map)
map <- within(map,aptamer2 <- gsub("_","",as.character(aptamer2)))
ord <- with(map,order(as.character(aptamer2)))
write.table(map[ord,c("aptamer2","SeqId")],file="FHS.txt",quote=FALSE,row.names=FALSE,col.names=FALSE,sep="\t")
