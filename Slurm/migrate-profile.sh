#!/bin/bash
# MIGRATE Benchmark SubmitScript
# Optimized for run parallel job of Cores 
######################################################
#SBATCH -J MIGRATE_Profile
#SBATCH -A hpcnow
#SBATCH --time=01:00:00
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=4G
#SBATCH -C sb
######################################################
######################################################
###  The files will be allocated in the shared FS 
cp -pr /sNow/test/migrate/parmfile* $SCRATCH_DIR/
cp -pr /sNow/test/migrate/infile $SCRATCH_DIR/
######################################################
###  Run the Parallel Program
for i in 3.4.4-ictce-5.4.0 3.6.6-ictce-5.4.0 
do
    #export I_MPI_FABRICS=shm:dapl 
    #export I_MPI_ADJUST_COLLECTIVES = bcast:0;reduce:2
    #export I_MPI_DAPL_SCALABLE_PROGRESS=1
    #export I_MPI_STATS=3 
    #export I_MPI_STATS_SCOPE=coll
    echo "version $i"
    ml MIGRATE/$i
    ml VTune/2013_update8
    ml itac/8.1.4.045
    source itacvars.sh impi4
    #export VT_PCTRACE=4
    #export VT_CONFIG=/sNow/SubmitScripts/slurm/trace.conf
    cd $SCRATCH_DIR 
    mkdir $i
    cp parmfile* $i/
    cp infile $i/
    cd $i
    #srun migrate-n-mpi parmfile.short -nomenu 
    unset I_MPI_PMI_LIBRARY
    srun amplxe-cl -collect hotspots -- migrate-n-mpi parmfile.short -nomenu 
    ml purge
done
sstat -j $SLURM_JOBID -o JobID,MaxVMSize,AveVMSize,MinCPU,AveCPU,NTasks
######################################################
###  Transferring the results to the home directory ($HOME)
mkdir -p $HOME/OUT/migrate-profile
cp -pr $SCRATCH_DIR $HOME/OUT/migrate-profile/
