#!/bin/bash
#SBATCH -J JobArray
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A hpcnow         # Project Account
#SBATCH --ntasks=2          # number of tasks
#SBATCH --mem-per-cpu=8G  # memory/cpu 
#SBATCH --cpus-per-task=2   # 4 OpenMP Threads
#SBATCH --array=20-180      # Array definition
srun sleep $SLURM_ARRAY_TASK_ID
srun echo running on $(hostname)
#srun stress --cpu 1 --vm-bytes 128M --timeout 10s
module load intel/2015a
srun /sNow/utils/bin/pi_mpi
