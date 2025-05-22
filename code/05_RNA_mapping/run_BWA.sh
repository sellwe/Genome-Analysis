#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:00:00
#SBATCH -J bwa_mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sebastian_ellwe@hotmail.com
#SBATCH --output=%x.%j.out

#running a temporary SNIC_TMP for handling the large data. Removed after runnning
trap 'rm -rf $WORKDIR' EXIT

module load bioinfo-tools
module load bwa
module load samtools

GENOME="/home/sebase/Genome-Analysis/analyses/02_genome_assembly/pacbio/E745_pacbio.contigs.fasta"
BH_DIR="/home/sebase/Genome-Analysis/data/raw_data/transcriptomic/RNA-Seq_BH"
SERUM_DIR="/home/sebase/Genome-Analysis/data/raw_data/transcriptomic/RNA-Seq_Serum"
OUT_DIR="/home/sebase/Genome-Analysis/analyses/05_RNA_mapping" 

WORKDIR="$SNIC_TMP/bwa_mapping"
mkdir -p "$WORKDIR/BH" "$WORKDIR/Serum"

cp "$GENOME" "$WORKDIR/"
GENOME_BASENAME=$(basename "$GENOME")
GENOME_TMP="$WORKDIR/$GENOME_BASENAME"
bwa index $GENOME_TMP


for R1 in "$BH_DIR"/trim_paired_*_pass_1.fastq.gz; do 
    R2="${R1/_pass_1.fastq.gz/_pass_2.fastq.gz}"
    sample=$(basename "$R1" _pass_1.fastq.gz)

    bam_out="$WORKDIR/BH/${sample}_BH.bam"

    echo "Aligning BH $sample"
    bwa mem -t 2 "$GENOME_TMP" "$R1" "$R2" |samtools sort -@ 2 -o "$bam_out" - 

    echo "Indexing BH $bam_out"
    samtools index "$bam_out"

done

for R1 in "$SERUM_DIR"/trim_paired_*_pass_1.fastq.gz; do 
    R2="${R1/_pass_1.fastq.gz/_pass_2.fastq.gz}"
    sample=$(basename "$R1" _pass_1.fastq.gz)

    bam_out="$WORKDIR/Serum/${sample}_Serum.bam"

    echo "Aligning Serum $sample"
    bwa mem -t 2 "$GENOME_TMP" "$R1" "$R2" |samtools sort -@ 2 -o "$bam_out" -

    echo "Indexing Serum $bam_out"
    samtools index "$bam_out"

done

#copying back the bam and bam.bai files to my dir 
cp "$WORKDIR/BH"/* "$OUT_DIR/BH/"
cp "$WORKDIR/Serum"/* "$OUT_DIR/Serum/"

