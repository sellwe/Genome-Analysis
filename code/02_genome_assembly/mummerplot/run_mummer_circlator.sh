#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:30:00  
#SBATCH -J mummer_circlator_E745  
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out  

module load bioinfo-tools
module load MUMmer

OUTPUT_DIR="/home/sebase/Genome-Analysis/analyses/02_genome_assembly/mummerplot/mummerplot_circlator"
REFERENCE="/home/sebase/Genome-Analysis/data/raw_data/genomic/ncbi_genomes/reference_E_faecium/ncbi_dataset/data/GCF_900447735.1/GCF_900447735.1_43941_G01_genomic.fna"
ASSEMBLY="/home/sebase/Genome-Analysis/analyses/02_genome_assembly/pacbio/circlator_run/06.fixstart.fasta"

# Make sure output dir exists
mkdir -p "$OUTPUT_DIR"

# Align reference and assembly
nucmer --prefix="$OUTPUT_DIR/mummer_output" "$REFERENCE" "$ASSEMBLY"

# Filter the delta file 
delta-filter -1 "$OUTPUT_DIR/mummer_output.delta" > "$OUTPUT_DIR/mummer_output.filtered.delta"

# Create a plot
mummerplot -p="$OUTPUT_DIR/mummer_output" --postscript "$OUTPUT_DIR/mummer_output.filtered.delta"

