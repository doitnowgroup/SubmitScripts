#!/bin/bash
#SBATCH -J OpenMP_JOB
#SBATCH -A hpcnow        # Project Account
#SBATCH --time=01:05:00     # Walltime
#SBATCH --mem-per-cpu=6G    # memory/cpu 
#SBATCH --cpus-per-task=12  # 12 OpenMP Threads
export SLURM_CHECKPOINT=12:00:00
export SLURM_CHECKPOINT_DIR=$CHK_DIR/$SLURM_JOB_NAME
#export SLURM_RESTART_DIR=$SLURM_CHECKPOINT_DIR

mkdir $SLURM_CHECKPOINT_DIR

cd $SCRATCH_DIR

srun_cr sleep 3600
#srun_cr stress --vm 1 --vm-bytes 128M --timeout 3600s
