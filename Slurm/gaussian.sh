#!/bin/bash
# Gaussian SubmitScript
# Optimized for run parallel job of 8 Cores 
######################################################
#SBATCH -J Gaussian
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads
#SBATCH --mem-per-cpu=8G  # memory/cpu 
######################################################
###  Load the Environment Modules for Gaussian
module load Gaussian/D.01
######################################################
###  Transferring the data to the local disk  ($SCRATCH_DIR)
cd $SCRATCH_DIR
cp /sNow/test/Gaussian/test0324.com .
export GAUSS_SCRDIR=$SCRATCH_DIR
######################################################
###  Run the Parallel Program
srun g09 < ./test0324.com > test0324.out
######################################################
###  Transferring the results to the project directory
cp -pr $SCRATCH_DIR $HOME/OUT/gaussian/
