FROM continuumio/miniconda3:4.7.12-alpine

RUN /opt/conda/bin/conda create -n project -c defaults -c conda-forge anaconda-project

COPY --chown=anaconda:anaconda anaconda-project.yml /opt/project/