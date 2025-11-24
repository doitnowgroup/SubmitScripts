#!/bin/bash
#SBATCH -J ORCA
#SBATCH -A hpcnow        # Project Account
#SBATCH --time=01:00:00     # Walltime
#SBATCH --mem-per-cpu=8G    # memory/cpu 
#SBATCH --cpus-per-task=8   # 8 OpenMP Threads

# Load the user environment
ml ORCA/3_0_2-linux_x86-64
export P4_RSHCOMMAND=ssh
export OMP_NUM_THREADS=1
###  The files will be allocated in the shared FS
cd $TMP_DIR
cp /sNow/test/benchmarks/Orca/XRQTC.Orca_B3LYP/input/* .
# --------------> WARNING   <-------------------
# The number of CPUs needs to be specified in
# the input file : % pal nprocs $SLURM_NPROCS
mv XRQTC.Orca_B3LYP.inp XRQTC.Orca_B3LYP.inp.1
echo "% pal nprocs $NSLOTS
    end" > XRQTC.Orca_B3LYP.inp.0  
cat XRQTC.Orca_B3LYP.inp.0 XRQTC.Orca_B3LYP.inp.1 > XRQTC.Orca_B3LYP.inp
rm XRQTC.Orca_B3LYP.inp.*
########################################## 
# Run the job 
########################################## 
srun orca XRQTC.Orca_B3LYP.inp > XRQTC.Orca_B3LYP.out
########################################## 
# Copy the results to our home directory
########################################## 
mkdir -p /sNow/test/benchmarks/Orca/XRQTC.Orca_B3LYP/OUT/orca
cp -r $TMP_DIR /sNow/test/benchmarks/Orca/XRQTC.Orca_B3LYP/OUT/orca/ 
##########################################
# Temps dels resultats              
##########################################
TEMPS=$(cat XRQTC.Orca_B3LYP.out | grep Time: | awk '{print$3}')
echo "$NSLOTS   $TEMPS" >> /sNow/test/benchmarks/Orca/XRQTC.Orca_B3LYP/benchmark-ompi-XRQTC.Orca_B3LYP.dat
