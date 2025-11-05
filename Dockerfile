FROM alpine:latest

# Base tools (no python)
RUN apk update && apk add --no-cache \
    bash \
    sudo \
    curl \
    neovim \
    coreutils

# Create user with bash as default shell and passwordless sudo
RUN adduser -D -s /bin/bash master && \
    echo 'master ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/master && \
    chmod 0440 /etc/sudoers.d/master

# Install PHP 8.5 RC from Alpine edge repositories
# Note: php85-opcache is not available yet in Alpine; omit it to avoid build failures.
RUN apk add --no-cache \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing \
    php85 \
    php85-cli \
    php85-fpm \
    php85-mbstring \
    php85-curl \
    php85-zip \
    php85-xml \
    php85-dom \
    php85-pdo \
    php85-pdo_mysql

# Ensure "php" points to php85
RUN ln -sf /usr/bin/php85 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm85 /usr/sbin/php-fpm

# Home setup
WORKDIR /home/master
RUN chown -R master:master /home/master

USER master

# Prompt and aliases (dynamic hostname via \h)
RUN cat << 'EOF' >> /home/master/.bashrc
export PS1="\n\[\033[38;2;49;94;146m\]▍\[\033[38;2;255;95;71m\]▍\[\033[38;2;255;182;53m\]▍\[\033[0m\] \[\033[38;2;120;150;255m\]alpine-php8.5 \[\033[38;2;140;170;255m\]❱ \[\033[0m\]"
alias ll="ls -Xalhv --color=auto --group-directories-first"
alias vim="nvim"
EOF

# App directory owned by master
USER root
RUN mkdir -p /app && chown -R master:master /app
USER master
WORKDIR /app

# Default to bash (loads .bashrc in interactive shells)
CMD ["/bin/bash"]
