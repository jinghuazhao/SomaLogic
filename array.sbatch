#!/bin/bash --login
#SBATCH -n 1
#SBATCH -a 1-10
#SBATCH -o array.%A
#SBATCH -P long
#SBATCH --export ALL

function module ()
{
  eval `/usr/bin/modulecmd bash $*`
}

module purge
module load parallel/20131222

# Define srun arguments:
srun="/usr/local/Cluster-Apps/slurm/bin/srun -n1 -N1 --exclusive"

# Define parallel arguments:
parallel="parallel -N 1 --delay .2 -j $SLURM_NTASKS"

$parallel "$srun array.subs {}" ::: FHS KORA Malmo QMDiab

# Multi-threaded tasks, http://portal.hpcwales.co.uk/wordpress/index.php/index/slurm/interactive-use-job-arrays/batch-submission-of-serial-jobs-for-parallel-execution/
##SBATCH --nodes=3
##SBATCH --ntasks-per-node=3
##SBATCH --cpus-per-task=4
