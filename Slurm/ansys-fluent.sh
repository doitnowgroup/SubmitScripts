#!/bin/bash
# ANSYS_FLUENT SubmitScript
# Optimized for run parallel job 
######################################################
#SBATCH -J ANSYS_FLUENT_TEST
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=01:03:00     # Walltime
#SBATCH --ntasks=24         # number of tasks
#SBATCH --mem-per-cpu=4G  # memory/cpu 
#SBATCH --nodes=1-2
######################################################
###  Load the Environment
module load ANSYS/15.0

rm FLUENT_HOSTFILE
srun hostname > FLUENT_HOSTFILE
cat FLUENT_HOSTFILE

#########################################################
##  Run the Parallel Program
# the following is a generic command. In order to get this command working
# please decide if you want to run the 2d or 2ddp OR 3d OR 3ddp solver and
# please use ONLY one of the options in the <> shown below
# fluent <2d|2ddp|3d|3ddp> -g -t2
fluent -v3ddp -g -t$SLURM_NTASKS -mpi=pcmpi -cnf=FLUENT_HOSTFILE -pib -ssh << EOFluentInput > output1.stat.dat
  rcd testCase.cas
  /solve/dual-time-iterate 201
  /file/write-case-data cdfiner.out.cas
  exit
EOFluentInput
######################################################
###  Transferring the results to the home directory ($HOME)
