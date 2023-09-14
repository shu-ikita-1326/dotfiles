FROM ubuntu:22.04

# Args
ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG HOMEDIR=/home/$USERNAME

# Create user and group
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

# Install tools
RUN apt update && apt install -y --no-install-recommends \
    curl \
    git \
    ripgrep \
    fd-find \
    unzip \
    golang-go \
    npm \
    python3-pip \
    python3-venv \
    g++ && \
    curl -o /root/nvim-linux64.deb -LO https://github.com/neovim/neovim-releases/releases/download/nightly/nvim-linux64.deb && \
    apt install /root/nvim-linux64.deb && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/fdfind /usr/bin/fd

# Change user
USER $USERNAME

# Install Deno
RUN curl -fsSL https://deno.land/x/install/install.sh | bash

# Install lazygit
RUN go install github.com/jesseduffield/lazygit@latest

# Setting environment
RUN echo 'export PATH=$HOME/.deno/bin:$PATH' >> $HOME/.bashrc && \
    echo 'export PATH=$HOME/go/bin:$PATH' >> $HOME/.bashrc && \
    echo 'export SHELL=/bin/bash' >> $HOME/.bashrc

COPY --chown=$USERNAME:$GROUPNAME ./.config $HOMEDIR/.config

WORKDIR $HOMEDIR

RUN nvim +:q
