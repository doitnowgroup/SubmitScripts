#!/bin/bash
#SBATCH -A hpcnow
#SBATCH --ntasks=24
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=2G
#SBATCH --job-name=TestJob

module load R/3.0.3-goolf-1.5.14
mpirun Rscript R-parallel-mpi.r
