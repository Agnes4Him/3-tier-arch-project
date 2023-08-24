#!/bin/bash

# Install NodeJS, npm and git
sudo apt update
sudo apt upgrade
sudo apt install curl
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs
sudo apt install git