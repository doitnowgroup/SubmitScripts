#!/bin/bash
#SBATCH -A hpcnow 
#SBATCH --time=7-00:00:00
#SBATCH --mem-per-cpu=6G
#SBATCH -J TestJob

module load R/3.0.3-goolf-1.5.14

srun Rscript ./PMT.R 
