eval "$(/opt/homebrew/bin/brew shellenv)"

# Add ~/bin to $PATH
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles if they exist and are readable
for file in ~/.path ~/.zprompt ~/.exports ~/.aliases ~/.functions ~/.extra; do
  [[ -r "$file" ]] && source "$file"
done
unset file

# Case-insensitive globbing
setopt nocaseglob

# Append to the history file, don't overwrite
setopt appendhistory

# Autocorrect minor errors in 'cd' command
setopt correct

# Enable auto-cd: entering a directory name changes to that directory
setopt autocd

# Load completions for Homebrew if available
if type brew >/dev/null 2>&1; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# Initialize completion system
autoload -Uz compinit
compinit

# Enable completion for 'g' as alias for git
if type git >/dev/null 2>&1; then
  compdef _git g
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
