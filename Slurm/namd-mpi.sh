#!/bin/bash
# NAMD MPI SubmitScript
##########################################################################
#SBATCH -J NAMD 
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A hpcnow         # Project Account
#SBATCH --mem-per-cpu=2G  # memory/cpu 
#SBATCH --ntasks=24         # number of tasks
##########################################################################
###  Load the Enviroment Modules for Gromacs 4.5.4
module load NAMD/2.9
##########################################################################
###  The files will be allocated in the shared FS ($SCRATCH_DIR)
cp -pr /sNow/test/NAMD/apoa1/* $SCRATCH_DIR
cd $SCRATCH_DIR
##########################################################################
###  Run the Parallel Program
export OMP_NUM_THREADS=1
srun namd2 apoa1.namd
##########################################################################
###  Transfering the results to the home directory ($HOME)
cp -pr $SCRATCH_DIR $HOME/OUT/namd
