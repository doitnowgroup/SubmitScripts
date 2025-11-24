#!/bin/bash
#SBATCH -J WRF_Conus12km
#SBATCH --ntasks=192        # number of tasks
#SBATCH --mem-per-cpu=4G    # memory/cpu
#SBATCH --time=2:00:00

# Load the user environment
ml module load WRF/4.4.1-foss-2022b-dmpar
export OMP_NUM_THREADS=1
###  The files will be allocated in the shared FS
if [[ ! -f v4.4_bench_conus12km.tar.gz ]]; then
    wget https://www2.mmm.ucar.edu/wrf/users/benchmark/v44/v4.4_bench_conus12km.tar.gz
fi
cd $SCRATCH_DIR
tar -zxvf /DoItNow/test/WRF/Benchmarks/CONUS12km/v4.4_bench_conus12km.tar.gz
cd v4.4_bench_conus12km
rm rsl.*
###  Run the Parallel Program
srun wrf.exe
### Transfer output files back to the project folder
#cp -pr $SCRATCH_DIR/ /your_project/folder/
