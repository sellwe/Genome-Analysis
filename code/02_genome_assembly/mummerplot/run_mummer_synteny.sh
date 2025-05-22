#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:30:00  
#SBATCH -J mummer_synteny  
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out  

module load bioinfo-tools
module load MUMmer

OUTPUT_DIR="/home/sebase/Genome-Analysis/analyses/02_genome_assembly/mummer_synteny_output"
REFERENCE="/home/sebase/Genome-Analysis/data/raw_data/genomic/ncbi_genomes/ncbi_dataset/data/GCF_000322385.1/GCF_000322385.1_Ente_faec_E2369_V1_genomic.fna"
ASSEMBLY="/home/sebase/Genome-Analysis/analyses/02_genome_assembly/pacbio/E745_pacbio.contigs.fasta"

mkdir -p "$OUTPUT_DIR"

nucmer --prefix="$OUTPUT_DIR/mummer_output" "$REFERENCE" "$ASSEMBLY"

# Filter delta file
delta-filter -1 "$OUTPUT_DIR/mummer_output.delta" > "$OUTPUT_DIR/mummer_output.filtered.delta"

# Generate plot
mummerplot -p="$OUTPUT_DIR/mummer_output" --postscript "$OUTPUT_DIR/mummer_output.filtered.delta"

