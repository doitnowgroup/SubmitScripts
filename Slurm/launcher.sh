#!/bin/bash
#SBATCH -J Launcher
#SBATCH --time=01:00:00     # Walltime
#SBATCH -A hpcnow           # Project Account
#SBATCH --nodes=2           # 2 nodes
#SBATCH --ntasks=128        # number of tasks
#SBATCH --mem-per-cpu=6G    # memory/cpu
#SBATCH -o Parametric.%j.out
#SBATCH -e Parametric.%j.err
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the LAUNCHER_JOB_FILE to specify
# each executable per process.
#------------------------------------------------------

# Load user environment
module load launcher
export LAUNCHER_RMI=SLURM
export LAUNCHER_WORKDIR=/home/easybuild/launcher_test
export LAUNCHER_JOB_FILE=helloworld_multi

# Run the job file
paramrun
