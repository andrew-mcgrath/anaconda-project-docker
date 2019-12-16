[![Docker Automated](https://img.shields.io/docker/cloud/automated/amcgrath/ap-trusted-notebook)](https://hub.docker.com/r/amcgrath/ap-trusted-notebook) 
[![Docker Builds](https://img.shields.io/docker/cloud/build/amcgrath/ap-trusted-notebook)](https://hub.docker.com/r/amcgrath/ap-trusted-notebook/builds)
![Github License](https://img.shields.io/github/license/andrew-mcgrath/ap-trusted-notebook)
![Github Release](https://img.shields.io/github/v/release/andrew-mcgrath/ap-trusted-notebook)


# Purpose

This project was created to prove if an `anaconda-project` could be used to serve up a trusted `jupyter` notebook via
a docker container. This container could then be deployed either on a local workstation or to a remote orchestration 
service such as `kubernetes` or the AWS Elastic Container Service (ECS).

The base container [amcgrath/ap-notebook-base][ap-notebook-base] handles the installation of `anaconda-project` the
configuration of jupyter to run securely over HTTPS and the self signed certificate in order to do so.

## Docker

The container delivers is a trusted jupyter notebook, exposed via http, on port 8443.

### Build Locally

To build the container image, simply execute a standard docker build command.

```bash
export IMAGE_NAME="ap-trusted-notebook"
docker build \
  --build-arg VCS_REF=$(git rev-parse --short HEAD) \
  --build-arg BUILD_DATE=$(date -u +”%Y-%m-%dT%H:%M:%SZ”) \
  --build-arg BUILD_VERSION=$(git describe --tags --dirty) \
  -t $IMAGE_NAME .
```

### Run

To run the container port `8443` needs to be exposed to the host or service depending on the deployment mechanism.
This will allow the `jupyter notebook` to be accessed via http.

```bash
docker run -it --rm -p 8443:8443 amcgrath/ap-trusted-notebook
```
[ap-notebook-base]: https://hub.docker.com/r/amcgrath/ap-notebook-base