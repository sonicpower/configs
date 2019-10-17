#!/bin/sh

# This script is used to:
#   Install Pathogen if necessary
#   Install Vim solarized
#   Install Nerdtree for vim
#   Install nerdcommenter for vim
#   Install vim-fugitive
#   Install ctrlp
#   Install oh-my-zsh
#   Install powerlevel9k
#   Install zsh-autosuggestions
#   Install zsh-syntax-highlighting
#   Set .vimrc to https://raw.github.com/ChengLong/configs/master/.vimrc
#   Set .zsh_aliases to https://raw.github.com/ChengLong/configs/master/.zsh_aliases
#   Set .zshrc to https://raw.github.com/ChengLong/configs/master/.zshrc
#   Source .zshrc
#   Source tmux config
#
# It's assumed that these libs are already installed
#   1. curl
#   2. git
#   3. zsh
#   4. vim

exists() {
  if hash $1 2>/dev/null; then
    return 0
  else
    echo "$1 doesn't exist"
    return 1
  fi
}

exists curl
has_curl=$?

exists git
has_git=$?

exists zsh
has_zsh=$?

exists vim
has_vim=$?

# check required libs exist
if [ $has_curl ] && [ $has_git ] && [ $has_zsh ] && [ $has_vim ]; then
  echo "All required libs exist..."
else
  echo "One or more of curl, git, zsh, vim is not installed. Exiting..."
  exit 1
fi

# install pathogen
if [ -f "$HOME/.vim/autoload/pathogen.vim" ]; then
  echo "Pathogen already installed."
else
  echo "Installing pathogen"
  mkdir -p ~/.vim/autoload ~/.vim/bundle
  curl $(fwdproxy-config curl) -LSso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
fi

# install vim solarized
if [ -d "$HOME/.vim/bundle/vim-colors-solarized" ]; then
  echo "Vim Solarized is already installed"
else
  echo "Installing Vim Solarized"
  git -c https_proxy=http://regional-fwdproxy6-shv-01.rash0.facebook.com:8080 clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
fi

# install nerdtree
if [ -d "$HOME/.vim/bundle/nerdtree" ]; then
  echo "Nerdtree already installed"
else
  echo "Installing Nerdtree"
  git -c https_proxy=http://regional-fwdproxy6-shv-01.rash0.facebook.com:8080 clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
fi

# install nerdcommenter
if [ -d "$HOME/.vim/bundle/nerdcommenter" ]; then
  echo "nerdcommenter already installed"
else
  echo "Installing nerdcommenter"
  git -c https_proxy=http://regional-fwdproxy6-shv-01.rash0.facebook.com:8080 clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
fi

# install vim-fugitive
if [ -d "$HOME/.vim/bundle/vim-fugitive" ]; then
  echo "vim-fugitive already installed"
else
  echo "Installing vim-fugitive"
  git -c https_proxy=http://regional-fwdproxy6-shv-01.rash0.facebook.com:8080 clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
fi

if [ -d "$HOME/.vim/bundle/ctrlp.vim" ]; then
  echo "ctrlp already installed"
else
  echo "Installing ctrlp"
  git -c https_proxy=http://regional-fwdproxy6-shv-01.rash0.facebook.com:8080 clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh already installed"
else
  echo "Installing oh-my-zsh"
  sh -c "$(curl $(fwdproxy-config curl) -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

if [ -d "$ZSH_CUSTOM/themes/powerlevel9k" ]; then
  echo "powerlevel9k already installed"
else
  echo "Installing powerlevel9k"
  git -c https_proxy=http://regional-fwdproxy6-shv-01.rash0.facebook.com:8080 clone https://github.com/bhilburn/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k
fi

if [ -d "$ZSH_CUSTOM/themes/zsh-autosuggestions" ]; then
  echo "zsh-autosuggestions already installed"
else
  echo "Installing zsh-autosuggestions"
  git -c https_proxy=http://regional-fwdproxy6-shv-01.rash0.facebook.com:8080 clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ -d "$ZSH_CUSTOM/themes/zsh-syntax-highlighting" ]; then
  echo "zsh-syntax-highlighting already installed"
else
  echo "Installing zsh-syntax-highlighting"
  git -c https_proxy=http://regional-fwdproxy6-shv-01.rash0.facebook.com:8080 clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# copy .vimrc from my github
curl $(fwdproxy-config curl) -LSso ~/.vimrc https://raw.github.com/sonicpower/configs/master/.vimrc

# copy aliases from my github
curl $(fwdproxy-config curl) -LSso $ZSH_CUSTOM/.zsh_aliases https://raw.github.com/sonicpower/configs/master/.zsh_aliases

# copy .zshrc from my github
curl $(fwdproxy-config curl) -LSso ~/.zshrc https://raw.github.com/sonicpower/configs/master/.zshrc

source ~/.zshrc
