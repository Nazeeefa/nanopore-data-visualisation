"""
lol the following script can help create, for example, figure S1 (A and B) shown in supplementary information of 
 <De Novo Assembly of Two Swedish Genomes...> https://doi.org/10.3390/genes9100486
"""

# Data (extracted from vcf file) - example: extract chromosome list, variant size, and sample names
vcf <- read.table("file.csv", sep=";", header = TRUE)

# Extracting based on chromosome
vcf_chr <- vcf[grep(vcf$CHROM,pattern = "chr[0-9XY]$"), ]

# example: including only human variants
vcf_sample <- vcf_chr[grep("Human", vcf_chr$Sample),]

# example: selecting specific variants for length/size profile
vcf_indel <- vcf_sample[vcf1$SV %in% c("DUP", "INV"),]

library(ggplot2)
library(ggthemes)

# for variants upto 1 kb
vcfmax <- subset(vcf_indel,LEN<=1000)

# creating a plot
plot <- ggplot(vcfmax, aes(x = LEN, fill=SV)) + 
  geom_histogram(binwidth=20) +
  scale_x_continuous(breaks = seq(1000, 10000, 1000), limits=c(0, 10000), expand = c(0, 0)) +
  scale_y_continuous(breaks = seq(0,100, 25), limits=c(0, 100), expand = expand_scale(mult = c(0, .1))) +
  labs(title = "Main Title Goes Here", y = "Count", x = "Length", fill = "Type") +
  
# Free scales make it easier to see patterns within each panel  
  facet_wrap(~Sample, scales='free') +
  theme(
    strip.background = element_rect(color="black", size=1.5, linetype="solid"),
    axis.text.y = element_text(angle = 0, hjust = 1, size = 10, vjust=0.1, margin=margin(-5,0,0,0)),
# removes grid lines
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_blank(), 
    panel.background = element_blank())
plot + scale_color_manual(values=c("#908f8f", "#4674b4")) + scale_fill_manual(values=c("#908f8f", "#4674b4"))
