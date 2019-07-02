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
	print("Usage: $0 feat_list.tsv hist.pdf")
	quit(save="no", status=1, runLast=FALSE)
}

# Load libraries
library(MSnbase)
library(xcms)
library(CAMERA)
library(mixOmics)
library(ape)
library(pvclust)
library(dendextend)
library(cba)
library(phangorn)

# Import Feature list
feat_list <- read.table(file=args[1], header=TRUE, quote="\"", sep="\t")

# Plot Histogram
pdf(args[2], encoding="ISOLatin1", pointsize=12, width=10, height=6, family="Helvetica")
distribution <- feat_list[,1]
hist(distribution)
dev.off()

