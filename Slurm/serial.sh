#!/bin/bash
#SBATCH -J Serial_Job
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mem-per-cpu=8G  # memory/cpu 
srun sleep 30
srun echo "My first serial Slurm job"
