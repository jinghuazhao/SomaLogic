## UCS

* https://www.hpc.cam.ac.uk/

* [Environment modules](https://www.ch.cam.ac.uk/computing/software/environment-modules)
* [SLURM usage](https://www.ch.cam.ac.uk/computing/slurm-usage)
* [Bright Cluster Management](https://www.ch.cam.ac.uk/computing/files/clusters/cv-admin-manual.pdf))
* [VPN (Virtual Private Network)](https://confluence.medschl.cam.ac.uk/pages/viewpage.action?pageId=12094187)

## SLRUM

* squeue -u $USER
* scontrol show config	
* scontrol show partition
* scontrol show job [jobid]
* sview
* control hold/release/requeue/resume/suspend/update job
* saccount -j jobid

## Array jobs

* https://slurm.schedmd.com/job_array.html

## Cardio

* /scratch/public_databases/SOMALOGIC/LatestVersion/
* http://www.internationalgenome.org/faq/what-strand-are-variants-your-vcf-file/
* /scratch/public_databases/phenoscanner/V2

## Additional notes

```bash
function notes()
{
  #http://portal.hpcwales.co.uk/wordpress/index.php/index/slurm/interactive-use-job-arrays/batch-submission-of-serial-jobs-for-parallel-execution/
  #SBATCH --nodes=3
  #SBATCH --ntasks-per-node=3
  #SBATCH --cpus-per-task=4
  export array=$HOME/SomaLogic/format.subs
  declare -a cohorts=(FHS KORA Malmo QMDiab)
  for s in $(seq 1 ${#cohorts[@]}); do
    export study=${cohorts[$(( $s-1 ))]}
    export joblist=`squeue -u $USER --noheader -o "%i" | sed -n '1h;2,$H;${g;s/\n/:/g;p}'`
    echo $study
    export TMPDIR=/scratch/jhz22/SomaLogic/sumstats/$study
    if [ $s -eq 1 ]
    then
       id=$(sbatch -p long -J $study -a 1-10 -e $study.e -o $study.o -D $PWD --export=ALL $array $study)
    else
  #    sbatch -p long -a 1-10 -e $study.e -o $study.o -D $PWD --export=ALL -d after:$joblist $array
       id=$(sbatch -p long -J $study -a 1-10 -e $study.e -o $study.o -D $PWD --export=ALL -d afterany:$id $array $study)
    fi
  done
}
```
