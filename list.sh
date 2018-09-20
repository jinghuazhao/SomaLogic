# 20-9-2018 JHZ
# Generation of file lists and directories

# Sequence data for the Somalogic SOMAscan assay
# Comments - it is sensible to work with Aptamer ID to avaoid uncertainty in UniProt ID at this stage

R --no-save <<END
library(readat)
vars <- c("AptamerId","SomaId","Target","TargetFullName","UniProt","EntrezGeneID","EntrezGeneSymbol")
write.table(aptamers[vars],file="aptamers.txt",quote=FALSE,row.names=FALSE,sep="\t")
chrpos <- as.data.frame(chromosomalPositions)
vars <- c("group","group_name","AptamerId","UniProt","EntrezGeneID")
write.table(chrpos[vars],file="chrpos.txt",quote=FALSE,row.names=FALSE,sep="\t")
ord <- with(aptamers,order(AptamerId))
UniProt <- aptamers[ord,c("AptamerId","UniProt")]
write.table(UniProt,file="UniProt.txt",quote=FALSE,row.names=FALSE,col.names=FALSE,sep="\t")
END

export box=/scratch/jhz22/box
export sumstats=/scratch/jhz22/sumstats
mkdir $sumstats
cd $sumstats
mkdir FHS INTERVAL KORA Malmo QMDiab
cd -

# FHS, 1118 items, 16m imputed genotypes by "-"-stripped AptamerId

ls $box/FHS | sed 's/X_//g;s/.txt.gz//g' | sort -k1,1 > $sumstats/FHS.list

R --no-save <<END
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
END

# INTERVAL, A1CF results for imputed genotypes by chromosome

ls $box/INTERVAL/A1CF.12423.38.3/ | sed 's/12423.38.3_chrom_//g;s/_meta_final_v1.tsv.gz//g' > $sumstats/INTERVAL.list

# KORA, 1131 panel, PLINK outputs on 8m imputed genotypes by AptamerId

ls $box/KORA | sed 's/KORA_pGWAS.//g;s/.assoc.linear.gz//g' | awk 'NR>2' > $sumstats/KORA.list

# Malmo, 1306 panel, 15m imputed genotypes by EntrezGeneSymbol

ls $box/Malmo | sed 's/^zln//g;s/_summary.csv.gz//g' | sort -k1,1 > $sumstats/Malmo.list

# QMDiab, PLINK outputs (4+1141) 20m imputed genotypes by AptamerId

ls $box/QMDiab/PGWAS_Results | \
sed 's/QMDiab_pGWAS.//g;s/.assoc.linear.gz//g;s/.assoc.linear//g' | awk 'NR>2' > $sumstats/QMDiab.list
