#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J quast_pacbio_E745_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Load necessary modules
module load bioinfo-tools
module load quast/5.0.2

# Run QUAST on the PacBio assembly
quast.py \
  /home/sebase/Genome-Analysis/analyses/02_genome_assembly/pacbio/E745_pacbio.contigs.fasta \
  -o /home/sebase/Genome-Analysis/analyses/02_genome_assembly/quast/quast_run_3_pacbio \
  --threads 1
