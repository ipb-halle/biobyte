#!/usr/bin/env Rscript

# ---------- Load R environment ----------
# Setup R error handling to go to stderr
options(show.error.messages=F, error=function() { cat(geterrmessage(), file=stderr()); q("no",1,F) } )

# Set proper locale
#loc <- Sys.setlocale("LC_MESSAGES", "en_US.UTF-8")
#loc <- Sys.setlocale(category="LC_ALL", locale="C")

# Set options
#options(encoding="UTF-8")
options(stringAsfactors=FALSE, useFancyQuotes=FALSE)

# Take in trailing command line arguments
args <- commandArgs(trailingOnly=TRUE)
if (length(args) < 2) {
	print("Error! No or not enough arguments given.")
	print("Usage: $0 feat_list.tsv feat_list_log.tsv")
	quit(save="no", status=1, runLast=FALSE)
}

# Load libraries
library(mixOmics)
library(ape)
library(pvclust)
library(dendextend)
library(cba)
library(phangorn)

# Import Feature list
feat_list <- read.csv(file=args[1], row.names=1, sep="\t")

# Log-Transformation
feat_list_log <- log(feat_list)
for (i in 1:ncol(feat_list_log)) {
	feat_list_log[which(feat_list_log[,i] == -Inf), i] <- 0
}
feat_list_log[is.na(feat_list_log)] <- 0

# Export log-transformed Feature List
write.table(x=feat_list_log, file=args[2], col.names = NA, sep="\t")

