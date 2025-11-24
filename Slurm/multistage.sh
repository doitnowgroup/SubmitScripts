#!/bin/bash
#SBATCH -J OpenMP_JOB
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mem-per-cpu=8G  # memory/cpu 
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads
srun openmp_binary stage1.dat
srun openmp_binary stage2.dat
srun openmp_binary stage3.dat
srun openmp_binary stage4.dat
srun openmp_binary stage5.dat
srun openmp_binary stage6.dat
srun openmp_binary stage7.dat
srun openmp_binary stage7.dat
