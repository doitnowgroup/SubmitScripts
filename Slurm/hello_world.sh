#!/bin/bash
######################################################
#SBATCH -J JobName
#SBATCH -A <account>           # Project Account
#SBATCH --time=00:10:00        # Walltime
#SBATCH --mem-per-cpu=1G     # memory/cpu 
#SBATCH -n 1                   # 1 core means serial
#SBATCH -o serial.out          # OPTIONAL
#SBATCH -e serial.err          # OPTIONAL
######################################################
###  Run the Parallel Program
srun echo "hello"
