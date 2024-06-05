# Use a imagem base do Debian
FROM debian:buster

# Instale o OpenSSH Server e outros pacotes necessários
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Crie o diretório necessário para o SSH
RUN mkdir /var/run/sshd

# Configure a senha para o usuário root
RUN echo 'root:root' | chpasswd

# Permitir login com senha
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Permitir root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Desativar o uso do PAM (opcional)
RUN sed -i 's/usePAM yes/usePAM no/' /etc/ssh/sshd_config
RUN apt-get update -y  && apt-get upgrade && apt-get install -y curl
# Expor a porta 22
EXPOSE 22

# Instalar o code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Expor a porta 8080 para o code-server
EXPOSE 8080


# Instalar NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Carregar NVM e instalar Node.js
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 14.17.0
RUN . "$NVM_DIR/nvm.sh" \
    && nvm install $NODE_VERSION \
    && nvm use $NODE_VERSION \
    && nvm alias default $NODE_VERSION

# Garantir que Node.js está disponível globalmente
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


# Comando para iniciar o SSH e o code-server
CMD ["/bin/bash", "-c", "/usr/sbin/sshd && code-server --bind-addr 0.0.0.0:8080 --auth password"]
