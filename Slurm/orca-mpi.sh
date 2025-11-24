#!/bin/bash
#SBATCH -J ORCA
#SBATCH -A hpcnow      # Project Account
#SBATCH --time=01:00:00   # Walltime
#SBATCH --mem-per-cpu=8G  # memory/cpu 
#SBATCH --ntasks=48       # number of tasks

# Load the user environment
ml ORCA/3_0_2-linux_x86-64
export P4_RSHCOMMAND=ssh
export OMP_NUM_THREADS=1
###  The files will be allocated in the shared FS
cd $SCRATCH_DIR
cp /sNow/test/benchmarks/Orca/XRQTC.Orca_localCCSD/input/* .
# --------------> WARNING   <-------------------
# The number of CPUs needs to be specified in
# the input file : % pal nprocs $SLURM_NTASKS
mv XRQTC.Orca_localCCSD.inp XRQTC.Orca_localCCSD.inp.1
echo "% pal nprocs $SLURM_NTASKS
    end" > XRQTC.Orca_localCCSD.inp.0  
cat XRQTC.Orca_localCCSD.inp.0 XRQTC.Orca_localCCSD.inp.1 > XRQTC.Orca_localCCSD.inp
rm XRQTC.Orca_localCCSD.inp.*
########################################## 
# Run the job 
########################################## 
srun orca XRQTC.Orca_localCCSD.inp > XRQTC.Orca_localCCSD.out
########################################## 
# Copy the results to our home directory
########################################## 
mkdir -p /sNow/test/benchmarks/Orca/XRQTC.Orca_localCCSD/OUT/orca
cp -r $SCRATCH_DIR /sNow/test/benchmarks/Orca/XRQTC.Orca_localCCSD/OUT/orca/ 
##########################################
# Temps dels resultats              
##########################################
TEMPS=$(cat XRQTC.Orca_localCCSD.out | grep "Time:" | awk '{print $3}')
echo "$SLURM_NTASKS   $TEMPS" >> /sNow/test/benchmarks/Orca/XRQTC.Orca_localCCSD/benchmark-ompi-XRQTC.Orca_localCCSD.dat
