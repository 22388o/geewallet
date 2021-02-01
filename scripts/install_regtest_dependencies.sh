#!/usr/bin/env bash
set -eux

# Set up variables needed for the regtest test

# This is needed to find lnd in PATH
#export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
# This is needed to convince electrum to run on CI as root
#export ALLOW_ROOT=1


# Install bitcoin core
# apt install -y curl tar gzip
# curl -OJL https://bitcoin.org/bin/bitcoin-core-0.20.0/bitcoin-0.20.0-x86_64-linux-gnu.tar.gz
# tar -C /usr/local --strip-components 1 -xzf bitcoin-0.20.0-x86_64-linux-gnu.tar.gz

# Install electrumx
#apt install -y curl unzip python3-pip
#curl -L https://github.com/spesmilo/electrumx/archive/1.15.0.zip -o electrumx-1.15.0.zip
#unzip electrumx-1.15.0.zip
#pip3 install ./electrumx-1.15.0

# required by apt-key
apt install -y gnupg2
apt install -y ca-certificates

# Install "cryptoanarchy" debian repo. This contains packages for bitcoind, lnd and electrs
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 3D9E81D3CA76CDCBE768C4B4DC6B4F8E60B8CF4C
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF
gpg --export 3D9E81D3CA76CDCBE768C4B4DC6B4F8E60B8CF4C | apt-key add -
gpg --export BC528686B50D79E339D3721CEB3E94ADBE1229CF | apt-key add -
echo 'deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/debian/10/prod buster main' > /etc/apt/sources.list.d/microsoft.list
echo 'deb https://deb.ln-ask.me/beta buster common local desktop' > /etc/apt/sources.list.d/cryptoanarchy.list
apt update

# install bitcoin core
apt install -y bitcoin-fullchain-regtest bitcoind bitcoin-cli

# Install electrs
apt install -y electrs

# Install lnd
apt install -y lnd

# Install lnd
# apt install -y curl tar gzip unzip make git
# curl -OJL https://golang.org/dl/go1.14.4.linux-amd64.tar.gz
# tar -C /usr/local -xzf go1.14.4.linux-amd64.tar.gz
# git clone https://github.com/lightningnetwork/lnd
# pushd lnd
# git checkout v0.10.3-beta
# make
# make install
# popd