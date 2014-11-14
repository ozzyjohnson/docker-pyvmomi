FROM ozzyjohnson/python

MAINTAINER Ozzy Johnson <docker@ozzy.io>

ENV DEBIAN_FRONTEND noninteractive

ENV VIMRC /etc/vim/vimrc

RUN \
    apt-get update \
        --quiet \
    && apt-get install \
        --yes \
        --no-install-recommends \
        --no-install-suggests \
    ca-certificates \
    git-core \
    vim \

# Clean up packages.
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Little things for vim. Surely there's a better way?
RUN \
    sed -i 's/^"\(syntax on\)/\1/' $VIMRC \
    && sed -i'' '28,30 s/^"//' $VIMRC \
    && sed -i'' '34,36 s/^"//' $VIMRC \
    && mkdir -p /.vim/ftplugin \
    && printf "set tabstop=8\nset expandtab\nset shiftwidth=4\nset softtabstop=4" > /.vim/ftplugin/python.vim

# Get and build AFL.
RUN pip install\
    pyvmomi

# Samples to poke around with.
RUN git clone https://github.com/vmware/pyvmomi-community-samples.git
    
VOLUME ["/data"]

WORKDIR /data

CMD ["bash"]

