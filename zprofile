# Homebrew (macOS only)
if [[ "$(uname -s)" == "Darwin" ]] && command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi

# Load the shell dotfiles if they exist and are readable
for file in ~/.path ~/.exports ~/.aliases ~/.functions ~/.extra; do
  [[ -r "$file" ]] && source "$file"
done
unset file

setopt nocaseglob
setopt appendhistory
setopt correct
setopt autocd

autoload -Uz compinit
if [[ ! -f ~/.zcompdump || ~/.zcompdump -nt ~/.zshrc ]]; then
    compinit
else
    compinit -C
fi

if command -v git >/dev/null 2>&1; then
    compdef _git g 2>/dev/null
fi

# Completion for ssh/scp/sftp hosts based on ~/.ssh/config ignoring wildcards
if [[ -f ~/.ssh/config ]]; then
  ssh_hosts=($(grep '^Host ' ~/.ssh/config | grep -v '[?*]' | cut -d' ' -f2-))
  compdef '_arguments "*:hostname:(${ssh_hosts[*]})"' ssh scp sftp
fi

# Completion for 'defaults' NSGlobalDomain
compdef '_values NSGlobalDomain NSGlobalDomain' defaults

# Completion for killall common apps
killall_apps=(
  Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter
)
compdef "_values killall_apps $killall_apps" killall
