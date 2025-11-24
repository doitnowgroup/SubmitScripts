#!/bin/bash
#SBATCH -J MPI_SuperMagic
#SBATCH -A hpcnow   
#SBATCH --time=02:00:00
#SBATCH --mem-per-cpu=7800M
#SBATCH --ntasks=1024
#
# options:
#    [-a|--all]                   run all tests in suite
#    [-h|--help]                  display this message
#    [-m|--msg-size x[B,k,M,G]]   change message size
#    [-M|--file-size B[B,k,M,G]]  change file size (per rank)
#    [-n|--n-iters X]             run X iterations of a test suite
#    [-q|--quiet]                 run in quiet mode
#    [-s|--stat /a/path]          add /a/path to stat list
#    [-t|--with-tests t1[,t2,tn]] run tests in requested order
#    [-w|--write /a/path]         add /a/path to IO tests
#    [-V|--verbose]               display verbose output 
#

for i in 20130104-goolf-1.5.14 20130104-ictce-5.4.0 20130104-iomkl-4.6.13 20130104-iomkl-6.5.4 20130104-foss-2015a 20130104-intel-2015a
do 
   module load supermagic/$i
   echo "Tool Chain $i"
   srun supermagic -a -m 2M -w $SCRATCH_DIR/ -n 10 > supermagic-$i-$SLURM_JOB_ID.dat  
   module purge
done
