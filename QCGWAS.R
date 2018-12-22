# 22-12-2018 JHZ

library(QCGWAS)

prot <- Sys.getenv("p")
src <- "FHS"
src_in <- paste(src, prot, "gz", sep=".")
src_out <- paste(src, prot, sep=".")
studies <- c("FHS", "KORA", "Malmo", "QMDiab")
QC_in <- paste(studies, prot, "gz", sep=".")
QC_out <- paste(studies, prot, sep=".")
header_translations <- read.delim("doc/header_translations.tsv",as.is=TRUE)

src_qc <- QC_GWAS(src_in,
	filename_output = src_out,
	dir_data = "sumstats/work",
	dir_output = paste0("work/",prot),
	dir_references = "/scratch/jhz22/data/1KG",
	header_translations = header_translations,
	save_final_dataset = FALSE,
	HQfilter_FRQ = 0.01,
	HQfilter_imp = 0.3,
	QQfilter_FRQ = c(NA, 0.01, 0.03, 0.05, 3),
	QQfilter_imp = c(NA, 0.3, 0.5, 0.7, 0.9),
	NAfilter = TRUE,
	allele_ref_std = "1KGp3v5.RData",
	allele_name_std = "1000G",
	remove_mismatches = TRUE,
	allele_ref_alt = NULL,
	allele_name_alt = "alternative",
	update_alt = TRUE,    
	update_savename = "ref_alternative",
	update_as_rdata = TRUE)
src_qc

QC_series(data_files = QC_in,
	dir_data = "sumstats/work",
	dir_output = paste0("work/",prot),
	dir_references = "/scratch/jhz22/data/1KG",
	output_filenames = QC_out,
	header_translations = header_translations,
	save_final_dataset = FALSE,
	HQfilter_FRQ = 0.01,
	HQfilter_imp = 0.3,
	QQfilter_FRQ = c(NA, 0.01, 0.03, 0.05, 3),
	QQfilter_imp = c(NA, 0.3, 0.5, 0.7, 0.9),
	NAfilter = TRUE,
	allele_ref_std = "1KGp3v5.RData",
	allele_name_std = "1000G",
	remove_mismatches = TRUE,
	allele_ref_alt = "ref_alternative.RData",
	allele_name_alt = "alternative",
	update_alt = TRUE,
	update_savename = "ref_alternative",
	update_as_rdata = TRUE)
