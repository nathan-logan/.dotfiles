#!/bin/bash

cd ~/neovim

git checkout nightly
git pull origin nightly

make CMAKE_BUILD_TYPE=Release
sudo make install
