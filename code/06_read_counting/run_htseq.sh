#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 07:00:00
#SBATCH -J htseq_sebase
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

module load bioinfo-tools 
module load htseq 

BAM_BH="/home/sebase/Genome-Analysis/analyses/05_RNA_mapping/BH"
BAM_SERUM="/home/sebase/Genome-Analysis/analyses/05_RNA_mapping/Serum"
#had to remove fasta sequence from the .gff file before
GFF="/home/sebase/Genome-Analysis/analyses/03_gene_annotation/E745_pacbio_clean.gff"
OUT_DIR="/home/sebase/Genome-Analysis/analyses/06_read_counting"

mkdir -p "$OUT_DIR/BH"
mkdir -p "$OUT_DIR/Serum"

#BH
for bam_file in "$BAM_BH"/*.bam; do
    sample=$(basename "$bam_file" .bam)
    htseq-count -f bam -r pos -s yes -t CDS -i ID "$bam_file" "$GFF" > $OUT_DIR/BH/${sample}_counts.txt 
done

#Serum
for bam_file in "$BAM_SERUM"/*.bam; do
    sample=$(basename "$bam_file" .bam)
    htseq-count -f bam -r pos -s yes -t CDS -i ID "$bam_file" "$GFF" > $OUT_DIR/Serum/${sample}_counts.txt 
done
