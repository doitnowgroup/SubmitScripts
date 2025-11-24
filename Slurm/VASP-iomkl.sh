#!/bin/bash
# Scalability tests 
# for i in {4..12}; do sbatch --ntasks=$(($i*$i)) --nodes=$((($i*$i)/12))-$((1+($i*$i)/12)) -C wm /sNow/SubmitScripts/slurm/VASP-iomkl.sl ; done
#SBATCH -J VASPBench
#SBATCH -A hpcnow
#SBATCH --time=1:59:00
##SBATCH --ntasks=96
#SBATCH --mem-per-cpu=8G
ml VASP/5.3.5-iomkl-4.6.13
cd $SCRATCH_DIR
#
# Available tests are : NeSI.VASP_BandsandDOS NeSI.VASP_SurfOpt XRQTC.VASP_ceria-surface  XRQTC.VASP_DFT
#
TEST=KristaGSteenbergen-MD-bulk_melting
cp -pr /sNow/test/VASP/$TEST/input/* .
SQRTCORES=$(echo "sqrt($SLURM_NPROCS)"|bc)
sed -i "s/SQRTCORES/$SQRTCORES/g" INCAR
##########################################################################
###  Run the Parallel Program
# -------------> WARNING <-------------------
# Check what binary fits your needs
# vasp             MPI parallel, charge density and wavefunction complex
# vasp_cd          MPI parallel, charge density: half grid mode (-DNGZhalf)
# vasp_md_cd       MPI parallel, charge density: half grid mode (-DNGZhalf), MD
# vasp_gamma       MPI parallel, gamma-point only (-DwNGZhalf)
# vasp_md_gamma    MPI parallel, gamma-point only (-DwNGZhalf), MD
# vasp_vtst        MPI parallel, charge density + wavefunction complex + VASP TST Tools
# vasp_vtst_cd     MPI parallel, charge density: half grid mode (-DNGZhalf) + VASP TST Tools
# vasp_vtst_gamma  MPI parallel, gamma-point only (-DwNGZhalf) + VASP TST Tools
# -------------------------------------------
export OMP_NUM_THREADS=1
VASPBIN=vasp_md_cd
srun $VASPBIN
##########################################################################
###  Transfering the results to the home directory ($HOME)
mkdir -p /sNow/test/VASP/OUT/$TEST
rm WAVECAR CHG*
cp -pr $SCRATCH_DIR /sNow/test/VASP/OUT/$TEST/
TEMPS=$(cat OUTCAR | grep "Total CPU time used" | awk '{print $(NF)}')
echo "$SLURM_NPROCS   $TEMPS" >> /sNow/test/VASP/benchmark-$TEST-$VASPBIN-5.3.5-iomkl-4.6.13-$LMOD_SYSTEM_NAME.log
