#!/bin/bash
# MIGRATE Benchmark SubmitScript
# Optimized for run parallel job of Cores 
######################################################
#SBATCH -J MIGRATE_traces
#SBATCH -A hpcnow
#SBATCH --time=08:00:00
##SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=4G
##SBATCH -C sb
######################################################
######################################################
###  The files will be allocated in the shared FS 
cp -pr /sNow/test/migrate/parmfile* $SCRATCH_DIR/
cp -pr /sNow/test/migrate/infile $SCRATCH_DIR/
######################################################
###  Run the Parallel Program
mkdir -p $HOME/OUT/migrate-traces/tuned-c
#for i in 3.4.4-ictce-5.4.0 3.6.6-ictce-5.4.0 3.4.4-goolf-1.4.10 3.6.6-goolf-1.4.10
for i in 3.4.4-ictce-5.4.0 3.6.6-ictce-5.4.0 
do
    export I_MPI_FABRICS=shm:dapl 
    #export I_MPI_ADJUST_COLLECTIVES = bcast:0;reduce:2
    export I_MPI_FALLBACK=disable
    export I_MPI_DAPL_UD=enable
    export I_MPI_DAPL_SCALABLE_PROGRESS=1
    export I_MPI_PIN_PROCESSOR_LIST='grain=cache2,shift=sock'
    export I_MPI_WAIT_MODE=enable
    export I_MPI_SHM_BYPASS=enable
    export I_MPI_INTRANODE_EAGER_THRESHOLD=262144
    #export I_MPI_SHM_CACHE_BYPASS_THRESHOLDS=<nb_send>,<nb_recv>[,<nb_send_pk>,<nb_recv_ pk>]
    export I_MPI_SHM_CACHE_BYPASS_THRESHOLDS=16384,16384,-1,16384,-1,16384
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
    mpiexec.hydra -trace migrate-n-mpi parmfile.short -nomenu 
    #mpiexec.hydra -trace migrate-n-mpi parmfile.short -nomenu 
    #mpirun itcpin --run -- migrate-n-mpi parmfile.short -nomenu 
    ml purge
    cp -pr $SCRATCH_DIR $HOME/OUT/migrate-traces/tuned-c/$i-$SLURM_NTASKS
done
#sstat -j $SLURM_JOBID -o JobID,MaxVMSize,AveVMSize,MinCPU,AveCPU,NTasks
######################################################
###  Transferring the results to the home directory ($HOME)
