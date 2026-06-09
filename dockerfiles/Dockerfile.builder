FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    make \
    wget \
    tar \
    xz-utils \
    gcc-arm-none-eabi \
    binutils-arm-none-eabi \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash", "-c", "make clean && make --always-make"]