#!/bin/bash
#SBATCH -J ITAC
#SBATCH -A hpcnow
#SBATCH --time=6:00:00
#SBATCH --mem-per-cpu=6144
#SBATCH --ntasks=48
#SBATCH --nodes=2
ml 2021
ml intel/2021a
ml VTune/2021.6.0
ml itac/2021.5.0
source itacvars.sh impi5
######################################################################################
unset I_MPI_PMI_LIBRARY
mpiexec.hydra -trace /path/to/instrumented/code [my apps options]
