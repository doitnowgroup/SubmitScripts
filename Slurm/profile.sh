#!/bin/bash
#SBATCH -J Slurm-Profiler
#SBATCH -A hpcnow
##SBATCH --time=24:00:00     # Walltime
#SBATCH --time=00:15:00     # Walltime
#SBATCH --mem-per-cpu=8G  # memory/cpu 
#SBATCH --cpus-per-task=4   # 4 OpenMP Threads
srun --profile=task stress --vm 4 --vm-bytes 2GB --timeout 900s
