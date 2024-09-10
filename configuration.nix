{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.wslConf.interop.appendWindowsPath = false;

  users.users.nixos = {
    shell = pkgs.zsh;
    extraGroups = [ "docker" ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];

  environment.sessionVariables = rec {
    ZDOTDIR = "$HOME/dotfiles/.config/zsh";
    ZRCDIR = "$HOME/dotfiles/.config/zsh/rc";
  };

  virtualisation.docker = {
    enable = true;
    # daemon.settings = import /home/nixos/dotfiles/.config/docker/daemon.nix;
  };

  programs = {
    git = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };
}
