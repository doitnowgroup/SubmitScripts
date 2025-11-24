#!/bin/bash
######################################################
#SBATCH -J JobName
##SBATCH -A <account>          # Project Account
#SBATCH --time=00:10:00        # Walltime
#SBATCH --mem-per-cpu=1G     # memory/cpu 
#SBATCH -a 1-96                # array of 96 jobs
#SBATCH -n 1                   # 1 core means serial
######################################################
###  Run the Parallel Program
srun echo "hello from SLURM_ARRAY_TASK_ID : $SLURM_ARRAY_TASK_ID"
srun sleep 10
