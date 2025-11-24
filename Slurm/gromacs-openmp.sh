#!/bin/bash
# Gromacs OpenMP SubmitScript
##########################################################################
#SBATCH -J GROMACS_JOB
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A hpcnow         # Project Account
#SBATCH --mem-per-cpu=2G  # memory/cpu 
#SBATCH --cpus-per-task=12  # 4 OpenMP Threads
##########################################################################
###  Load the Enviroment Modules for Gromacs 4.5.4
module load GROMACS/4.5.4
##########################################################################
###  Transfering the data to the local disk  ($SCRATCH_DIR)
cd $SCRATCH_DIR
cp $HOME/Gromacs_9LDT/input/* .
##########################################################################
###  Run the Parallel Program
srun grompp -f full_vdw.mdp -c 9LDT-pt-md-3.gro -p 9LDT-bu.top -o 9LDT-bu.tpr
srun mdrun_mpi -v -s 9LDT-bu.tpr -o 9LDT-bu.trr > mdrun.out
##########################################################################
###  Transfering the results to the home directory ($HOME)
cp -pr $SCRATCH_DIR $HOME/results/
