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
brew install fzf zoxide fd ripgrep bat

# for Jetbrains Mono Nerd Font
brew install --cask font-jetbrains-mono-nerd-font
```

## Developer Utils (bash / Linux)
```
#####################################################################################
# fzf (download binary release) to ~/.local/bin
wget -qO- https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz | tar -xz -C ~/.local/bin

#####################################################################################
# zoxide (z / autojump inspired cd)
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo 'eval "$(zoxide init bash)"' >>~/.bashrc

#####################################################################################
# fd (find alternative)
wget -qO- https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C ~/.local/bin --strip-components=1 --wildcards '*/fd'

#####################################################################################
# ripgrep
wget -qO- https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz | tar -xz -C ~/.local/bin --strip-components=1 --wildcards '*/rg'

#####################################################################################
# bat
wget -qO- https://github.com/sharkdp/bat/releases/download/v0.26.1/bat-v0.26.1-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C ~/.local/bin --strip-components=1 --wildcards '*/bat'

```

# AI Agent
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
