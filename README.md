# anaconda-project-docker
Working with anaconda-project and docker

# Build

```bash
docker build -t anaconda-project .
```

# Run

```bash
docker run -it --rm anaconda-project -e 8888:8888
```

# Trusting the notebook

```bash
jupyter trust notebook.ipynb
```