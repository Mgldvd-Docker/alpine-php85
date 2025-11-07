FROM alpine:latest

RUN apk add --no-cache \
    bash \
    sudo \
    curl \
    neovim \
    coreutils

RUN adduser -D -u 1000 -s /bin/bash master && \
    printf 'master ALL=(ALL) NOPASSWD:ALL\n' > /etc/sudoers.d/master && \
    chmod 0440 /etc/sudoers.d/master

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

RUN ln -sf /usr/bin/php85 /usr/bin/php && \
    ln -sf /usr/sbin/php-fpm85 /usr/sbin/php-fpm

RUN cat << 'EOF' >> /home/master/.bashrc
export PS1="\n\
\[\033[38;2;255;249;143m\] \w\n\
\[\033[38;2;49;94;146m\] ⏹\
\[\033[38;2;255;95;71m\]⏹\
\[\033[38;2;255;182;53m\]⏹\
\[\033[0m\] \
\[\033[38;2;120;150;255m\]python3.12-uv \
\[\033[38;2;140;170;255m\]❱ \
\[\033[0m\] "
alias ll="ls -Xalhv --color=auto --group-directories-first"
alias vim="nvim"
EOF

USER root
RUN mkdir -p /app && chown -R master:master /app
RUN chown -R master:master /home/master

USER master
WORKDIR /app

CMD ["sleep", "infinity"]
