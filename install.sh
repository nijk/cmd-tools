#!/bin/bash

PKG=yum
DIR=$HOME/.cmd-tools
MY_ZSH_THEME='powerline'

# Ensure you're home
cd $HOME

# ZSH
echo "Installing ZSH"
sudo $PKG install zsh -y
sudo chsh -s /bin/zsh $USER

# Oh-My-Zsh & Powerline theme
echo "Installing Oh-My-Zsh with ${MY_ZSH_THEME} theme"
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
git clone https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme && ./oh-my-zsh-powerline-theme/install_in_omz.sh 
sed -i.bak 's/ZSH_THEME="robbyrussell"/ZSH_THEME="${MY_ZSH_THEME}"/g' $HOME/.zshrc
echo export TERM="xterm-256color" >> $HOME/.zshrc

# SCM Breeze
echo "Installing SCM Breeze"
git clone https://github.com/ndbroadbent/scm_breeze.git $HOME/.scm_breeze
$HOME/.scm_breeze/install.sh && source $HOME/.zshrc

# Vim
echo "Installing vim"
sudo $PKG install vim-X11 vim-common vim-enhanced vim-minimal -y

VIMRC_FILE=$HOME/.vimrc

if [ -e $HOME/.vimrc ]
then
  VIMRC_BACKUP="${VIMRC_FILE}-original"
  echo "backing up .vimrc to ${VIMRC_BACKUP}"
  cp $VIMRC_FILE $VIMRC_BACKUP
fi
cp $DIR/.vimrc $HOME 

# Extras
echo "Installing extras"
# Locate
sudo $PKG install mlocate -y
sudo updatedb

# Man
sudo $pkg install man -y
exit 1
