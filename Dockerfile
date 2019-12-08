FROM continuumio/miniconda3:4.7.12-alpine

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