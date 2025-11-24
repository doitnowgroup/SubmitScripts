#!/bin/bash
#SBATCH -J STRESS
#SBATCH -A hpcnow
#SBATCH --time=1:05:00
#SBATCH --mem-per-cpu=4G
##SBATCH --cpus-per-task=12
#srun stress --cpu 12 --vm-bytes 2GB --timeout 3600s
cd $SCRATCH_DIR
srun stress --cpu 1 -d 10 --timeout 3600s
