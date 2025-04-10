#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J quast_spades_E745_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Load necessary modules
module load bioinfo-tools
module load quast/5.0.2

# Only spades
quast.py \
  /home/sebase/Genome-Analysis/analyses/02_genome_assembly/spades/contigs.fasta \
  -o /home/sebase/Genome-Analysis/analyses/02_genome_assembly/quast/quast_run_3_spades \
  --threads 1
