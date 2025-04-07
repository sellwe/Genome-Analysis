#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J fastqc_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user sebastian_ellwe@hotmail.com 
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load FastQC/0.11.9

# Run FastQC on Illumina reads
fastqc /home/sebase/Genome-Analysis/data/raw_data/genomic/illumina/E745-1_{1,2}.fq.gz \
  -o /home/sebase/Genome-Analysis/analyses/01_preprocessing/
