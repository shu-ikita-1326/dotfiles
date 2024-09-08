{ config, pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages =  import /home/nixos/dotfiles/home-manager/pkgs.nix { inherit pkgs; };

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -la";
      n = "nvim";
      lg = "lazygit";
      dot = "cd ~/dotfiles";
    };

    history = {
      size = 10000;
    };

    initExtraFirst = "
    source ~/dotfiles/home-manager/zsh/.p10k.zsh
    ";

    initExtra = "
    bindkey '^Y' autosuggest-accept
    bindkey '^ ' autosuggest-execute
    bindkey '^R' history-incremental-search-backward
    bindkey '^S' history-incremental-search-forward
    bindkey '^P' history-beginning-search-backward
    bindkey '^N' history-beginning-search-forward
    if (type \"sheldon\" > /dev/null 2>&1); then
      eval \"$(sheldon source)\"
    fi
    ";
  };
  programs.neovim = {
    enable = true;
  };
}
