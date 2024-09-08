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
  programs.neovim = {
    enable = true;
  };
}
