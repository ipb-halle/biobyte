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
	print("Usage: $0 feat_list.tsv dendrogramm.pdf")
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

# Sample names
ketchup_samples <- colnames(feat_list)

# Sample classes: ketchup
ketchup <- as.factor(sapply(strsplit(as.character(ketchup_samples), "\\."), function(x) {
    nam <- x[1];
    nam;
}))

# Unique sample classes: ketchup
ketchup_names <- unique(ketchup)

# Define colors
ketchup_colors <- c("darkorange1","blue3","darkorange3","darkorange4","coral2","coral3","coral4","brown3")
ketchup_symbols <- c(0,16,1,2,5,6,7,10)

# Define samples colors
ketchup_samples_colors <- sapply(ketchup, function(x) { x <- ketchup_colors[which(x==ketchup_names)] } )
ketchup_samples_symbols <- sapply(ketchup, function(x) { x <- ketchup_symbols[which(x==ketchup_names)] } )

ncomp <- 5                        # Number of components
nfolds <- 5                       # Number of folds for cross-validation
nrepeat <- 10                     # Number of repeats for validation
keepx <- c(seq(10, 20, 10))       # The number of variables to test from the X data set

# Prepare data matrix
plsda_list <- as.data.frame(t(feat_list))
plsda_list[is.na(plsda_list)] <- 0

# Perform sPLS-DA
model_splsda <- splsda(X=plsda_list, Y=ketchup, multilevel=NULL, ncomp=ncomp)

# Plot full (non-selected) feature matrix
pdf("/tmp/heatmap.pdf", encoding="ISOLatin1", pointsize=12, width=10, height=6, family="Helvetica")
par(mfrow=c(1,1), mar=c(4,4,4,1), oma=c(0,0,0,0), cex.axis=0.9, cex=0.8)
model_cim <- cim(model_splsda, comp=1:ncomp, xlab="features", ylab="samples", margins=c(5, 14))
dev.off()

pdf(args[2], encoding="ISOLatin1", pointsize=12, width=5, height=6, family="Helvetica")
par(mfrow=c(1,1), mar=c(1,1,2,1), cex=1.0)
#plot(as.phylo(model_cim$ddr), type="phylogram", direction="downwards",
#     tip.color=ketchup_samples_colors, label.offset=1, use.edge.length=TRUE,
#     show.tip.label=TRUE, font=2, x.lim=c(0,17), y.lim=c(0,33), main="Dendrogramm")
plot(as.phylo(as.dendrogram(hclust(dist(t(feat_list), method="euclidean")))),
      tip.color=ketchup_samples_colors, label.offset=1, use.edge.length=TRUE,
      show.tip.label=TRUE, font=2, main="Dendrogramm")
dev.off()


