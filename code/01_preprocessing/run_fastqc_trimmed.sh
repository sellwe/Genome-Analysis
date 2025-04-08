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


TRIMMED_DIR=/home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed

# Run FastQC on the paired trimmed reads
fastqc $TRIMMED_DIR/E745_R1_paired_trimmed.fq.gz $TRIMMED_DIR/E745_R2_paired_trimmed.fq.gz \
  -o $TRIMMED_DIR

# I trim the paired ends. Here input and output place are the same, alias #TRIMMED_DIR
