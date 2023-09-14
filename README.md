# dotfiles

## Overview

My dotfiles

## Supported OS

- Ubuntu

## Install

1. Download  

      ```sh
      cd ~
      git clone https://github.com/shutils/dotfiles.git
      cd dotfiles
      ```

2. Install zsh  

      ```sh
      sudo apt update
      sudo apt install zsh
      ```

3. Change shell  
      Note: If you make a mistake, the shell may not start.

      ```sh
      chsh -s /usr/bin/zsh
      zsh
      ```

4. Install Homebrew  

      Check the Homebrew homepage for details

      ```sh
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      exec zsh
      ```

5. Install other  

      Note: install_tools.sh only installs tools that are not already installed.
            Depending on the distribution, older versions of git, tmux, etc.
            may be installed, so we recommend installing the latest version.

      ```sh
      ./install.sh
      ./install_tools.sh
      ```

6. Change font  

   Please change the font to NerdFonts.  
   I use [Cica](https://github.com/miiton/Cica) which is like to NerdFonts.  

7. Setup zsh  

      ```sh
      exec zsh
      ```

      Please complete setting [Powerlevel10k](https://github.com/romkatv/powerlevel10k)

8. Setup node  

   Install [node](https://github.com/nodejs/node) by any method.
   I am using [nvm](https://github.com/nvm-sh/nvm).

9. Setup ghq root  

   Set ghq root in your .gitconfig as below

   ```config
   [ghq]
       root=~/go/src
   ```

10. neovim plugin install  

      ```sh
      nvim
      ```

## Trial

You can try out my neovim environment using docker.  
Please check the README in the trial directory for details.
