# coding=utf-8
# Copyright 2021 The Circuit Training Team Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#!/bin/bash
# Creates the docker containers needed to build DREAMPlace and then builds
# DREAMPlace for multiple versions of Python.
set -x;
set -e;

# Builds circuit training core and then the dreamplace build container.
docker build --no-cache --tag circuit_training:ci -f docker/ubuntu_ci .
docker build --no-cache --tag circuit_training:dreamplace_build -f docker/ubuntu_dreamplace_build .

# Clones DREAMPlace from head.
if [ ! -d ../../DREAMPlace ] ; then
    git -C ../../  clone --branch circuit_training --recursive https://github.com/sakundu/DREAMPlace.git
fi

# Starts the container used for the build mounting DREAMPlace git,
# circuit_training /tools and then starting the build.
for python_version in python3.9 
do
  docker run -it -v `cd ../../; pwd`/DREAMPlace:/dreamplace \
    -v $(pwd):/workspace circuit_training:dreamplace_build \
    bash /workspace/build_dreamplace.sh $python_version
done

docker build --no-cache --build-arg base_image=nvidia/cuda:11.4.2-cudnn8-devel-ubuntu20.04 \
	--build-arg python_version=python3.9 --build-arg tf_agents_version="tf-agents[reverb]==0.14" \
	--tag circuit_training:corepy39 -f ./docker/ubuntu_circuit_training .
