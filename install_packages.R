if (!require("BiocManager", quietly = TRUE))
        install.packages("BiocManager")
BiocManager::install(version = "3.16", update = TRUE, ask = FALSE)

packages<-c(
"irlba",
"igraph",
"XML",
"intervals",
"RColorBrewer",
"Hmisc",
"gplots",
"multcomp",
"rgl",
"mixOmics",
"vegan",
"cba",
"nlme",
"ape",
"pvclust",
"dendextend",
"phangorn",
"VennDiagram",
"mzR",
"xcms",
"CAMERA",
"multtest",
"mixOmics",
"MSnbase")

BiocManager::install(packages)
