# Purpose

This project was created to prove if an `anaconda-project` could be used to serve up trusted `jupyter notebooks` via
a docker container for deployment in either a local workstation or a remote orchestration service such as `kubernetes` 
or the AWS Elastic Container Service (ECS).

What the container delivers is a trusted jupyter notebook, exposed via http, on port 8888.

## Docker

### Build

To build the container image simply execute a standard docker build command.

```bash
docker build -t anaconda-project .
```

### Run

To run the container port `8888` needs to be exposed to the host or service depending on the deployment mechanism.
This will allow the `jupyter notebook` to be accessed via http.

```bash
docker run -it --rm -p 8888:8888 anaconda-project
```