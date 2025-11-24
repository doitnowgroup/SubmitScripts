#!/bin/bash
#SBATCH -J example
#SBATCH -A hpcnow        # Project Account
#SBATCH --time=00:20:00     # Walltime
#SBATCH --ntasks=48         # number of tasks
#SBATCH --mem-per-cpu=2G  # memory/cpu 
#SBATCH --workdir=/sNow/test/OpenSees
#SBATCH -C wm
module load OpenSees
srun OpenSeesMP ./example.tcl
