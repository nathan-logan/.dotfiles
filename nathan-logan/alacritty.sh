#!/bin/bash

# Install deps so we can build Alacritty from source using Cargo
sudo apt install cmake g++ pkg-config libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

if ! command -v cargo version &> /dev/null; then
  echo "Command 'cargo' does not exist. Installing now"

  bash ./rust.sh
  source "$HOME/.cargo/env.fish"
else
  echo "Cargo available, skipping install"
fi

cd ~

# If the repo is already cloned pull the latest
if [ -e "$HOME/alacritty" ]; then
  cd ./alacritty
  # Ensure we're checked out on this specific version
  git checkout tags/v0.15.1
else
  git clone https://github.com/alacritty/alacritty
  cd alacritty
  git checkout tags/v0.15.1
fi

cargo build --release

if [ -e "target/release/alacritty" ]; then
  sudo mv ./target/release/alacritty /usr/local/bin
else
  echo "!!! Release build not found !!!"
fi
