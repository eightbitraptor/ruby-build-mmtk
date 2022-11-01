# syntax=docker/dockerfile:1.3-labs
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    tig \
    mg \
    bison \
    wget \
    ruby \
    libyaml-dev \
    autoconf \
    libssl-dev \
    zlib1g-dev \
    libffi-dev \
    libreadline-dev \
    libgdbm-dev \
    lldb \
    clang

WORKDIR /opt
RUN wget https://www.openssl.org/source/openssl-1.1.1o.tar.gz
RUN tar -zxvf openssl-1.1.1o.tar.gz
WORKDIR openssl-1.1.1o
RUN ./config
RUN make
RUN mkdir /opt/lib
RUN mv /opt/openssl-1.1.1o/libcrypto.so.1.1 /opt/lib/
RUN mv /opt/openssl-1.1.1o/libssl.so.1.1 /opt/lib/

ENV LD_LIBRARY_PATH=$HOME/opt/lib:$LD_LIBRARY_PATH

WORKDIR /root
RUN git clone https://github.com/rbenv/ruby-build.git && \
    PREFIX=/opt/ruby-build ./ruby-build/install.sh

COPY ruby-mmtk-trunk ruby-mmtk-trunk
RUN /opt/ruby-build/bin/ruby-build ruby-mmtk-trunk /opt/ruby

COPY bootstrap-lldb.sh bootstrap-lldb.sh
RUN ./bootstrap-lldb.sh
