#######################################################
### Calculator for Benjamini-Hochberg-adjusted pvals
### Ben Jacobs 30-10-19
########################################################


#########################################################
### This script takes 2 arguments, the input file and
### the desired FDR threshold.
### it can be run from the command line like this:
### Rscript fdr_adjust.R [input file] [fdr threshold]
### 
#########################################################

library(readr)
library(dplyr)
args = commandArgs(trailingOnly = TRUE)

print("Benjamini-Hochberg calculator run with the following arguments:")
cat(args,sep="\n")
defaults=c("input.tsv",0.05)

df = read_table2(args[1])
df

df = df %>% arrange(p_SMR)
rank = c(1:nrow(df))
df = cbind(df,rank)
m = nrow(df)
q = args[2]
paste0("FDR threshold is set at ",as.numeric(q))
paste0("The number of tests is ",as.numeric(m))

df = df %>% mutate("BH"=as.numeric(rank)/as.numeric(m)*as.numeric(q))

write_tsv(df,"fdr_adjusted.tsv")

  
