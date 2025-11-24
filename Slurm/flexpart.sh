#!/bin/bash
# FLEXPART-WRF SubmitScript
######################################################
#SBATCH -J FLEXPART-WRF
#SBATCH -A hpcnow           # Project Account
#SBATCH --time=00:10:00     # Walltime
#SBATCH --mem-per-cpu=1G    # memory/cpu 
######################################################
###  Load the Environment
module load flexpart-wrf/2006-intel-2015a
######################################################
###  The files will be allocated in the shared FS 
cd /sNow/src/flexpart-wrf/run.example2
######################################################
###  Run the Parallel Program
srun flexpart_wrf
