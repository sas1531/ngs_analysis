### Shaleigh Smith
### NGS Coursework 6

### Import libraries ###
library(tidyverse)
library(exomePeak)
library(dplyr)

### Set paths to files ###
# GTF
gtf <- "../genes.gtf"
# Input RNA
i_control_1 <- "../iCTRL1_sorted.bam"
i_control_2 <- "../iCTRL2_sorted.bam"
i_control_3 <- "../iCTRL3_sorted.bam"
i_sample_1 <- "../iDS1_sorted.bam"
i_sample_2 <- "../iDS2_sorted.bam"
i_sample_3 <- "../iDS3_sorted.bam"
# m6a Enriched RNA (treated)
m_control_1 <- "../mCTRL1_sorted.bam"
m_control_2 <- "../mCTRL2_sorted.bam"
m_control_3 <- "../mCTRL3_sorted.bam"
m_sample_1 <- "../mDS1_sorted.bam"
m_sample_2 <- "../mDS2_sorted.bam"
m_sample_3 <- "../mDS3_sorted.bam"

### ExomePeak ###
# Set working directory
setwd("/Users/sha/Desktop/NGS_Informatics/NGS_courswork/ngs6_coursework_shaleigh_smith/exome_1")
# Run exomepeak on all datasets (with all controls)
result <- exomepeak(GENE_ANNO_GTF = gtf,
                    IP_BAM = c(m_control_1, 
                               m_control_2, 
                               m_control_3),
                    INPUT_BAM = c(i_control_1, 
                                  i_control_2, 
                                  i_control_3),
                    TREATED_IP_BAM = c(m_sample_1, 
                                       m_sample_2, 
                                       m_sample_3),
                    TREATED_INPUT_BAM = c(i_sample_1, 
                                          i_sample_2, 
                                          i_sample_3))

# Set working directory for first dataset
setwd("/Users/sha/Desktop/NGS_Informatics/NGS_courswork/ngs6_coursework_shaleigh_smith/exome_m1")
# Run exomepeak on first dataset against all controls
result1 <- exomepeak(GENE_ANNO_GTF = gtf,
                     IP_BAM = c(m_control_1, 
                                m_control_2, 
                                m_control_3),
                     INPUT_BAM = c(i_control_1, 
                                   i_control_2, 
                                   i_control_3),
                     TREATED_IP_BAM = c(m_sample_1),
                     TREATED_INPUT_BAM = c(i_sample_1))

# Set working directory for second dataset
setwd("/Users/sha/Desktop/NGS_Informatics/NGS_courswork/ngs6_coursework_shaleigh_smith/exome_m2")
# Run exomepeak on second dataset against all controls
result2 <- exomepeak(GENE_ANNO_GTF = gtf,
                     IP_BAM = c(m_control_1, 
                                m_control_2, 
                                m_control_3),
                     INPUT_BAM = c(i_control_1, 
                                   i_control_2, 
                                   i_control_3),
                     TREATED_IP_BAM = c(m_sample_2),
                     TREATED_INPUT_BAM = c(i_sample_2))

# Set working directory for third dataset
setwd("/Users/sha/Desktop/NGS_Informatics/NGS_courswork/ngs6_coursework_shaleigh_smith/exome_m3")
# Run exomepeak on third dataset against all controls
result3 <- exomepeak(GENE_ANNO_GTF = gtf,
                     IP_BAM = c(m_control_1, 
                                m_control_2, 
                                m_control_3),
                     INPUT_BAM = c(i_control_1, 
                                   i_control_2, 
                                   i_control_3),
                     TREATED_IP_BAM = c(m_sample_3),
                     TREATED_INPUT_BAM = c(i_sample_3))

### Downstream Analysis ###
# Results
result
result1
result2
result3

# View results (all)
con_sig_diff_1 <- read.table("./exome_1/exomePeak_output/con_sig_diff_peak.xls", 
                             head = TRUE, sep = "\t")
sig_diff_1 <- read.table("./exome_1/exomePeak_output/sig_diff_peak.xls",  
                         head = TRUE, sep = "\t")
diff_1 <- read.table("./exome_1/exomePeak_output/diff_peak.xls", 
                     head = TRUE, sep = "\t")

# View results (m1)
con_sig_diff_m1 <- read.table("./exome_m1/exomePeak_output/con_sig_diff_peak.xls", 
                              head = TRUE, sep = "\t")
sig_diff_m1 <- read.table("./exome_m1/exomePeak_output/sig_diff_peak.xls",  
                          head = TRUE, sep = "\t")
diff_m1 <- read.table("./exome_m1/exomePeak_output/diff_peak.xls",  
                      head = TRUE, sep = "\t")

# View results (m2)
con_sig_diff_m2 <- read.table("./exome_m2/exomePeak_output/con_sig_diff_peak.xls",  
                              head = TRUE, sep = "\t")
sig_diff_m2 <- read.table("./exome_m2/exomePeak_output/sig_diff_peak.xls",  
                          head = TRUE, sep = "\t")
diff_m2 <- read.table("./exome_m2/exomePeak_output/diff_peak.xls",  
                      head = TRUE, sep = "\t")

# View results (m3)
con_sig_diff_m3 <- read.table("./exome_m3/exomePeak_output/con_sig_diff_peak.xls",  
                              head = TRUE, sep = "\t")
sig_diff_m3 <- read.table("./exome_m3/exomePeak_output/sig_diff_peak.xls",  
                          head = TRUE, sep = "\t")
diff_m3 <- read.table("./exome_m3/exomePeak_output/diff_peak.xls",  
                      head = TRUE, sep = "\t")

# Modified Transcripts that differ between test and control datasets (unique)
length(unique(con_sig_diff_1$name)) # 395

# Number of genes modified in each individual dataset (unique)
length(unique(con_sig_diff_m1$name)) # 338
length(unique(con_sig_diff_m2$name)) # 346
length(unique(con_sig_diff_m3$name)) # 4116

# Number of genes present in at least two of the test datasets and none of the control
# Select gene name interest and add data column with 1
con_m1 <- dplyr::select(con_sig_diff_m1, name)
con_m1 <- distinct(con_m1)
con_m1$data_m1 <- 1
con_m2 <- dplyr::select(con_sig_diff_m2, name)
con_m2 <- distinct(con_m2)
con_m2$data_m2 <- 1
con_m3 <- dplyr::select(con_sig_diff_m3, name)
con_m3 <- distinct(con_m3)
con_m3$data_m3 <- 1

# Full join datasets, fill NA with 0 
con <- merge(con_m1, con_m2, by = "name", all = TRUE)
con <- merge(con, con_m3, by = "name", all = TRUE)
con[is.na(con)] <- 0

# Sum data columns
con$count <- rowSums(con[ ,2:4])

# Numer of genes present in at least two of the test datasets
nrow(con[con$count > 1, ]) # 478
