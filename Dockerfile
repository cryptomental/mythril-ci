#
# Docker Image with Mythril and Solc for CI/CD of Ethereum Solidity Codes
#

# Pull base image
FROM ubuntu:16.04

# Install Python && Necessary build tools
RUN \
  apt-get update && \
  apt-get install -y build-essential software-properties-common libssl-dev wget && \
  apt-get install -y python3 python3-dev python3-pip

# Install Solidity compiler 0.4.20 release
RUN wget https://github.com/ethereum/solidity/releases/download/v0.4.20/solc-static-linux && \
  mv solc-static-linux /usr/bin/solc

# Creating symmetric links to refer python3/pip3 as python/pip
RUN \
  ln -sf /usr/bin/python3 /usr/bin/python && \
  ln -sf /usr/bin/pip3 /usr/bin/pip

# Install Mythril
RUN \
  pip install mythril

# Create scripts directory to store the python script
RUN mkdir scripts

# Copy local python script to Docker image
COPY scripts/processor.py scripts/processor.py

# Set SOLC environment variable
ENV SOLC /usr/bin/solc

# Add exec rights to solc
RUN chmod +x /usr/bin/solc

