#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:30:00
#SBATCH -J trim_illumina_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load trimmomatic/0.39

# Input & output paths
READ1=/home/sebase/Genome-Analysis/data/raw_data/genomic/illumina/E745-1_1.fq.gz
READ2=/home/sebase/Genome-Analysis/data/raw_data/genomic/illumina/E745-1_2.fq.gz
OUTDIR=/home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed

# Run Trimmomatic
trimmomatic PE -threads 1 \
  $READ1 $READ2 \
  $OUTDIR/E745_R1_paired_trimmed.fq.gz $OUTDIR/E745_R1_unpaired_trimmed.fq.gz \
  $OUTDIR/E745_R2_paired_trimmed.fq.gz $OUTDIR/E745_R2_unpaired_trimmed.fq.gz \
  ILLUMINACLIP:/sw/apps/bioinfo/trimmomatic/0.39/rackham/adapters/TruSeq3-PE.fa:2:30:10 \
  SLIDINGWINDOW:4:20 MINLEN:50
