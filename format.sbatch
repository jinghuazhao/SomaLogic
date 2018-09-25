#!/bin/bash

export format=$HOME/SomaLogic/format.subs
export P=short

declare -a cohorts=(FHS KORA Malmo QMDiab)
for s in $(seq 1 ${#cohorts[@]})
do
   export study=${cohorts[$(( $s-1 ))]}
   export joblist=`squeue -u $USER --noheader -o "%i" | sed -n '1h;2,$H;${g;s/\n/:/g;p}'`
   echo $study
   if [ $s -eq 1 ]
   then
      id=$(sbatch -J $study -p $P -a 1-40 -e $study.e -o $study.o -D $PWD --export=ALL $format)
   else
#     sbatch -p $P -a 1-40 -e $study.e -o $study.o -D $PWD --export=ALL -d after:$joblist $format
      id=$(sbatch -J $study -p $P -a 1-40 -e $study.e -o $study.o -D $PWD --export=ALL -d afterok:$id $format)
   fi
done

# SGE to SLURM conversion, https://srcc.stanford.edu/sge-slurm-conversion
# delete SGE jobs shown in qstat, qstat | grep $USER | cut -d. -f1 | xargs qdel, qdel {id1..id2}
# SLURM documentation, https://slurm.schedmd.com/
# sinfo - view information about Slurm nodes and partitions
# squeue - view information about jobs located in the Slurm scheduling queue, squeue -u $USER -r; qstat -u $USER
# dependency, https://hpc.nih.gov/docs/job_dependencies.html
# Examples, https://github.com/statgen/SLURM-examples
