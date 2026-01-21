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
