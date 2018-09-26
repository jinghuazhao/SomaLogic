#!/bin/bash --login
#SBATCH -n 1
#SBATCH -o array.%J
#SBATCH -a 1-40

function module ()
{
  eval `/usr/bin/modulecmd bash $*`
}

module purge
module load parallel/20131222

# Define srun arguments:
srun="/usr/local/Cluster-Apps/slurm/bin/srun -n1 -N1 --exclusive"

# Define parallel arguments:
parallel="parallel -N 1 --delay .2 -j $SLURM_NTASKS --joblog array.joblog --resume"

$parallel "$srun ./array.subs {1} {2}" ::: FHS KORA Malmo QMDiab ::: $SLURM_ARRAY_TASK_ID
