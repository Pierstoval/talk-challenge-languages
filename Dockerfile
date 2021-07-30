FROM ubuntu:20.04

ENV LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB.UTF-8 \
    LC_ALL=en_GB.UTF-8 \
    DENO_INSTALL="/usr/local/deno" \
    NVM_DIR="/usr/local/nvm"

ENV PATH="${PATH}:/usr/local/go/bin"
ENV PATH="${PATH}:/usr/local/v"
ENV PATH="${PATH}:/usr/local/deno/bin"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get upgrade -y \
        ca-certificates \
        curl \
        make \
        vim \
        git \
        locales `# Needed for some languages like Java or PHP` \
        zip `# Needed for Deno` \
        \
    && locale-gen en_GB.UTF-8 \
    \
    `# Now install each language one by one` \
    \
    && apt-get upgrade -y \
    `# C`              gcc \
    `# C++`            g++ \
    `# Cobol`          open-cobol \
    `# Fortran`        gfortran-9 \
    `# Haskell`        haskell-platform \
    `# Java`           default-jdk \
    `# Julia`          julia \
    `# Lisp`           sbcl \
    `# Lua`            lua5.3 \
    `# Ocaml`          ocaml \
    `# Perl`           perl \
    `# PHP`            php-cli \
    `# Python`         python3 \
    `# Ruby`           ruby \
    `# Deno`           && curl -fsSL https://deno.land/x/install/install.sh | sh \
    `# Go`             && curl -fsSL https://golang.org/dl/go1.16.6.linux-amd64.tar.gz --output go.tar.gz && tar -C /usr/local -xzf go.tar.gz && rm go.tar.gz \
    `# Rust`           && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    `# Node.js`        && mkdir -p $NVM_DIR && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install node \
    `# Typescript`     && \. "$NVM_DIR/nvm.sh" && npm -g install typescript \
    `# V`              && git clone https://github.com/vlang/v /usr/local/v && make -C /usr/local/v `# Careful: V needs GCC` \
    \
    `# Clean apt and remove unused libs/packages to make image smaller` \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $BUILD_LIBS \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/www/* /var/cache/* /home/.composer/cache
