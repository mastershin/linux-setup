# linux-setup

Useful linux setup for developers.

## Installation

This will update system packages

```bash

# For Debian 13 / Ubuntu 24
sudo apt update
sudo apt upgrade
sudo apt install build-essential git git-lfs curl
sudo apt install htop wireguard wget auditd netcat-openbsd trash-cli tmux nmap rsyslog fail2ban 7zip shfmt fzf zoxide fd-find ripgrep bat shellcheck ffmpeg 7zip imagemagick

# older ubuntu (deprecated)
# sudo bash install-basic-package.sh
```

## AI Agents Development

### starship prompt
```
Starship: `curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin` and add `eval "$(starship init bash)"` to .bashrc
```
### rust, worktrunk

```bash
# Rust
curl https://sh.rustup.rs -sSf | sh

# worktrunk
cargo install worktrunk && wt config shell install

```

## Developer Utils (bash / Linux)
```bash
sudo apt install podman-toolbox
podman login quay.io
toolbox create --distro ubuntu --release 24
toolbox create --distro debian --release 13
```
- or -
```bash
sudo apt install distrobox
distrobox create --name ubuntu-dev --image ubuntu:24.04 --yes --additional-packages "fzf zoxide fd-find ripgrep bat shellcheck yazi"
distrobox create --name debian-dev --image debian:13 --yes --additional-packages "fzf zoxide fd-find ripgrep bat shellcheck yazi"

distrobox create --name rocky-dev --image rockylinux:9 --yes --additional-packages "fzf zoxide fd-find ripgrep bat shellcheck yazi"


# for kali
distrobox create --name kali --image docker.io/kalilinux/kali-rolling --yes --additional-packages "fzf zoxide fd-find ripgrep bat shellcheck"

```

```bash
### Ubuntu/Debian package
sudo apt install fzf zoxide fd-find ripgrep bat shellcheck yazi

# additional utils needed for chafa
sudo apt install ffmpeg 7zip imagemagick

# install bun (or via npm: npm install -g bun)
curl -fsSL https://bun.com/install | bash
```

```bash
### fzf (download binary release) to ~/.local/bin
wget -qO- https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz | tar -xz -C ~/.local/bin

### zoxide (z / autojump inspired cd)
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
# add this to .bashrc: `eval "$(zoxide init bash)"' >>~/.bashrc`


### fd (find alternative)
ARCH=$(uname -m) && wget -qO- "https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-${ARCH}-unknown-linux-gnu.tar.gz" | tar -xz -C ~/.local/bin --strip-components=1 --wildcards '*/fd'

### ripgrep
ARCH=$(uname -m) && wget -qO- https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-${ARCH}-unknown-linux-musl.tar.gz | tar -xz -C ~/.local/bin --strip-components=1 --wildcards '*/rg'

### bat
ARCH=$(uname -m) && wget -qO- https://github.com/sharkdp/bat/releases/download/v0.26.1/bat-v0.26.1-${ARCH}-unknown-linux-gnu.tar.gz | tar -xz -C ~/.local/bin --strip-components=1 --wildcards '*/bat'

### shellcheck
ARCH=$(uname -m) && wget -qO- "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.${ARCH}.tar.xz" | tar -xJv -C ~/.local/bin --strip-components=1

### ast-grep (via npm) - alternative: uv tool install (see below)
# npm install --global @ast-grep/cli

### ast-grep, ruff, ty, prek, zizmor
# curl -LsSf https://astral.sh/uv/install.sh | sh
# for tool in ast-grep-cli ruff hatchling prek zizmor; do uv tool install $tool; done

uv tool install ast-grep-cli
uv tool install ruff
uv tool install hatchling
uv tool install prek
uv tool install zizmor
uvx ty check

### actionlint
bash <(curl https://raw.githubusercontent.com/rhysd/actionlint/main/scripts/download-actionlint.bash) && mv actionlint ~/.local/bin/

### For Node based development:
npm install -g oxlint oxfmt vitest eslint-plugin-import
npm install -g typescript
```

# AI Agent

## Popular choices (both offline and online)

```
# kilo
npm install -g @kilocode/cli

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# Gemini CLI
npm install -g @google/gemini-cli

# OpenAI Codex
npm i -g @openai/codex
```

## Kilo

Install `npm install -g @kilocode/cli`
Create `~/.config/kilo/opencode.json`

```
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama",
      "options": {
        "baseURL": "http://localhost:11434/v1"
      },
      "models": {
        "gpt-oss": {
          "name": "gpt-oss"
        }
      }
    }
  }
}
```

## OpenCode + Ollama + gpt-oss

Install `curl -fsSL https://opencode.ai/install | bash`
Create `~/.config/opencode/opencode.json`

```
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama",
      "options": {
        "baseURL": "http://localhost:11434/v1"
      },
      "models": {
        "gpt-oss": {
          "name": "gpt-oss"
        }
      }
    }
  }
}
```

## Claude Code + Ollama + gpt-oss

Install `curl -fsSL https://claude.ai/install.sh | bash`
Create `claude-ollama.sh`

```bash
#!/bin/bash
DEFAULT_OLLAMA_HOST="localhost"
DEFAULT_MODEL="gpt-oss"
DEFAULT_ANTHROPIC_BASE_URL=$DEFAULT_OLLAMA_HOST
if [ -z "$1" ]; then
    ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=$DEFAULT_ANTHROPIC_BASE_URL claude --model "$DEFAULT_MODEL"
else
    ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=$DEFAULT_ANTHROPIC_BASE_URL claude --model "$@"
fi
```

## OpenAI Codex + Ollama + gps-oss

Install `npm i -g @openai/codex` and then run `codex --oss -m gpt-oss:20b` or create `~/.codex/config.toml`

```bash
model = "gpt-oss:20b"
model_provider = "ollama"

[model_providers.ollama]
name = "Ollama"
base_url = "https://ollama.com/v1"
env_key = "<<OLLAMA_API_KEY>>"
```

## Cline

After installing node 24, install `npm install -g cline`

## using Nvidia/Nemotron-3-super nvfp4 w/ vllm (<100 GB GPU)
```
services:
  vllm-nemotron-3-super-nvfp4:
    image: vllm/vllm-openai:v0.18.0-cu130
    container_name: vllm-nemotron-3-super-nvfp4
    runtime: nvidia
    ports:
      - "<<PORT>>:8000"
    volumes:
      - ~/.cache/huggingface:/root/.cache/huggingface
    environment:
      - VLLM_ALLOW_LONG_MAX_MODEL_LEN=1
    ipc: host
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    command: >
      nvidia/NVIDIA-Nemotron-3-Super-120B-A12B-NVFP4
      --served-model-name nvidia/nemotron-3-super
      --async-scheduling
      --dtype auto
      --max-model-len 1048576
      --trust-remote-code
      --gpu-memory-utilization 0.9
      --max-cudagraph-capture-size 128
      --enable-chunked-prefill
      --mamba-ssm-cache-dtype float16
      --reasoning-parser nemotron_v3
      --enable-auto-tool-choice
      --tool-call-parser qwen3_coder
    restart: unless-stopped
```

## using Qwen3.5 35B-A3b FP8 vllm w/ nvidia (<100 GB)

```
services:
  vllm-qwen:
    image: vllm/vllm-openai:nightly
    container_name: vllm-qwen3.5
    runtime: nvidia
    ports:
      - "<<PORTS>>:8000"
    volumes:
      - ~/.cache/huggingface:/root/.cache/huggingface
    environment:
      - HF_TOKEN=${HF_TOKEN}
    ipc: host
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    # The actual model launch command
    command: >
      --model Qwen/Qwen3.5-35B-A3B-FP8
      --kv-cache-dtype fp8_e4m3
      --max-model-len 131072
      --trust-remote-code
      --reasoning-parser qwen3
    restart: unless-stopped
```
