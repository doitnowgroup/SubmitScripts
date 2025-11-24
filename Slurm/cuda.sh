#!/bin/bash
# CUDA SubmitScript
##########################################################################
#SBATCH -J CUDA_JOB
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A hpcnow         # Project Account
#SBATCH --mem-per-cpu=2G  # memory/cpu 
#SBATCH --cpus-per-task=2   # 2 OpenMP Threads
#SBATCH --ntasks=1
#SBATCH --gres=gpu:2
##########################################################################
###  Load the Enviroment Modules 
module load CUDA/5.5
##########################################################################
###  The files will be allocated in the shared FS ($SCRATCH_DIR)
cd $SCRATCH_DIR
##########################################################################
###  Run the Parallel Program
srun cuda_binary
