#!/bin/sh

# This script is used to:
#   Install Pathogen if necessary
#   Install Vim solarized
#   Install Nerdtree for vim
#   Install nerdcommenter for vim
#   Install vim-fugitive
#   Install command-t
#   Install oh-my-zsh
#   Install powerlevel9k
#   Install powerlevel10k
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

# set curl proxy variables
CURL_PROXY=$(fwdproxy-config curl)

# set git proxy
git config --global http.proxy fwdproxy:8080

# install pathogen
if [ -f "$HOME/.vim/autoload/pathogen.vim" ]; then
  echo "Pathogen already installed."
else
  echo "Installing pathogen"
  mkdir -p ~/.vim/autoload ~/.vim/bundle
  eval curl $CURL_PROXY -LSso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
fi

# install vim solarized
if [ -d "$HOME/.vim/bundle/vim-colors-solarized" ]; then
  echo "Vim Solarized is already installed"
else
  echo "Installing Vim Solarized"
  git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
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

# install vim-fugitive
if [ -d "$HOME/.vim/bundle/vim-fugitive" ]; then
  echo "vim-fugitive already installed"
else
  echo "Installing vim-fugitive"
  git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
fi

# install command-t
if [ -d "$HOME/.vim/bundle/command-t" ]; then
  echo "command-t already installed"
else
  echo "Installing command-t"
  git clone https://github.com/wincent/command-t.git ~/.vim/bundle/command-t
  sudo yum install ruby ruby-devel
  cd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t
  ruby extconf.rb
  make
  cd ~
fi

# install oh-my-zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh already installed"
else
  echo "Installing oh-my-zsh"
  sh -c "$(eval curl $CURL_PROXY -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# install powerlevel9k
if [ -d "$ZSH_CUSTOM/themes/powerlevel9k" ]; then
  echo "powerlevel9k already installed"
else
  echo "Installing powerlevel9k"
  git clone https://github.com/romkatv/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k
fi

# install powerlevel10k
if [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "powerlevel10k already installed"
else
  echo "Installing powerlevel10k"
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

i# install zsh-autosuggestions
f [ -d "$ZSH_CUSTOM/themes/zsh-autosuggestions" ]; then
  echo "zsh-autosuggestions already installed"
else
  echo "Installing zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# install zsh-syntax-highlighting
if [ -d "$ZSH_CUSTOM/themes/zsh-syntax-highlighting" ]; then
  echo "zsh-syntax-highlighting already installed"
else
  echo "Installing zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# copy .vimrc from my github
eval curl $CURL_PROXY -LSso ~/.vimrc https://raw.github.com/sonicpower/configs/master/.vimrc

# copy aliases from my github
eval curl $CURL_PROXY -LSso $ZSH_CUSTOM/.zsh_aliases https://raw.github.com/sonicpower/configs/master/.zsh_aliases

# copy .zshrc from my github
eval curl $CURL_PROXY -LSso ~/.zshrc https://raw.github.com/sonicpower/configs/master/.zshrc

source ~/.zshrc
