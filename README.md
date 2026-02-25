# linux-setup
Useful linux setup for developers.
## Installation
This will update system packages
```bash
sudo apt update
sudo bash install-basic-package.sh
```

## Developer Utils (brew / Mac)
```
brew install fzf zoxide fd ripgrep bat ast-grep ruff

# for Jetbrains Mono Nerd Font
brew install --cask font-jetbrains-mono-nerd-font
```

## AI Agents Development

### worktrunk via brew
```bash
brew install worktrunk && wt config shell install
```
### worktrunk via curl
```bash
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/max-sixty/worktrunk/releases/download/v0.24.1/worktrunk-installer.sh | sh && wt config shell install
```

## Prompt

Starship: `curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin` and add `eval "$(starship init bash)"` to .bashrc

## Developer Utils (bash / Linux)
```bash
### Ubuntu/Debian package
sudo apt install fzf zoxide fd-find ripgrep bat shellcheck yazi

# additional utils needed for chafa
sudo apt install ffmpeg 7zip imagemagick
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

## Cline
After installing node 24, install `npm install -g cline`

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
