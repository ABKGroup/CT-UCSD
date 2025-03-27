# Tools for Circuit Training

This directory contains tools and docker build scripts used for running
circuit training as well as executing unit and end-to-end tests.

```shell
$ git clone https://github.com/google-research/circuit_training.git

$ export REPO_ROOT=$(pwd)/circuit_training
$ export TF_AGENTS_PIP_VERSION=tf-agents[reverb]
$ mkdir -p ${REPO_ROOT}/logs

# Build docker with tf-agents release defined by `TF_AGENTS_PIP_VERSION`.
$ docker build --pull --no-cache --tag circuit_training:core \
    --build-arg tf_agents_version="${TF_AGENTS_PIP_VERSION}" \
    -f "${REPO_ROOT}"/tools/docker/ubuntu_circuit_training ${REPO_ROOT}/tools/docker/

```

## Docker build scripts.

There are a few docker build scripts. Instructions on how to use them are
in the scripts.

* ubuntu_ci: Used for presubmit testing along with `tox`.
* ubuntu_circuit_training: Suggested for using when running circuit training.
* ubuntu_dreamplace_build: Used to build binaries of DREAMPlace.


## Docker for DREAMPlace:

Following shell command will create the docker that can be used to run Circuit Training with DREAMPlace.  

```shell
sh ./bootstrap_dreamplace_build.sh
```
