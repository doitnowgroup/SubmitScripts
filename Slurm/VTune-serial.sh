#!/bin/bash
#SBATCH -J VTuneSerial
#SBATCH -A hpcnow
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH -C ib
#SBATCH --cpus-per-task=1
ml 2021
ml intel/2021a
ml VTune/2021.6.0

srun vtune -r my_profile_dir -c hotspots my_app [my_app_options]
