#!/usr/bin/env bash

# This should be executed in the root directory of the project!

# Checkout TensorFlow sources
# v2.11.0 works both on Linux and Mac
# v2.12.0 does not seem to work on neither Linux nor Mac (and static compiling)
# v2.13.0-rc0 does seems to work again on both platforms
TENSORFLOW_VERSION="v2.15.0"
if [ ! -d "tensorflow_src" ]
then
  git clone --depth=1 -b $TENSORFLOW_VERSION https://github.com/tensorflow/tensorflow.git tensorflow_src
else
  echo "TensorFlow ($TENSORFLOW_VERSION) already cloned"
fi


# We need to remove binaries from previous architectures
rm -rf c-blosc2
# Checkout C-Blosc2 sources
git clone --depth=1 https://github.com/Blosc/c-blosc2.git c-blosc2

# Get new tags from remote
cd c-blosc2
git fetch --tags
# Get latest tag name
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
# Checkout latest tag
git checkout $latestTag

# Compile static version of C-Blosc2
mkdir build
cd build
# For some reason, without  -DDEACTIVATE_AVX512=ON btune_config.py throws
# an Illegal instruction (core dumped) error in some Ubuntu machines
cmake .. -DDEACTIVATE_AVX512=ON
cmake --build . --config Release --target blosc2_static -j
cd ../..
