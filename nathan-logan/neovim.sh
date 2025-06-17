#!/bin/bash

cd ~
echo "$(pwd)"
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
echo "$(pwd)"
echo "$(ls -al)"
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
