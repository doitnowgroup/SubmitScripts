#!/bin/bash
#SBATCH -J VTuneMPI
#SBATCH -A hpcnow
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -C ib
#SBATCH --ntasks=48
#SBATCH --nodes=2
ml 2021
ml intel/2021a
ml VTune/2021.6.0
ml itac/2021.5.0

# Some sites may require to unset the following variable and use mpiexec.hydra instead of srun.
#unset I_MPI_PMI_LIBRARY
# The following line uses GTOOL option to instruct Intel MPI to collect the hotspots metrics using VTune only on task #11.
export I_MPI_GTOOL="vtune -collect hotspots -r result:10"
srun my_app [my_app_options]

#To analyze a single MPI process with VTune Profiler, you must specify the relevant command in the corresponding argument set. The example below runs 47 MPI tasks where one of them is analysed with vtune:
#mpiexec.hydra -n 47 ./my_app : -n 1 vtune -c hotspots -r results_dir -- ./my_app
