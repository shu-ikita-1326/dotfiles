# dotfiles
## Overview
My dotfiles

## Supported OS
- Ubuntu

## Install
1. Download<br>
      ```
      cd ~
      git clone https://github.com/shutils/dotfiles.git
      cd dotfiles
      ```
2. Install Homebrew
      Check the Homebrew homepage for details
      ```
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo 'export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH' >> .bashrc
      exec bash
      ```
3. Install zsh
      ```
      sudo apt update
      sudo apt install zsh
      ```
4. Change shell
      Note: If you make a mistake, the shell may not start.
      ```
      chsh -s /usr/bin/zsh
      zsh
      ```
3. Install other
      ```
      ./install.sh
      ./install_tools.sh
      ```
5. Change font<br>
  Please change the font to NerdFonts.<br>
  I use [Cica](https://github.com/miiton/Cica) which is like to NerdFonts.<br>
6. Setup zsh
      ```
      exec zsh
      ```
      Please complete setting [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
7. neovim plugin install
      ```
      nvim +PackerSync +qall
      ```
