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
    ".config/nvim".source = /home/nixos/dotfiles/.config/nvim;
    ".config/dict".source = /home/nixos/dotfiles/.config/dict;
    ".config/zsh".source = /home/nixos/dotfiles/.config/zsh;
    ".config/sheldon".source = /home/nixos/dotfiles/.config/sheldon;
    ".config/home-manager".source = /home/nixos/dotfiles/home-manager;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
  programs.neovim = {
    enable = true;
  };
}
