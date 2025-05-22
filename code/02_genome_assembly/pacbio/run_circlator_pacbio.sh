#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:00:00
#SBATCH -J circlator_E745
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load circlator/1.5.5
module load SAMtools/1.3
module load MUMmer/3.23
module load spades/4.0.0
module load canu/2.0
module load bwa/0.7.18  
module load prodigal/2.6.3

# Inputs
ASSEMBLY="/home/sebase/Genome-Analysis/analyses/02_genome_assembly/pacbio/E745_pacbio.contigs.fasta" 
READS="/home/sebase/Genome-Analysis/data/raw_data/genomic/pacbio/pacbio_combined.fastq.gz"
# Outputs 
OUTPUT_DIR="/home/sebase/Genome-Analysis/analyses/02_genome_assembly/pacbio/circlator_run"


# Run Circlator
circlator all $ASSEMBLY $READS $OUTPUT_DIR
  
  

