#!/bin/bash
######################################################
#SBATCH -J EasyBuild
#SBATCH -A hpcnow           
#SBATCH --time=06:00:00        
#SBATCH --mem-per-cpu=4G     
#SBATCH --cpus-per-task=4      
#SBATCH -D /sNow/easybuild/jobs
#SBATCH --uid=5674
######################################################
## Call the Easy Build 
srun eb  GROMACS-4.6.5-ictce-5.5.0-mt.eb --try-toolchain=ictce,5.4.0 --robot --force
srun eb WRF-3.4-goalf-1.1.0-no-OFED-dmpar.eb -r
######################################################
## Update the LMOD cache
/sNow/apps/lmod/utils/BuildSystemCacheFile/createSystemCacheFile.sh
