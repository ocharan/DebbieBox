#!/usr/bin/env bash

###
# Update system packages and install basic utilities
update_box() {
  echo "Updating box software"
  sudo apt update && sudo apt upgrade -y > /dev/null 2>&1
  sudo apt install -y tree git curl wget > /dev/null 2>&1
}

###
# Install Zsh and set it as the default shell
install_zsh() {
  echo "Installing Zsh"
  sudo apt install -y zsh > /dev/null 2>&1

  # Change shell to Zsh for the vagrant user
  sudo chsh -s /bin/zsh vagrant
}

##
# Install Oh-My-Zsh! framework for Zsh configuration
install_ohmyzsh() {
  echo "Installing Oh-My-Zsh!"
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

  # Change the Oh-My-Zsh! default configuration.
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="fishy"/g' ~/.zshrc
  sed -i 's/# CASE_SENSITIVE="true"/CASE_SENSITIVE="true"/g' ~/.zshrc
  sed -i 's/# COMPLETION_WAITING_DOTS="true"/COMPLETION_WAITING_DOTS="true"/g' ~/.zshrc
  sed -i 's/# DISABLE_UNTRACKED_FILES_DIRTY="true"/DISABLE_UNTRACKED_FILES_DIRTY="true"/g' ~/.zshrc
  sed -i 's/plugins=(git)/plugins=(git dirhistory common-aliases command-not-found python pip ruby rvm)/g' ~/.zshrc

  # Include .profile settings
  echo -e "\n# Include .profile settings"  >> ~/.zshrc
  echo -e "source ~/.profile\n"  >> ~/.zshrc
}

setup() {
  update_box
  install_zsh
  install_ohmyzsh
}

setup "$@"