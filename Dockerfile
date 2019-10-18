FROM ubuntu:16.04

MAINTAINER Kristian Peters ( kpeters@ipb-halle.de )

ENV R_VERSION="3.5.3-1xenial"

# docker build -t ipb-halle/biobyte .
# docker push ipb-halle/biobyte

# Add cran R backport
RUN echo "deb http://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Install R + packages
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install apt-transport-https r-base-dev=${R_VERSION}
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install make gcc gfortran g++ libnetcdf-dev libxml2-dev libblas-dev liblapack-dev libssl-dev pkg-config git xorg xorg-dev libglu1-mesa-dev libgl1-mesa-dev wget zip unzip perl-base
RUN R -e 'install.packages(c("irlba","igraph","XML","intervals","RColorBrewer","Hmisc","gplots","multcomp","rgl","mixOmics","vegan","cba","nlme","ape","pvclust","dendextend","phangorn","VennDiagram"), repos="https://cran.uni-muenster.de/")'
RUN R -e 'if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager"); library(BiocManager); BiocManager::install("mzR"); BiocManager::install("xcms"); BiocManager::install("CAMERA"); BiocManager::install("multtest"); BiocManager::install("mixOmics")'
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Add scripts to container
ADD scripts/* /usr/local/bin/
RUN chmod +rx /usr/local/bin/*
