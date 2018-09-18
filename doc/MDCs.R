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
table(duplicated(pan.with(mdc, Target))) #no duplicated entry

sh <- "MDCs.sh"
unlink(sh)
for (j in 1:nrow(pan.mdc))
{
   mf <- with(pan.mdc,mdc.file)[j]
   mf.pid <- paste("X_",with(pan.mdc,aptamer)[j],".summary.csv1.tbl.gz",sep="")
   cmd <- paste("ln -sf ", mdc,"/",mf," ",mdc2,"/",mf.pid,sep="")
   cat(cmd,"\n",file=sh,append=TRUE)
}
