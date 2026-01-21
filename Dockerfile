FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
build-essential \
git \
make \
cmake \
verilator \
gtkwave \
python3 \
python3-pip \
iverilog \
yosys && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR / RISC-V-32-Bit-Single-Cycle-Processor

COPY . .

CMD ["/bin/bash"]

