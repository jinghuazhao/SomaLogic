# 3-8-2020 JHZ

somalogic <- read.delim("SOMALOGIC_Master_Table_160410_1129info.tsv",as.is=TRUE)
gwas <- read.csv("SOMALOGIC_GWAS_protein_info.csv",as.is=TRUE)
vars <- c("SOMAS_ID_round2", "UniProt",
          "chromosome_number","start_position","end_position","EntrezGeneSymbol","ensembl_gene_id","external_gene_name")
chrs <- c(paste(1:22),"X","Y")
library(reshape)
gwas <- rename(gwas,c(UniProt="UniProts"))
somalogic <- rename(subset(somalogic[vars],chromosome_number%in%chrs),
                  c(chromosome_number="chr",start_position="start",end_position="end",
                    EntrezGeneSymbol="symbol",ensembl_gene_id="ensGene",external_gene_name="extGene"))
gs <- unique(merge(gwas,somalogic,by.x="SOMAMER_ID",by.y="SOMAS_ID_round2"))
out <- c("chr","start","end","ensGene","UniProt","symbol","TargetFullName","extGene","Target","UniProts","SOMAMER_ID")
ord <- with(gs,order(chr,start,end))
write.table(gs[ord,out],file="INTERVAL-box.tsv",quote=FALSE,row.names=FALSE,sep="\t")