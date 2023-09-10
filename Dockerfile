FROM debian:latest

# Install dependencies
RUN type -p curl >/dev/null || (apt update && apt install curl -y)
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \

RUN apt update && apt install gh git jq -y

# Add source
RUN mkdir -p /data
ADD scripts/cmd.sh /usr/local/bin/cmd.sh
ADD scripts/backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/cmd.sh
RUN chmod +x /usr/local/bin/backup.sh

# Variables
ENV GH_TOKEN=
ENV ROOT_DIR=/data
ENV TARGET_DIR=backups/github
ENV TAR_REPOS=1

CMD ["/usr/local/bin/cmd.sh"]
