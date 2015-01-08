#!/bin/bash

PKG_MNGR=yum
PKG_CHECK="${PKG_MNGR} list installed"
DIR=$HOME/.cmd-tools
MY_ZSH_THEME='powerline'

# Ensure you're home
cd $HOME

# ZSH
sudo $PKG_CHECK zsh >/dev/null
if [[ $? -eq 1 ]]; then
  echo "Installing ZSH"
  sudo $PKG_MNGR install zsh -y
  sudo chsh -s /bin/zsh $USER
fi

# Oh-My-Zsh & Powerline theme
if [[ -d $ZSH ]]; then
  echo "Installing Oh-My-Zsh"
  wget --no-check-certificate http://install.ohmyz.sh -O - | sh
fi

if [[ ! -e $ZSH/themes/$MY_ZSH_THEME.zsh-theme ]]; then
  echo "Installing ${MY_ZSH_THEME} theme"
  git clone https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme && ./oh-my-zsh-powerline-theme/install_in_omz.sh 
  sed -i.bak 's/ZSH_THEME="robbyrussell"/ZSH_THEME="${MY_ZSH_THEME}"/g' $HOME/.zshrc
  echo export TERM="xterm-256color" >> $HOME/.zshrc
fi

# SCM Breeze
if [[ -e $HOME/.scm_breeze ]]; then
  echo "Installing SCM Breeze"
  git clone https://github.com/ndbroadbent/scm_breeze.git $HOME/.scm_breeze
  $HOME/.scm_breeze/install.sh && source $HOME/.zshrc
fi

# Vim
sudo $PKG_CHECK vim-x11 >/dev/null
if [[ $? -eq 1 ]]; then
  echo "Installing Vim"
  sudo $PKG_MNGR install vim-X11 vim-common vim-enhanced vim-minimal -y
fi

VIMRC_FILE=$HOME/.vimrc

if [[ -e $HOME/.vimrc ]]; then
  VIMRC_BACKUP="${VIMRC_FILE}-original"
  echo "backing up .vimrc to ${VIMRC_BACKUP}"
  cp $VIMRC_FILE $VIMRC_BACKUP
fi
cp $DIR/.vimrc $HOME 

# Extras
echo "Installing extras"

# Locate
sudo $PKG_CHECK mlocate >/dev/null
if [[ $? -eq 1 ]]; then
  echo "Installing Locate" 
  sudo $PKG_MNGR install mlocate -y
  sudo updatedb
fi

# Man
sudo $PKG_CHECK man >/dev/null
if [[ $? -eq 1 ]]; then
  echo "Installing Man"
  sudo $PKG_MNGR install man -y
fi

exit 0
;;
