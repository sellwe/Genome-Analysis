#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 04:00:00
#SBATCH -J spades_E745_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Load SPAdes module
module load bioinfo-tools
module load spades/3.15.5  

# Run SPAdes with Illumina paired/unpaired + Nanopore
spades.py \
  --pe1-1 /home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed/E745_R1_paired_trimmed.fq.gz \
  --pe1-2 /home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed/E745_R2_paired_trimmed.fq.gz \
  --s1 /home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed/E745_R1_unpaired_trimmed.fq.gz \
  --s2 /home/sebase/Genome-Analysis/analyses/01_preprocessing/trimmed/E745_R2_unpaired_trimmed.fq.gz \
  --nanopore /home/sebase/Genome-Analysis/data/raw_data/genomic/nanopore/E745_all_nanopore.fasta.gz \
  -o /home/sebase/Genome-Analysis/analyses/02_genome_assembly/spades \
  --threads 1 \
  --memory 16  # adjust if needed, safe default


# pe is the paired-ends
# s is the unpaired-ends 
# used memory 16 as a safe default 
