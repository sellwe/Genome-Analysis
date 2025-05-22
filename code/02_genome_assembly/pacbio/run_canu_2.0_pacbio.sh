#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 24:00:00
#SBATCH -J canu_2.0_pacbio_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

# Testing with canu 2.0 
module load bioinfo-tools
module load canu/2.0  
module load perl/5.22.2

# Run Canu 
canu \
  -p E745_pacbio_2.0 \
  -d /home/sebase/Genome-Analysis/analyses/02_genome_assembly/pacbio \
  genomeSize=2.8m \
  maxThreads=4 \
  useGrid=false \
  -pacbio-raw /home/sebase/Genome-Analysis/data/raw_data/genomic/pacbio/*.subreads.fastq.gz

