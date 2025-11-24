#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
################################################################
#SBATCH -J FLUENT_REQUEUE
#SBATCH -A hpcnow           # Project Account
#SBATCH --time=01:03:00     # Walltime
#SBATCH --ntasks=48         # number of tasks
#SBATCH --mem-per-cpu=4G    # memory/cpu 
#SBATCH -C sb
#SBATCH -p requeue
################################################################
###  Load the Environment
module load ANSYS/15.0
cd /sNow/test/ansys/fluent/case3/input/
### Creating the hostfile
srun hostname > FLUENT_HOSTFILE
### Run Fluent Model
fluent -v3ddp -g -t $SLURM_NTASKS -mpi=pcmpi -cnf=FLUENT_HOSTFILE -pinfiniband -ssh << EOFluentInput > stats-$SLURM_NTASKS-$SLURM_JOBID.out
  rc a16.cas
  rd fluent-1-12000.dat
  /solve/dual-time-iterate 10 10
  /file/write-case-data a16-$SLURM_NTASKS-$SLURM_JOBID.out
  exit
EOFluentInput
################################################################
