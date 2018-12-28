#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --job-name=CLUMP
#SBATCH --time=4:00:00
#SBATCH --cpus-per-task=8
#SBATCH --partition=short
#SBATCH --array=1-1381
#SBATCH --output=work/CLUMP_%A_%a.out
#SBATCH --error=work/CLUMP_%A_%a.err
#SBATCH --export ALL

. /etc/profile.d/modules.sh
module load default-cardio
module load slurm
module load use.own

export p=$(awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]' doc/SomaLogic.list)
export TMPDIR=/scratch/jhz22/tmp
export rt=$HOME/SomaLogic/METAL

echo ${p}
if [ -f $rt/${p}.clumped ]; then rm $rt/${p}.clumped; fi
plink --bfile /scratch/jhz22/data/INTERVAL/INTERVAL \
      --exclude range doc/high-LD-regions-hg19.txt \
      --clump $rt/${p}-1.tbl.gz \
      --clump-snp-field MarkerName \
      --clump-field P-value \
      --clump-kb 500 \
      --clump-p1 5e-10 \
      --clump-p2 0.01 \
      --clump-r2 0 \
      --mac 50 \
      --out $rt/${p}
