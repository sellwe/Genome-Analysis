#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 06:00:00
#SBATCH -J trim_rna_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load trimmomatic/0.39

# inputs "raw" data from both conditions 
IN_BH="/home/sebase/Genome-Analysis/data/raw_data/transcriptomic/RNA-Seq_BH"
IN_SERUM="/home/sebase/Genome-Analysis/data/raw_data/transcriptomic/RNA-Seq_Serum"

# outputs 
OUT_BH="/home/sebase/Genome-Analysis/data/trimmed_data/RNA-Seq_BH"
OUT_SERUM="/home/sebase/Genome-Analysis/data/trimmed_data/RNA-Seq_Serum"

# known adapter library to remove 
ADAPTERS="/sw/apps/bioinfo/trimmomatic/0.39/rackham/adapters/TruSeq3-PE.fa"

# IDs for the replicates 
BH_IDS=("ERR1797972" "ERR1797973" "ERR1797974")
SERUM_IDS=("ERR1797969" "ERR1797970" "ERR1797971")

# trimming of the BH samples
for ID in "${BH_IDS[@]}"; do
  trimmomatic PE -threads 2 \
    ${IN_BH}/trim_paired_${ID}_pass_1.fastq.gz ${IN_BH}/trim_paired_${ID}_pass_2.fastq.gz \
    ${OUT_BH}/${ID}_R1_paired_trimmed.fq.gz ${OUT_BH}/${ID}_R1_unpaired_trimmed.fq.gz \
    ${OUT_BH}/${ID}_R2_paired_trimmed.fq.gz ${OUT_BH}/${ID}_R2_unpaired_trimmed.fq.gz \
    ILLUMINACLIP:${ADAPTERS}:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50
done

# trimming of the serum samples
for ID in "${SERUM_IDS[@]}"; do
  trimmomatic PE -threads 2 \
    ${IN_SERUM}/trim_paired_${ID}_pass_1.fastq.gz ${IN_SERUM}/trim_paired_${ID}_pass_2.fastq.gz \
    ${OUT_SERUM}/${ID}_R1_paired_trimmed.fq.gz ${OUT_SERUM}/${ID}_R1_unpaired_trimmed.fq.gz \
    ${OUT_SERUM}/${ID}_R2_paired_trimmed.fq.gz ${OUT_SERUM}/${ID}_R2_unpaired_trimmed.fq.gz \
    ILLUMINACLIP:${ADAPTERS}:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50
done

