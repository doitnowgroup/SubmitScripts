#!/bin/bash
# MIGRATE Benchmark SubmitScript
# Optimized for run parallel job of 96 Cores 
######################################################
#SBATCH -J MIGRATE_TEST
#SBATCH -A hpcnow
#SBATCH --time=08:00:00
#SBATCH --ntasks=ncores
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=4G
######################################################
######################################################
###  The files will be allocated in the shared FS 
cp -pr /sNow/test/migrate/parmfile.* $SCRATCH_DIR/
cp -pr /sNow/test/migrate/infile $SCRATCH_DIR/
######################################################
###  Run the Parallel Program
for i in 3.4.4-goolf-1.4.10 3.4.4-ictce-5.4.0 3.6.6-goolf-1.4.10 3.6.6-ictce-5.4.0
do
    echo "version $i"
    cd $SCRATCH_DIR 
    mkdir $i
    cp parmfile.* $i/
    cp infile $i/
    cd $i
    time srun migrate-n-mpi parmfile -nomenu 
done
sstat -j $SLURM_JOBID -o JobID,MaxVMSize,AveVMSize,MinCPU,AveCPU,NTasks
######################################################
###  Transferring the results to the home directory ($HOME)
mkdir -p $HOME/OUT/migrate
cp -pr $SCRATCH_DIR $HOME/OUT/migrate
