#!/bin/bash
# 25-3-2030 JHZ
# Reformatting files into directories

function module ()
{
  eval `/usr/bin/modulecmd bash $*`
}

# module load parallel/20131222
# This version has problem with TEMPDIR, https://stackoverflow.com/questions/24398941/gnu-parallel-unlink-error
# The lastest is here, http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2

## raw and reformatted SUMSTATS
export SomaLogic=/home/jhz22/SomaLogic
export box=$SomaLogic/box
export sumstats=$SomaLogic/sumstats
export threads=4

## Each cohort is formatted and output with its AWK program.
## block size can be refined
export bs=27

function FHS()
{
  echo --- FHS ---
  cat $sumstats/FHS.list | \
  parallel -j$threads -C' ' --env box --env sumstats 'gunzip -c $box/FHS/X_{1}.txt.gz | \
  awk -vFS="," -vOFS="\t" -f doc/FHS.awk | \
  sort -k2,2n -k3,3n | \
  awk -f doc/order.awk | \
  gzip -f > $sumstats/FHS/FHS.{2}.txt.gz'
}

function INTERVAL()
{
  echo -- INTERVAL --
  export snpstats=${box}/INTERVAL/box/round_all_chrom_merged_lite_INFO.snpstats
  seq 22 | \
  parallel -C' ' -j${threads} --env SomaLogic --env snpstats --env sumstats \
                 'awk -v chr={} -f ${SomaLogic}/doc/INTERVAL.awk ${snpstats} > ${sumstats}/INTERVAL.{}.snpstats'
  cat $sumstats/INTERVAL.list | \
  parallel -j$threads -C' ' --env box --env sumstats '
  (
    awk -v OFS="\t" "BEGIN{
      print \"SNPID\",\"CHR\",\"POS\",\"STRAND\",\"N\",\"EFFECT_ALLELE\",\"REFERENCE_ALLELE\",\"CODE_ALL_FQ\",\"BETA\",\"SE\",\"PVAL\",\"RSQ\",\"RSQ_IMP\",\"IMP\"
    }"
    for chr in $(seq 22)
    do
      gunzip -c ${box}/INTERVAL/{1}.{2}/{1}.{2}_chrom_${chr}_meta_final_v1.tsv.gz | \
      awk "NR > 1 {
        CHR=\$2
        POS=\$3
        A1=toupper(\$4)
        A2=toupper(\$5)
        if(A1<A2) {A1A2=\"_\" A1 \"_\" A2} else {A1A2=\"_\" A2 \"_\" A1}
        SNPID=\"chr\" CHR \":\" POS A1A2
        STRAND=\"NA\"
        N=3301
        EFFECT_ALLELE=\$4
        REFERENCE_ALLELE=\$5
        BETA=\$6
        SE=\$7
        PVAL=10^\$8
        print SNPID,CHR,POS,STRAND,N,A1,A2,BETA,SE,PVAL
      }" | \
      join - ${sumstats}/INTERVAL.${chr}.snpstats | \
      awk -v OFS="\t" "{
        if(\$6==\$11) {EAF=\$13} else {EAF=1-\$13}
        if(\$14>0.3) print \$1,\$2,\$3,\$4,\$5,\$6,\$7,EAF,\$8,\$9,\$10,\"NA\",\$14,\"NA\"
      }"
    done
  ) | \
  gzip -f > $sumstats/INTERVAL/INTERVAL.{3}.txt.gz'
}

function KORA()
{
  echo --- KORA ---
  cat $sumstats/KORA.list | \
  parallel -j$threads -C' ' --env box --env sumstats 'gunzip -c $box/KORA/KORA_pGWAS.{}.assoc.linear.gz | \
  sort -k2,2 | \
  join -j2 - $sumstats/KORA.bim | \
  awk -vOFS="\t" -f doc/KORA.awk | \
  sort -k2,2n -k3,3n | \
  awk -f doc/order.awk | \
  gzip -f > $sumstats/KORA/KORA.{}.txt.gz'
}

function Malmo()
{
  cat $sumstats/Malmo.list | \
  parallel -j$threads -C' ' --env box --env sumstats 'gunzip -c $box/Malmo/zln{1}_summary.csv.gz | \
  awk -vFS="," -vOFS="\t" -f doc/Malmo.awk | \
  sort -k2,2n -k3,3n | \
  awk -f doc/order.awk | \
  gzip -f > $sumstats/Malmo/Malmo.{2}.txt.gz'
}

function QMDiab()
{
  echo -- QMDiab ---
  export src=$box/QMDiab/PGWAS_Results
  cat $sumstats/QMDiab.list | \
  parallel -j$threads -C' ' --env src --env sumstats 'gunzip -c $src/QMDiab_pGWAS.{}.assoc.linear.gz | \
  sort -k2,2 | \
  join -j2 - $sumstats/QMDiab.bim | \
  awk -vOFS="\t" -f doc/QMDiab.awk | \
  sort -k2,2n -k3,3n | \
  awk -f doc/order.awk | \
  gzip -f > $sumstat/QMDiab/QMDiab.{}.txt.gz'
}

function TwinsUK()
{
  echo -- TwinsUK --
  export src=$box/TwinsUK
  cat $sumstats/TwinsUK.list | \
  parallel -j$threads -C' ' --env src --env sumstats '
  (
    awk -v OFS="\t" "BEGIN{
      print \"SNPID\",\"CHR\",\"POS\",\"STRAND\",\"N\",\"EFFECT_ALLELE\",\"REFERENCE_ALLELE\",\"CODE_ALL_FQ\",\"BETA\",\"SE\",\"PVAL\",\"RSQ\",\"RSQ_IMP\",\"IMP\"
    }"
    for chr in $(seq 22)
    do
      awk -v OFS="\t" "NR > 1 {
        CHR=\$1
        POS=\$3
        A1=toupper(\$5)
        A2=toupper(\$6)
        if(A1<A2) {A1A2=\"_\" A1 \"_\" A2} else {A1A2=\"_\" A2 \"_\" A1}
        SNPID=\"chr\" CHR \":\" POS A1A2
        STRAND=\"NA\"
        N=91
        EFFECT_ALLELE=\$5
        REFERENCE_ALLELE=\$6
        CODE_ALL_FQ=\$7
        BETA=\$8
        SE=\$9
        PVAL=\$14
        RSQ=\"NA\"
        RSQ_IMP=\"NA\"
        IMP="NA"
        print SNPID,CHR,POS,STRAND,N,EFFECT_ALLELE,REFERENCE_ALLELE,CODE_ALL_FQ,BETA,SE,PVAL,RSQ,RSQ_IMP,IMP
      }" ${src}/protein_{1}_HRC_r1.1_TUK_chr${chr}_GEMMA.assoc.txt
    done
  ) | \
  gzip -f > $sumstats/TwinsUK/TwinsUK.{2}.txt.gz'
}

# ln -sf $HPC_WORK/work $HOME/tmp
export TMPDIR=/home/jhz22/tmp
$1
