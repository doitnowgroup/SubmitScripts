#!/bin/bash
# MIGRATE Benchmark SubmitScript
# Optimized for run parallel job of Cores 
# for j in {2..4} ; do sbatch --ntasks=$((16*$j)) --ntasks-per-node=16 --array=1-100 /sNow/SubmitScripts/slurm/migrate-benchmark.sl ; done
######################################################
#SBATCH -J MIGRATE_TEST
#SBATCH -A hpcnow
#SBATCH --time=01:00:00
##SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=4G
##SBATCH -C sb
#SBATCH -x compute-bigmem-[001,003-004],compute-chem-001
######################################################
######################################################
###  The files will be allocated in the shared FS 
cp -pr /sNow/test/migrate/parmfile* $SCRATCH_DIR/
cp -pr /sNow/test/migrate/infile $SCRATCH_DIR/
######################################################
###  Run the Parallel Program
#for i in 3.4.4-ictce-5.4.0 3.6.6-ictce-5.4.0 
for i in 3.4.4-ictce-5.4.0
do
    export I_MPI_FABRICS="shm:dapl"
    #export I_MPI_FALLBACK=disable
    #export I_MPI_DAPL_UD=enable
    #export I_MPI_ADJUST_COLLECTIVES="bcast:0;reduce:2"
    #export I_MPI_DAPL_SCALABLE_PROGRESS=1
    #export I_MPI_WAIT_MODE=enable
    export I_MPI_PIN_PROCESSOR_LIST="grain=cache2,shift=sock"
    #export I_MPI_WAIT_MODE=enable
    #export I_MPI_SHM_BYPASS=enable
    #export I_MPI_INTRANODE_EAGER_THRESHOLD=262144
    #export I_MPI_SHM_CACHE_BYPASS_THRESHOLDS=<nb_send>,<nb_recv>[,<nb_send_pk>,<nb_recv_ pk>]
    #export I_MPI_SHM_CACHE_BYPASS_THRESHOLDS=16384,16384,-1,16384,-1,16384
    echo "version $i"
    ml MIGRATE/$i
    #cd $SCRATCH_DIR 
    cd $SCRATCH_DIR 
    mkdir -p $i
    cp parmfile* $i/
    cp infile $i/
    cd $i
    echo "version $i"
    /usr/bin/time -f "real %e" -a -o /home/jbla572/OUT/migrate/benchmark-95r1-tuned-$LMOD_SYSTEM_NAME-$i-$SLURM_NTASKS.dat srun migrate-n-mpi parmfile.short -nomenu 
    ml purge
done
######################################################
###  Transferring the results to the home directory ($HOME)
#mkdir -p $HOME/OUT/migrate
#cp -pr $SCRATCH_DIR $HOME/OUT/migrate
