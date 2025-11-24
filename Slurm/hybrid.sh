#!/bin/bash
#SBATCH -J Hybrid_JOB
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --ntasks=4          # number of tasks
#SBATCH --mem-per-cpu=4G  # memory/cpu 
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads
module load intel/intel-2015a
srun /sNow/utils/bin/pi_hybrid
