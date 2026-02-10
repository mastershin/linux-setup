# Mutagen for file sync
```bash
mkdir ~/mutagen
cd ~/mutagen

# download
wget https://github.com/mutagen-io/mutagen/releases/download/v0.18.1/mutagen_linux_amd64_v0.18.1.tar.gz

# download and unzip to ~/.local/bin
wget -O - https://github.com/mutagen-io/mutagen/releases/download/v0.18.1/mutagen_linux_amd64_v0.18.1.tar.gz | tar -xzf - -C ~/.local/bin

mutagen project start

# to terminate
mutagen project terminate

# list projects
mutagen project list

# view current sync status
mutagen sync list
```

## ~/mutagen/mutagen.yml sample
```
sync:
  defaults:
    # "two-way-resolved" is best for IDEs; most recent change wins conflicts.
    mode: "two-way-resolved"
    ignore:
      vcs: true # Automatically ignores .git, .hg, etc.
      paths:
        - "__pycache__"
        - "node_modules"
        - "*.pyc"
        - "*.tmp"
        - ".DS_Store"
        - ".ipynb_checkpoints"

  # Session 1: Data Directory
  data:
    alpha: "~/data"
    beta: "<<remote-server:/mnt/data>>"
```
