#!/bin/bash
######################################################
#SBATCH -J STRESS_TEST
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=12:00:00     # Walltime
#SBATCH --mem-per-cpu=4G  # memory/cpu 
#SBATCH --cpus-per-task=12  # 12 OpenMP Threads
#SBATCH --nodes=1           # number nodes
######################################################
###  Load the Environment
######################################################
cd $SHM_DIR
#srun stress -v --cpu 12 --vm 12 --vm-bytes 4096M --timeout 1800s
srun stress -v --cpu 12 
######################################################
