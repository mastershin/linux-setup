# Mac
## Using bash and startship
```
# install nerd font
brew install starship

# add to ~/.bashrc
eval "$(starship init bash)"



```

## ~/.config/starship.toml
```
[python]
symbol = "👾 "

format = """
$username\
$hostname\
$directory\
$git_branch\
$line_break\
$character"""

[hostname]
ssh_only = false
style = "bold green"
format = "[$hostname]($style):"

[username]
show_always = true
style_user = "bold blue"
format = "[$user]($style)@"

[git_branch]
symbol = "🌱 "
style = "bold purple"
format = "on [$symbol$branch]($style) "

[git_status]
style = "red"
format = "([$all_status$ahead_behind]($style) )"

[cmd_duration]
min_time = 2000   # Show only if command takes longer than 2000ms (2s)
format = "took [$duration]($style) "
style = "bold yellow"
```
