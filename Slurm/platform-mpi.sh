#!/bin/bash
#SBATCH -J MPI_JOB
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=10:00:00     # Walltime
#SBATCH --ntasks=14         # number of tasks
#SBATCH --mem-per-cpu=1G  # memory/cpu 
module load Abaqus/6.13 
mpirun -srun uname
#mpirun -srun pi_platform-mpi-08.3.0.0
