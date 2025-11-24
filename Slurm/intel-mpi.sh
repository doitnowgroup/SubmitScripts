#!/bin/bash
#SBATCH -J MPI_JOB
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=10:00:00     # Walltime
#SBATCH --ntasks=16         # number of tasks
#SBATCH --mem-per-cpu=1G  # memory/cpu 
module load intel/2015a
srun /sNow/utils/bin/pi_mpi
