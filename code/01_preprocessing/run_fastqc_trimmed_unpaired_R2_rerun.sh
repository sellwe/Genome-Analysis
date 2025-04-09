#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J fastqc_trimmed_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load FastQC/0.11.9


mkdir -p /home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed/fastqc_rerun_R2_unpaired

fastqc /home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed/E745_R2_unpaired_trimmed.fq.gz \
  --outdir /home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed/fastqc_rerun_R2_unpaired

# Rerun of the R2 file, hopefully its not a copy of R1 this time. Created a new folder to avoid conflic
