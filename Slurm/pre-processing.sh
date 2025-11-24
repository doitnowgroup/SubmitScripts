#!/bin/bash
#SBATCH -J Pre-ProcessingJob
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mem-per-cpu=8G  # memory/cpu 
srun echo "Pre-Processing done. Run the job dependencies"
