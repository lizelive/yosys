ARG IMAGE="ubuntu:20.04"

#---

FROM $IMAGE AS base

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
   && apt-get -y install --no-install-recommends \
   ca-certificates \
   clang \
   curl \
   libffi-dev \
   libreadline-dev \
   tcl-dev \
   graphviz \
   xdot \
   && echo "installed base deps"

#---
FROM base as dev

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
   && apt-get -y install --no-install-recommends \
   build-essential clang bison flex \
   libreadline-dev gawk tcl-dev libffi-dev git \
   graphviz xdot pkg-config python3 libboost-system-dev \
   libboost-python-dev libboost-filesystem-dev zlib1g-dev \
   iverilog ccache \
   && echo "installed dev deps"


#---

FROM dev AS build

COPY . /src

ENV PREFIX /opt/yosys
ENV CCACHE_DIR /tmp/ccache

RUN --mount=type=cache,target=/tmp/ccache \
   cd /src && ccache -sz\
   # && export MAKEFLAGS='-j$(nproc)' \
   && make ENABLE_CCACHE=1 \
   && make install \
   && ccache -s

#---

FROM base as cli

COPY --from=build /opt/yosys /opt/yosys

ENV PATH /opt/yosys/bin:$PATH

RUN useradd -m yosys
USER yosys

CMD ["yosys"]
