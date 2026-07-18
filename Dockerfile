FROM debian:stable-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl jq git sudo procps net-tools xterm tigervnc-standalone-server xvfb fluxbox && echo "root:root" | chpasswd && useradd -m -s /bin/bash runner && echo "runner:root" | chpasswd && usermod -aG sudo runner && echo "runner ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/runner && chmod 440 /etc/sudoers.d/runner && apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/*
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/
USER runner
ENV HOME=/home/runner
ENV PATH=/home/runner/venv/bin:$PATH
WORKDIR $HOME
RUN uv python install && uv venv /home/runner/venv && printf '%s\n' '#!/bin/sh' 'export VIRTUAL_ENV=/home/runner/venv' 'exec /usr/local/bin/uv pip "$@"' > /home/runner/venv/bin/pip && chmod +x /home/runner/venv/bin/pip && rm -rf /home/runner/.cache/uv /home/runner/.cache/pip /tmp/*
WORKDIR /home/runner/workspace
EXPOSE 9119 5000 5901 8080
CMD ["/bin/bash", "-c", "set -e; sudo apt-get update -y; cd /home/runner/workspace; git init 2>/dev/null || true; git remote add origin https://bitbucket.org/hermes-new/hermes.git 2>/dev/null || true; git fetch origin --depth=1 2>/dev/null || true; git checkout -b main origin/main 2>/dev/null || true; bash /home/runner/workspace/scripts/hermes.sh"]
