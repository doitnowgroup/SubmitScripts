#!/bin/bash
# GATK SubmitScript
#################################################################
#SBATCH -J GATK_SHM_THREADS
#SBATCH -A hpcnow         # Project Account
#SBATCH --time=08:00:00     # Walltime
#SBATCH --mem-per-cpu=4G  # memory/cpu 
#SBATCH --cpus-per-task=4   # 4 OpenMP Threads
#################################################################
###  Load the Environment
module load GATK/3.1-1
#################################################################
###  The files will be allocated in the /dev/shm FS 
cd $SHM_DIR
cp -r /sNow/test/GATK/examples/* .
#################################################################
###  Run the Parallel Program
### More information about Multihreading capabilities here:
### http://gatkforums.broadinstitute.org/discussion/1975/how-can-i-use-parallelism-to-make-gatk-tools-run-faster
MEM=$(($SLURM_CPUS_PER_TASK*$SLURM_MEM_PER_CPU))
srun java -Xmx${MEM}m -Djava.io.tmpdir=$SHM_DIR -jar $GATK -R exampleFASTA.fasta -I exampleBAM.bam -T CountReads
# Multi-threading options
# -nt / --num_threads controls the number of data threads sent to the processor
# -nct / --num_cpu_threads_per_data_thread controls the number of CPU threads allocated to each data thread
#srun java -Xmx${MEM}m -Djava.io.tmpdir=$SHM_DIR -jar $GATK -R exampleFASTA.fasta -I exampleBAM.bam -T CountReads -nct $SLURM_CPUS_PER_TASK
#srun java -Xmx${MEM}m -Djava.io.tmpdir=$SHM_DIR -jar $GATK -R exampleFASTA.fasta -I exampleBAM.bam -T CountReads -nt $SLURM_CPUS_PER_TASK
#################################################################
###  Transferring the results to the project directory
#mkdir -p $HOME/OUT/GATK
#cp -pr *out $HOME/OUT/GATK/
