#! /bin/bash
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish

sudo apt-get install -y $(cat deps.sh)

curl -sS https://starship.rs/install.sh | sh

./neovim.sh

echo $(which fish) | sudo tree -a /etc/shells
chsh -s $(which fish)
