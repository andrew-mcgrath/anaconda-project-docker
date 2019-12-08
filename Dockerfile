FROM continuumio/miniconda3:4.7.12-alpine

# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="amcgrath/ap-trusted-notebook"
LABEL org.label-schema.description="Delivers is a trusted jupyter notebook, exposed via http, on port 8888"
LABEL org.label-schema.vcs-url="https://github.com/andrew-mcgrath/ap-trusted-notebook"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run -p 8888:8888 -d amcgrath/ap-trusted-notebook"

# install anaconda project
RUN /opt/conda/bin/conda create -n project -c defaults -c conda-forge anaconda-project \
  && /opt/conda/bin/conda clean --all -y

# Grab all the code and the project
COPY --chown=anaconda:anaconda anaconda-project.yml /opt/project/
COPY --chown=anaconda:anaconda notebook.ipynb /opt/project/
COPY --chown=anaconda:anaconda jupyter_notebook_config.py /opt/project/
COPY --chown=anaconda:anaconda docker-entrypoint.sh /

# expose the jupyter notebook default port
EXPOSE 8888

# install all of the dependencies for the project
RUN /opt/conda/bin/conda run -n project anaconda-project prepare --directory /opt/project \
  && /opt/conda/bin/conda clean --all -y

# trust the notebook
RUN /opt/conda/bin/conda run -n project anaconda-project run \
  --directory /opt/project trust

# runs anaconda project
ENTRYPOINT ["/docker-entrypoint.sh"]