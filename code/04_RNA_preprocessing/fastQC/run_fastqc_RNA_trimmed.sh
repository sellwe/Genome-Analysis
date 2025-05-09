#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_sebase_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load FastQC

DATA_DIR=/home/sebase/Genome-Analysis/data/trimmed_data
OUTPUT_DIR=/home/sebase/Genome-Analysis/analyses/04_RNA_preprocessing/fastQC/trimmed

mkdir -p $OUTPUT_DIR/BH
mkdir -p $OUTPUT_DIR/Serum

# I run one fastqc for each condition
fastqc $DATA_DIR/RNA-Seq_BH/*.fq.gz -o $OUTPUT_DIR/BH 
fastqc $DATA_DIR/RNA-Seq_Serum/*.fq.gz -o $OUTPUT_DIR/Serum 

