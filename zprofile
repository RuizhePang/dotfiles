export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
