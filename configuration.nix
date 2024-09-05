{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  users.users.nixos = {
    shell = pkgs.zsh;
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

  virtualisation.docker.enable = true;

  programs = {
    git = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };
}
