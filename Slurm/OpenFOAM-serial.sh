#!/bin/bash
#SBATCH -J OpenFOAM
#SBATCH -A hpcnow		# Project account
#SBATCH -D /projects/hpcnow/planejet
#SBATCH --time=06:00:00 	# Walltime
#SBATCH --mem-per-cpu=4G	# memory/cpu 

module load OpenFOAM/2.3.0-ictce-5.4.0
source $FOAM_BASH

srun blockMesh
srun simpleFoam

