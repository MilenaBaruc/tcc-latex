# FROM debian:bookworm-slim

# RUN apt-get update && apt-get install -y \
#   ghostscript \
#   texlive-publishers \
#   texlive-lang-portuguese \
#   texlive-latex-extra \
#   texlive-fonts-recommended \
#   make \
#   latexmk

# WORKDIR /home/latex

# Dockerfile para o template TCC FGA-UnB

# Base atualizada do Debian
FROM debian:bookworm-slim

# Evita prompts de instalação interativos
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza repositórios e instala todos os pacotes necessários
RUN apt-get update && apt-get install -y \
    ghostscript \
    texlive-publishers \
    texlive-lang-portuguese \
    texlive-latex-extra \
    texlive-fonts-recommended \
    make \
    latexmk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Define a pasta de trabalho dentro do container
WORKDIR /workspace

# Copia os arquivos do projeto pro container
COPY latex/ ./latex/

# Comando padrão ao rodar o container
CMD ["bash"]
