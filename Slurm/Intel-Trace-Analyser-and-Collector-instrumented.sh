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
export VT_PCTRACE=4
export VT_CONFIG=/sNow/SubmitScripts/slurm/trace.conf
# the code needs to be compiled with -tcollect option in order to be instrumented
# mpiifort -g -O3 -xhost -ip -tcollect yourcode.f -o yourcode_traces $VT_ADD_LIBS
srun /path/to/instrumented/code [my apps options]
