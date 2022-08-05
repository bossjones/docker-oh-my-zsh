#syntax=docker/dockerfile:1.3
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# LABEL mantainer="Read the Docs <support@readthedocs.com>"
# LABEL version="ubuntu-22.04-2022.03.15"

# ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt update && apt install -y curl git gnupg zsh tar software-properties-common vim


# Running this here so we can add tools quickly while relying on cache for layers above
RUN apt update && apt install -yq fzf perl gettext direnv vim awscli

# SOURCE: https://github.com/readthedocs/readthedocs-docker-images/blob/main/Dockerfile
# Install requirements
RUN apt-get -y install \
        build-essential \
        bzr \
        curl \
        doxygen \
        g++ \
        git-core \
        graphviz-dev \
        libbz2-dev \
        libcairo2-dev \
        libenchant-2-2 \
        libevent-dev \
        libffi-dev \
        libfreetype6 \
        libfreetype6-dev \
        libgraphviz-dev \
        libjpeg8-dev \
        libjpeg-dev \
        liblcms2-dev \
        libmysqlclient-dev \
        libpq-dev \
        libreadline-dev \
        libsqlite3-dev \
        libtiff5-dev \
        libwebp-dev \
        libxml2-dev \
        libxslt1-dev \
        libxslt-dev \
        mercurial \
        pandoc \
        pkg-config \
        postgresql-client \
        subversion \
        zlib1g-dev

# # LaTeX -- split to reduce image layer size
# RUN apt-get -y install \
#     texlive-fonts-extra
# RUN apt-get -y install \
#     texlive-lang-english
# RUN apt-get -y install \
#     texlive-full
    
# asdf Python extra requirements
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
RUN apt-get install -y \
    liblzma-dev \
    libncursesw5-dev \
    libssl-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    wget \
    xz-utils

# asdf nodejs extra requirements
# https://github.com/asdf-vm/asdf-nodejs#linux-debian
RUN apt-get install -y \
    dirmngr \
    gpg

# asdf Golang extra requirements
# https://github.com/kennyp/asdf-golang#linux-debian
RUN apt-get install -y \
    coreutils
###########################################################################################

# ############################################################################################################################
# # set the variables as per $(pyenv init -)
# ENV LANG="C.UTF-8" \
#     LC_ALL="C.UTF-8" \
#     PATH="/opt/pyenv/shims:/opt/pyenv/bin:$PATH" \
#     PYENV_ROOT="/opt/pyenv" \
#     PYENV_SHELL="zsh"

# RUN apt-get update && apt-get install -y --no-install-recommends \
#         build-essential \
#         ca-certificates \
#         curl \
#         git \
#         libbz2-dev \
#         libffi-dev \
#         libncurses5-dev \
#         libncursesw5-dev \
#         libreadline-dev \
#         libsqlite3-dev \
#         libssl1.0-dev \
#         liblzma-dev \
#         # libssl-dev \
#         llvm \
#         make \
#         netbase \
#         pkg-config \
#         tk-dev \
#         wget \
#         xz-utils \
#         zlib1g-dev \
# && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# COPY pyenv-version.txt python-versions.txt /

# RUN git clone -b `cat /pyenv-version.txt` --single-branch --depth 1 https://github.com/pyenv/pyenv.git $PYENV_ROOT \
#     && for version in `cat /python-versions.txt`; do pyenv install $version; done \
#     && pyenv global `cat /python-versions.txt` \
#     && find $PYENV_ROOT/versions -type d '(' -name '__pycache__' -o -name 'test' -o -name 'tests' ')' -exec rm -rf '{}' + \
#     && find $PYENV_ROOT/versions -type f '(' -name '*.pyo' -o -name '*.exe' ')' -exec rm -f '{}' + \
# && rm -rf /tmp/*

# COPY requirements-setup.txt requirements-test.txt requirements-ci.txt /
# RUN pip install -r /requirements-setup.txt \
#     && pip install -r /requirements-test.txt \
#     && pip install -r /requirements-ci.txt \
#     && find $PYENV_ROOT/versions -type d '(' -name '__pycache__' -o -name 'test' -o -name 'tests' ')' -exec rm -rf '{}' + \
#     && find $PYENV_ROOT/versions -type f '(' -name '*.pyo' -o -name '*.exe' ')' -exec rm -f '{}' + \
# && rm -rf /tmp/*
# ############################################################################################################################


# RUN curl -sSL https://github.com/asdf-vm/asdf/archive/refs/tags/v0.10.2.tar.gz \
# 		| tar -v -C /root/.asdf -xz

# ############################################################################################################################
# Install asdf
# ############################################################################################################################
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --depth 1 --branch v0.10.2
RUN echo ". /root/.asdf/asdf.sh" >> /root/.bashrc
RUN echo ". /root/.asdf/completions/asdf.bash" >> /root/.bashrc

# Activate asdf in current session
ENV PATH /root/.asdf/shims:/root/.asdf/bin:$PATH

# Install asdf plugins
RUN asdf plugin add python
RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN asdf plugin add rust https://github.com/code-lever/asdf-rust.git
RUN asdf plugin add golang https://github.com/kennyp/asdf-golang.git
RUN asdf plugin-add hadolint https://github.com/looztra/asdf-hadolint
RUN asdf plugin add fd
RUN asdf plugin-add tmux https://github.com/aphecetche/asdf-tmux.git
RUN asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
RUN asdf plugin-add jsonnet https://github.com/Banno/asdf-jsonnet.git
RUN asdf plugin-add k9s https://github.com/looztra/asdf-k9s
RUN asdf plugin-add kubectl https://github.com/Banno/asdf-kubectl.git
RUN asdf plugin add kubectx
RUN asdf plugin-add neovim 
RUN asdf plugin-add packer https://github.com/Banno/asdf-hashicorp.git 
RUN asdf plugin-add terraform https://github.com/Banno/asdf-hashicorp.git 
RUN asdf plugin-add vault https://github.com/Banno/asdf-hashicorp.git 
RUN asdf plugin-add poetry https://github.com/crflynn/asdf-poetry.git 
RUN asdf plugin-add yq https://github.com/sudermanjr/asdf-yq.git 
RUN asdf plugin add ag https://github.com/koketani/asdf-ag.git
RUN asdf plugin-add aria2 https://github.com/asdf-community/asdf-aria2.git
RUN asdf plugin-add argo https://github.com/sudermanjr/asdf-argo.git
RUN asdf plugin-add dive https://github.com/looztra/asdf-dive
RUN asdf plugin-add github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git
RUN asdf plugin add kompose
RUN asdf plugin add mkcert
RUN asdf plugin-add shellcheck
RUN asdf plugin-add shfmt
RUN asdf plugin-add velero https://github.com/looztra/asdf-velero

# Create directories for languages installations
RUN mkdir -p /root/.asdf/installs/python && \
    mkdir -p /root/.asdf/installs/nodejs && \
    mkdir -p /root/.asdf/installs/rust && \
    mkdir -p /root/.asdf/installs/golang && \
    mkdir -p /root/.asdf/installs/kubectl && \
    mkdir -p /root/.asdf/installs/neovim && \
    mkdir -p /root/.asdf/installs/k9s && \
    mkdir -p /root/.asdf/installs/ag && \
    mkdir -p /root/.asdf/installs/velero && \
    mkdir -p /root/.asdf/installs/shfmt && \
    mkdir -p /root/.asdf/installs/shellcheck && \
    mkdir -p /root/.asdf/installs/mkcert && \
    mkdir -p /root/.asdf/installs/github-cli && \
    mkdir -p /root/.asdf/installs/kompose && \
    mkdir -p /root/.asdf/installs/dive && \
    mkdir -p /root/.asdf/installs/yq && \
    mkdir -p /root/.asdf/installs/poetry && \
    mkdir -p /root/.asdf/installs/vault && \
    mkdir -p /root/.asdf/installs/terraform && \
    mkdir -p /root/.asdf/installs/packer && \
    mkdir -p /root/.asdf/installs/kubeval && \
    mkdir -p /root/.asdf/installs/kubectx && \
    mkdir -p /root/.asdf/installs/jsonnet && \
    mkdir -p /root/.asdf/installs/helm && \
    mkdir -p /root/.asdf/installs/tmux && \
    mkdir -p /root/.asdf/installs/fd

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
RUN curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
    
# && \
#     ~/.local/bin/sheldon init --shell zsh


ENV PATH /root/bin:/root/.bin:/root/.local/bin:$PATH

RUN asdf install python 3.9.13 && \
    asdf global python 3.9.13 && \
    asdf install golang 1.16.15 && \
    asdf global golang 1.16.15

COPY plugins.toml /root/.sheldon/plugins.toml
RUN sheldon lock
COPY zshrc.sheldon /root/.zshrc
# COPY zshrc /root/.zshrc
COPY asdf.sh /install-asdf.sh

RUN apt-get install unzip autotools-dev automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev silversearcher-ag ripgrep locales -y

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    locale-gen en_US.UTF-8

RUN asdf install neovim 0.7.2 && \
    asdf global neovim 0.7.2 && \
    asdf install aria2 1.36.0 && \
    asdf global aria2 1.36.0 && \
    asdf install github-cli 2.0.0 && \
    asdf global github-cli 2.0.0 && \
    asdf install shellcheck 0.8.0 && \
    asdf global shellcheck 0.8.0 && \
    asdf install nodejs 16.16.0 && \
    asdf global nodejs 16.16.0 && \
    asdf install shfmt 3.3.1 && \
    asdf global shfmt 3.3.1
    
# install rust
# RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# RUN pip install -U pip wheel setuptools
# RUN  npm install -g neovim tree-sitter-cli

# RUN bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
# RUN curl --proto '=https' -fLsS https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh \
#     | bash -s -- 

ENTRYPOINT ["/usr/bin/zsh"]

# Ballerina runtime distribution filename.
ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="bossjones/docker-oh-my-zsh"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vendor="TonyDark Industries"
LABEL org.label-schema.version=$BUILD_VERSION
LABEL maintainer="jarvis@theblacktonystark.com"
