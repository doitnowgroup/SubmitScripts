#!/bin/bash
#SBATCH -J Serial_Job
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=00:10:00     # Walltime
#SBATCH --mem-per-cpu=4G  # memory/cpu 
#SBATCH --cpus-per-task=5 
module load MATLAB/R2012b
srun matlab -nodesktop -nosplash -r myLu
