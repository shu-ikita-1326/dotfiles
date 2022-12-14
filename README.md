# dotfiles
## Overview
My dotfiles

## Supported OS
- Ubuntu

## Install
1. Download<br>
      ```
      cd ~
      git clone https://github.com/tohoho-2614/dotfiles.git
      cd dotfiles
      ```
2. Install
      ```
      ./install.sh
      ./install_tools.sh
      ```
3. Change shell
      ```
      chsh /usr/bin/zsh
      ```
4. Change font<br>
  Please change the font to NerdFonts.<br>
  I use [HackGen](https://github.com/yuru7/HackGen) which is like to NerdFonts.<br>
5. Setup zsh
      ```
      exec zsh
      ```
      Please complete setting [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
6. neovim plugin install
      ```
      nvim +PackerSync +qall
      ```
