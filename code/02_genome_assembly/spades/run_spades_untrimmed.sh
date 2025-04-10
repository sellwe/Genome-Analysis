#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 05:00:00
#SBATCH -J spades_E745_untrimmed
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Load SPAdes module
module load bioinfo-tools
module load spades/3.15.5

# Run SPAdes with Illumina paired raw reads + Nanopore long reads
spades.py \
  --pe1-1 /home/sebase/Genome-Analysis/data/raw_data/genomic/illumina/E745-1_1.fq.gz \
  --pe1-2 /home/sebase/Genome-Analysis/data/raw_data/genomic/illumina/E745-1_2.fq.gz \
  --nanopore /home/sebase/Genome-Analysis/data/raw_data/genomic/nanopore/E745_all_nanopore.fasta.gz \
  -o /home/sebase/Genome-Analysis/analyses/02_genome_assembly/spades/spades_2_untrimmed \
  --threads 1 \
  --memory 16 \
