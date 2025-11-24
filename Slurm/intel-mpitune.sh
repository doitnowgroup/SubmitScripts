#!/bin/bash
#SBATCH -J MPITUNE
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=1:00:00     # Walltime
##SBATCH --ntasks=48          # number of tasks
#SBATCH --mem-per-cpu=2048   # memory/cpu (in MB)

ml VTune/2015_update2
ml supermagic/20130104-intel-2015a
ml itac/9.0.3.051
source itacvars.sh impi5
unset I_MPI_PMI_LIBRARY
export I_MPI_FABRICS=shm:dapl

mpitune -a \"mpiexec.hydra -n 16 supermagic -a -m 2M -w $SCRATCH_DIR/ -n 10 \" -of tune.conf
