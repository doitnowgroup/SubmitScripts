#!/bin/bash
#SBATCH -J QuantumESPRESSO-MPI
#SBATCH -A hpcnow        # Project Account
#SBATCH --ntasks=512        # number of tasks
#SBATCH --mem-per-cpu=4G    # memory/cpu
#SBATCH --time=2:00:00

# Load the user environment
ml QuantumESPRESSO/5.0.2-intel-2015a
###  The files will be allocated in the shared FS
cp -pr /sNow/test/QuantumESPRESSO/Benchmarks/GRIR443/* $SCRATCH_DIR/
cd $SCRATCH_DIR
### how to run executables (not all of them are parallel)
PARA_PREFIX=srun
PARA_POSTFIX=
### available flags:
#   -nimage n        number of images                        (or -nimages)
#   -npool  n        number of pools                         (or -npools)
#   -nband  n        number of band groups                   (or -nb, -nbgrp, -nband_group )
#   -ntask_groups n  number of task groups                   (or -ntg)
#   -ndiag n         number of processors for linear algebra (or -nproc_ortho, -northo, -nproc_diag)
PW_COMMAND="$PARA_PREFIX pw.x $PARA_POSTFIX"
PP_COMMAND="$PARA_PREFIX pp.x $PARA_POSTFIX"
PLOTRHO_COMMAND="$PARA_PREFIX plotrho.x"
BANDS_COMMAND="$PARA_PREFIX bands.x $PARA_POSTFIX"
PLOTBAND_COMMAND="$PARA_PREFIX plotband.x"
###  Run the Parallel Program
$PW_COMMAND -in grir443.in
### Transfer output files back to the project folder
#cp -pr $SCRATCH_DIR/ /your_project/folder/
