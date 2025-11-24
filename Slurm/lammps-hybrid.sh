#!/bin/bash
# LAMMPS SubmitScript
# Optimized for run parallel job of 1024 Cores 
######################################################
#SBATCH -J LAMMPS
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=00:30:00     # Walltime
#SBATCH --mem-per-cpu=4G  # memory/cpu 
#SBATCH --ntasks=128        # Number of tasks
#SBATCH --cpus-per-task=8   # Number of OpenMP threads
######################################################
###  Load the Environment
module load lammps
######################################################
###  The files will be allocated in the shared FS 
cd $SCRATCH_DIR
cp -pr /sNow/test/LAMMPS/* .
######################################################
###  Run the Parallel Program
#Lennard Jones Benchmark input parameters: Weak Scaling
srun lmp_mpi -var x 10 -var y 40 -var z 40 -in in.lj
######################################################
###  Transferring the results to the home directory
cp -pr $SCRATCH_DIR $HOME/OUT/lammps/
