FROM ubuntu:20.04

# ENV ENV_FILE="/tmp/.env"

# RUN env

# RUN echo "" > ${ENV_FILE}

# RUN NUMCPUS=`grep -c '^processor' /proc/cpuinfo` && echo "export NUMCPUS=$NUMCPUS" >> ${ENV_FILE}


# RUN apt-add-repository ppa:ubuntu-toolchain-r/test

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev \
    iverilog \
&& echo "deps install finished"

# install compiler
# RUN curl -Ls https://apt.llvm.org/llvm.sh | bash -s -- 12


# ARG COMPILER="clang-12"
# RUN CC=${COMPILER} \ 
#     && CXX=$(echo $CC | sed -e 's/clang/clang++/' -e 's/gcc/g++/') \
#     && echo "export CC=$CC" >> ${ENV_FILE} \
#     && echo "export CXX=$CXX" >> ${ENV_FILE}

# ENV CC="clang-12" CCX="clang++-12"
# RUN source ${ENV_FILE} \
#     && apt-get -y install --no-install-recommends $CC $CXX

# install iverilog
# RUN git clone https://github.com/steveicarus/iverilog.git --depth 1
# RUN source ${ENV_FILE} \
#     && cd iverilog \
#     && autoconf \
#     && ./configure \
#     && make -j$(nproc) \
#     && make install