#!/bin/sh

export PATH="${PATH}:/home/ubuntu/.local/bin" >> ~/.bashrc

echo '*** Cloning demo repository'
git clone https://github.com/titom73/atd-containerlab.git

echo '*** intalling cEOS image'
eos-download --image cEOS --version 4.27.3F --import_docker --token <PLEASE-CHANGE-ME-BEFORE-USING-IT>

echo '*** Entering repository'
cd atd-containerlab/containerlab-topology

echo '*** starting containerlab stack'
sudo containerlab deploy --topo topology.yml
