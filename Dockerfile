FROM continuumio/miniconda3:4.7.12-alpine

RUN /opt/conda/bin/conda create -n project -c defaults -c conda-forge anaconda-project

COPY --chown=anaconda:anaconda anaconda-project.yml /opt/project/
COPY --chown=anaconda:anaconda notebook.ipynb /opt/project/

EXPOSE 8888

RUN /opt/conda/bin/conda run -n project anaconda-project prepare --directory /opt/project

ENTRYPOINT /opt/conda/bin/conda run -n project anaconda-project run --directory /opt/project default --no-browser