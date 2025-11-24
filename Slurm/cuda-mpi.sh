#!/bin/bash
#SBATCH -J GPU_JOB
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A hpcnow         # Project Account
#SBATCH --ntasks=4          # number of tasks
#SBATCH --ntasks-per-node=2 # number of tasks per node
#SBATCH --mem-per-cpu=8G  # memory/cpu 
#SBATCH --cpus-per-task=4   # 4 OpenMP Threads
#SBATCH --gres=gpu:2        # GPUs per node
srun binary_cuda_mpi
