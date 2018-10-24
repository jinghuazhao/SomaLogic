# Code to immitate Qiong Yang's MDCs_GWASfile_rename.R

pan <- read.csv("MalmoProteomicsKeyCleaned_tab1.csv",as.is=TRUE)
pan <- within(pan, {
   aptamer <- gsub("-","",SeqId..no.underscore)
   mdcProtein <- Malmo.Name
})
dim(pan)

mdc <- "/scratch/jhz22/box/Malmo"
mdc2 <- "/scratch/jhz22/box/FHS"
mdc.file <- dir(mdc) #1304 files; 1250 are proteins
mdc.lnk <- data.frame(cbind(mdc.file,gsub("_summary.csv.gz", "",gsub("zln","",mdc.file))))
names(mdc.lnk)[2] <- "mdcProtein"

pan.mdc <- merge(mdc.lnk,pan,by="mdcProtein",all.x=T)
summary(as.numeric(with(pan,aptamer)))
table(duplicated(with(pan.mdc, TargetName))) #no duplicated entry

sh <- "MDCs.sh"
txt <- "MDCs.tsv"
unlink(sh)
unlink(txt)
ord <- with(pan.mdc,order(SeqId..no.underscore))
with(pan.mdc[ord,], for (j in 1:nrow(pan.mdc))
{
   mf <- as.character(mdc.file[j])
   mf.pid <- paste("X_",aptamer[j],".txt.gz",sep="")
   cat(FHS_seq_ID[j], SeqId..no.underscore[j], Malmo.Name[j],aptamer[j],"\n",file=txt,append=TRUE,sep="\t")
   cmd <- paste("ln -sf ", "Malmo/", mf," ","FHS/",mf.pid,sep="")
   cat(cmd,"\n",file=sh,append=TRUE)
})
