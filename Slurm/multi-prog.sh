#!/bin/bash
#SBATCH -J MasterSlave
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --ntasks=48         # number of tasks
#SBATCH --mem-per-cpu=1G  # memory/cpu 
srun --multi-prog multi.conf
