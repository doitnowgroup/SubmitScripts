#!/bin/bash
#SBATCH -J JobArray
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A hpcnow         # Project Account
#SBATCH --mem-per-cpu=1G  # memory/cpu 
#SBATCH --array=1-1000      # Array definition
#SBATCH -n 64

# If you need to explore several parameters or to use several input files
# you can create a mapping file like params.dat and use a single array
# job description file to run all the simulations.
# The script array_builder.sh is a simple example that generates the params.dat file

PARAMETERS=$(sed -n ${SLURM_ARRAY_TASK_ID}p params.dat)

#srun your_binary $PARAMETERS
srun -n 1 sleep 120
