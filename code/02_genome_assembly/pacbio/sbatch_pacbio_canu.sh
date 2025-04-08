#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 07:00:00
#SBATCH -J canu_pacbio_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user sebastian_ellwe@hotmail.com 
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load canu/2.2          

# Run Canu assembly
canu \
  -p E745_pacbio \
  -d /home/sebase/Genome-Analysis/analyses/02_genome_assembly/pacbio \
  genomeSize=2.8m \
  useGrid=false \
  maxThreads=4 \
  -pacbio-raw /home/sebase/Genome-Analysis/data/raw_data/genomic/pacbio/*.subreads.fastq.gz


