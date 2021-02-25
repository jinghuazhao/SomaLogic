#!/usr/bin/bash

library(dplyr)
somalogic <- read.delim("SOMALOGIC_Master_Table_160410_1129info.tsv",as.is=TRUE) %>%
             filter(chromosome_number %in% c(1:22,"X","Y")) %>%
             select(SOMAS_ID_round2, UniProt, 
                    chromosome_number,start_position,end_position,
                    EntrezGeneSymbol,ensembl_gene_id,external_gene_name) %>%
             rename(chr=chromosome_number,
                    start=start_position,
                    end=end_position,
                    symbol=EntrezGeneSymbol,
                    ensGene=ensembl_gene_id,
                    extGene=external_gene_name)
gwas <- read.csv("SOMALOGIC_GWAS_protein_info.csv",as.is=TRUE) %>% rename(UniProtgwas=UniProt)
gs <- unique(merge(gwas,somalogic,by.x="SOMAMER_ID",by.y="SOMAS_ID_round2"))
X <- with(gs,chr=="X")
Y <- with(gs,chr=="Y")
gs[X,"chr"] <- "23"
gs[Y,"chr"] <- "24"
ord <- with(within(gs,{chr=as.integer(chr)}),order(chr,start,end))
vars <- c("chr","start","end","ensGene","UniProt","symbol","TargetFullName","extGene","Target","UniProtgwas","SOMAMER_ID")
gs <- gs[ord,vars]
X <- with(gs,chr=="23")
Y <- with(gs,chr=="24")
gs[X,"chr"] <- "X"
gs[Y,"chr"] <- "Y"
write.table(gs,file="INTERVAL-box.tsv",quote=FALSE,row.names=FALSE,sep="\t")
