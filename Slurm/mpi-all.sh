#!/bin/bash
#SBATCH -J MPI_JOB
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=1:00:00     # Walltime
#SBATCH --nodes=200
#SBATCH --tasks-per-node=16
#SBATCH --mem-per-cpu=1G  # memory/cpu 
module load intel/ics-2013
srun hostname
srun /sNow/training/slurm/bin/pi_mpi
