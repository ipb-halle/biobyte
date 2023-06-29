FROM bioconductor/bioconductor_docker:RELEASE_3_16

# Install R packages
COPY install_packages.R install_packages.R
RUN Rscript install_packages.R

# Add scripts to container
ADD scripts/* /usr/local/bin/
RUN chmod +rx /usr/local/bin/*
