#!/bin/bash
#SBATCH -J OpenMP_JOB
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mem-per-cpu=8G  # memory/cpu 
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads
srun openmp_binary
