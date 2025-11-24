#!/bin/bash
#SBATCH -J MPI_JOB
#SBATCH -A hpcnow   
#SBATCH --time=00:15:00
#SBATCH --ntasks=32
#SBATCH --mem-per-cpu=1G
module load ictce/5.4.0
srun hostname
srun /sNow/training/slurm/bin/pi_mpi
