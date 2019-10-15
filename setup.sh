#!/bin/sh

# This script is used to:
#   Install Pathogen if necessary
#   Install Vim solarized
#   Install Nerdtree for vim
#   Install nerdcommenter for vim
#   Install AutoComplPop
#   Install vim-fugitive
#   Install ctrlp
#   Install vim-better-whitespace
#   Install oh-my-zsh
#   Set .vimrc to https://raw.github.com/ChengLong/configs/master/.vimrc
#   Set .zsh_aliases to https://raw.github.com/ChengLong/configs/master/.zsh_aliases
#   Set .zshrc to https://raw.github.com/ChengLong/configs/master/.zshrc
#   Set pygmalion.zsh-theme to https://raw.github.com/ChengLong/configs/master/pygmalion.zsh-theme
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
  curl -LSso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
fi

# install vim solarized
if [ -d "$HOME/.vim/bundle/vim-colors-solarized" ]; then
  echo "Vim Solarized is already installed"
else
  echo "Installing Vim Solarized"
  git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
fi

# install nerdtree
if [ -d "$HOME/.vim/bundle/nerdtree" ]; then
  echo "Nerdtree already installed"
else
  echo "Installing Nerdtree"
  git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
fi

# install nerdcommenter
if [ -d "$HOME/.vim/bundle/nerdcommenter" ]; then
  echo "nerdcommenter already installed"
else
  echo "Installing nerdcommenter"
  git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
fi

# install AutoComplPop
if [ -d "$HOME/.vim/bundle/AutoComplPop" ]; then
  echo "AutoComplPop already installed"
else
  echo "Installing AutoComplPop"
  git clone https://github.com/vim-scripts/AutoComplPop.git ~/.vim/bundle/AutoComplPop
fi

# install vim-fugitive
if [ -d "$HOME/.vim/bundle/vim-fugitive" ]; then
  echo "vim-fugitive already installed"
else
  echo "Installing vim-fugitive"
  git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
fi

if [ -d "$HOME/.vim/bundle/ctrlp.vim" ]; then
  echo "ctrlp already installed"
else
  echo "Installing ctrlp"
  git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
fi

if [ -d "$HOME/.vim/bundle/vim-better-whitespace" ]; then
  echo "vim-better-whitespace already installed"
else
  echo "Installing vim-better-whitespace"
  git clone https://github.com/ntpeters/vim-better-whitespace.git ~/.vim/bundle/vim-better-whitespace
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh already installed"
else
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# copy .vimrc from my github
curl -LSso ~/.vimrc https://raw.github.com/ChengLong/configs/master/.vimrc

# copy aliases
curl -LSso ~/.zsh_aliases https://raw.github.com/ChengLong/configs/master/.zsh_aliases

# copy .zshrc
curl -LSso ~/.zshrc https://raw.github.com/ChengLong/configs/master/.zshrc

# copy pygmalion.zsh-theme
curl -LSso ~/.oh-my-zsh/themes/pygmalion.zsh-theme https://raw.github.com/ChengLong/configs/master/pygmalion.zsh-theme

# copy .tmux.conf
curl -LSso ~/.tmux.conf https://raw.github.com/ChengLong/configs/master/.tmux.conf

source ~/.zshrc
tmux source-file ~/.tmux.conf
