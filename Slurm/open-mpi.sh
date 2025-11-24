#!/bin/bash
#SBATCH -J MPI_JOB
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=10:00:00     # Walltime
#SBATCH --ntasks=96         # number of tasks
#SBATCH --mem-per-cpu=1G  # memory/cpu 
ml load OpenMPI/1.6.5-GCC-4.8.2
srun /sNow/training/slurm/bin/pi_openmpi-1.6.5-GCC-4.8.2
