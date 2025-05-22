# Read in files 
serum_69 <- read.table("trim_paired_ERR1797969_Serum_counts.txt", header = FALSE, sep = "\t", col.names = c("Gene", "Counts"))
serum_70 <- read.table("trim_paired_ERR1797970_Serum_counts.txt", header = FALSE, sep = "\t", col.names = c("Gene", "Counts"))
serum_71 <- read.table("trim_paired_ERR1797971_Serum_counts.txt", header = FALSE, sep = "\t", col.names = c("Gene", "Counts"))
bh_72 <- read.table("trim_paired_ERR1797972_BH_counts.txt", header = FALSE, sep = "\t", col.names = c("Gene", "Counts"))
bh_73 <- read.table("trim_paired_ERR1797973_BH_counts.txt", header = FALSE, sep = "\t", col.names = c("Gene", "Counts"))
bh_74 <- read.table("trim_paired_ERR1797974_BH_counts.txt", header = FALSE, sep = "\t", col.names = c("Gene", "Counts"))

head(serum_69)

table(serum_69$Counts == 0)  # How many genes have 0 counts
sum(serum_69$Counts > 0)     # Number of expressed genes

# Merge the serum files on gene names
serum_all <- Reduce(function(x, y) merge(x, y, by = "Gene"),
                    list(serum_69, serum_70, serum_71))
# Rename columns
colnames(serum_all) <- c("Gene", "S69", "S70", "S71")

# Sum all counts per gene
serum_all$Total <- rowSums(serum_all[, 2:4])

# The same for bh 
bh_all <- Reduce(function(x, y) merge(x, y, by = "Gene"),
                 list(bh_72, bh_73, bh_74))

colnames(bh_all) <- c("Gene", "B72", "B73", "B74")
bh_all$Total <- rowSums(bh_all[, 2:4])

# Serum
hist(serum_all$Total,
     breaks = 100,
     main = "Serum: Counts vs Nr of genes",
     xlab = "Total read counts",
     ylab = "Number of genes",
     )

# BH
hist(bh_all$Total,
     breaks = 100,
     main = "BH: Counts vs Nr of genes",
     xlab = "Total read counts",
     ylab = "Number of genes",
     )

# log-transformation for better visualization (some will have 0 counts, hence +1)
serum_all$logTotal <- log10(serum_all$Total + 1)
bh_all$logTotal <- log10(bh_all$Total + 1)

# Serum log plot
hist(serum_all$logTotal,
     breaks = 100,
     main = "Serum: Counts vs Nr of genes",
     xlab = "Counts (log10+1)",
     ylab = "Nr of genes"
     )

# BH log plot
hist(bh_all$logTotal,
     breaks = 100,
     main = "BH: Counts vs Nr of genes",
     xlab = "Counts (log10+1)",
     ylab = "Nr of genes"
     )

# percentage of genes with > 1 count
percent_expressed <- c(
  serum_69 = sum(serum_69$Counts > 0) / nrow(serum_69) * 100,
  serum_70 = sum(serum_70$Counts > 0) / nrow(serum_70) * 100,
  serum_71 = sum(serum_71$Counts > 0) / nrow(serum_71) * 100,
  bh_72 = sum(bh_72$Counts > 0) / nrow(bh_72) * 100,
  bh_73 = sum(bh_73$Counts > 0) / nrow(bh_73) * 100,
  bh_74 = sum(bh_74$Counts > 0) / nrow(bh_74) * 100
)
round(percent_expressed, 2)

# percentage of genes with > 10 counts
percent_expressed_10 <- c(
  serum_69 = sum(serum_69$Counts > 10) / nrow(serum_69) * 100,
  serum_70 = sum(serum_70$Counts > 10) / nrow(serum_70) * 100,
  serum_71 = sum(serum_71$Counts > 10) / nrow(serum_71) * 100,
  bh_72 = sum(bh_72$Counts > 10) / nrow(bh_72) * 100,
  bh_73 = sum(bh_73$Counts > 10) / nrow(bh_73) * 100,
  bh_74 = sum(bh_74$Counts > 10) / nrow(bh_74) * 100
)
round(percent_expressed_10, 2)
