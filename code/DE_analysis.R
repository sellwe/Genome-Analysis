directory <- getwd()

# files
sampleFiles <- c("trim_paired_ERR1797972_BH_counts.txt",
                 "trim_paired_ERR1797973_BH_counts.txt",
                 "trim_paired_ERR1797974_BH_counts.txt",
                 "trim_paired_ERR1797969_Serum_counts.txt",
                 "trim_paired_ERR1797970_Serum_counts.txt",
                 "trim_paired_ERR1797971_Serum_counts.txt")

# Extract sample names
sampleNames <- sub("^trim_paired_(.*)_counts\\.txt$", "\\1", sampleFiles)

# Get the condition from the filenames
sampleCondition <- ifelse(grepl("BH", sampleFiles), "BH", "Serum")

# Create sample table
sampleTable <- data.frame(sampleName = sampleNames,
                          fileName = sampleFiles,
                          condition = factor(sampleCondition))

# Load DESeq2
library(DESeq2)

# Create DESeq Data Set 
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = directory,
                                       design = ~ condition)

# Run the differential expression analysis
dds <- DESeq(ddsHTSeq)

# Filter out low-count genes. More than 10 reads in three samples
keep <- rowSums(counts(dds) >= 10) >= 3
dds <- dds[keep, ]

# Results 
res <- results(dds, contrast = c("condition", "Serum", "BH"))

# Convert results to a data frame 
res_df <- as.data.frame(res)

# annotation file
annotation <- read.delim("E745_pacbio.tsv", header = TRUE, sep = "\t")

# Convert rownames of res_df into a column for joining
res_df$gene_id <- rownames(res_df)

# Merge: join dataframe and annotations on gene_id = locus_tag
merged_df <- merge(res_df, annotation, by.x = "gene_id", by.y = "locus_tag", all.x = TRUE)

merged_df <- merged_df[order(merged_df$padj, -abs(merged_df$log2FoldChange)), ]

# Total number of genes after filtering
total_genes <- nrow(merged_df)

# Number of genes with adjusted p-value (padj) < 0.001 and |log2FC<| > 1
signif_genes <- sum(merged_df$padj < 0.001 & abs(merged_df$log2FoldChange) > 1, na.rm = TRUE)

# Fraction and percentage
fraction_signif <- signif_genes / total_genes
percent_signif <- fraction_signif * 100

# Upregulated in Serum (log2FC > 1)
upregulated <- sum(merged_df$padj < 0.001 & merged_df$log2FoldChange > 1, na.rm = TRUE)

# Downregulated in Serum (log2FC < -1)
downregulated <- sum(merged_df$padj < 0.001 & merged_df$log2FoldChange < -1, na.rm = TRUE)

# Print the results
cat("Total genes:", total_genes, "\n")
cat("Significant genes (padj < 0.001):", signif_genes, "\n")
cat("Fraction of significant genes:", round(fraction_signif, 4), "\n")
cat("Percentage of significant genes:", round(percent_signif, 2), "%\n")
cat("Upregulated genes in Serum:", upregulated, "\n")
cat("Downregulated genes in Serum:", downregulated, "\n")

# PLOTS

# simple PCA plot 
vsd <- vst(dds, blind = FALSE)  

plotPCA(vsd, intgroup="condition")

# simple MA plot
plotMA(res, ylim = c(-4, 4))

# Volcano plot
library(EnhancedVolcano)
EnhancedVolcano(merged_df,
                lab = merged_df$gene,  
                x = 'log2FoldChange',
                y = 'pvalue',
                xlim = c(-10, 10),
                title = 'BH vs Serum',
                subtitle = 'Differential expression',
                pCutoff = 0.001,
                FCcutoff = 1,
                pointSize = 2.0,
                labSize = 3.0,
                col = c('grey30', 'forestgreen', 'royalblue', 'red2'),
                legendPosition = 'right',
                legendLabSize = 12,
                legendIconSize = 4.0,
                drawConnectors = TRUE,
                widthConnectors = 0.5)

#  heatmap
library(pheatmap)

top_genes <- head(order(res$padj, na.last = NA), 30)

mat <- assay(vsd)[top_genes, ]  # rows = genes, cols = samples
mat <- mat - rowMeans(mat)      # center the rows (genes)

# create a sample annotation
annotation_col <- as.data.frame(colData(vsd)[, "condition", drop=FALSE])

rownames(mat) <- merged_df$gene[match(rownames(mat), merged_df$gene_id)]

pheatmap(mat,
         annotation_col = annotation_col,
         show_rownames = TRUE,
         show_colnames = TRUE,
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         fontsize = 9,
         color = colorRampPalette(c("navy", "white", "firebrick3"))(50),
         main = "Top 30 DE genes (BH vs Serum)")


sizeFactors(dds)
