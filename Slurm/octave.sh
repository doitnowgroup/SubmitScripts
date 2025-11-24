#!/bin/bash
#SBATCH -J Serial_Job
#SBATCH --job-name=octave
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=00:10:00     # Walltime
#SBATCH --mem-per-cpu=2G  # memory/cpu 
#SBATCH --mail-user=b.verleye@auckland.ac.nz
#SBATCH --mail-type=ALL
module load Octave
octave  'myTest.m'
