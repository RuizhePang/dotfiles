# Install micromamba
```bash
mkdir  -p ~/.local/bin
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
  | tar -xj -C /tmp bin/micromamba
mv /tmp/bin/micromamba ~/.local/bin/micromamba
chmod +x ~/.local/bin/micromamba
export PATH="$HOME/.local/bin:$PATH"
micromamba --version

```
# Change prefix of micromamba
```bash
export MAMBA_ROOT_PREFIX="$HOME/.micromamba"
```

# Install zsh
```bash
micromamba install -n base -c conda-forge zsh
```

# Add zsh to PATH
```bash
export PATH="$HOME/.micromamba/bin:$HOME/.local/bin:$PATH"
```

# Install oh-my-zsh
```bash
export PATH="$HOME/.local/bin:$PATH"
RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
"" --unattended
```

# Install zsh theme
```bash
git clone --depth=1 \
  https://github.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

# Install Neovim
```bash
cd ~
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
mkdir -p ~/.local
cp -r ~/nvim-linux-x86_64/* ~/.local/
rm -rf ~/nvim-linux-x86_64
rm -f ~/nvim-linux-x86_64.tar.gz
nvim --version
```
