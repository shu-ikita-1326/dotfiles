{
  pkgs,
  nixpkgs-stable ? import <nixpkgs> {
    system = "x86_64-linux";
    overlays = [];
    config = {
      allowUnfree = true;
    };
  },
  ...
}:

[
  pkgs.lazygit
  pkgs.lazydocker
  pkgs.zsh
  pkgs.ripgrep
  pkgs.fzf
  pkgs.fd
  pkgs.tmux
  pkgs.ghq
  pkgs.gh
  pkgs.bottom
  pkgs.onefetch
  pkgs.dust
  pkgs.go-task
  pkgs.mise
  pkgs.deno
  pkgs.gcc
  pkgs.cargo
  # rustup
  pkgs.python3
  pkgs.go
  pkgs.unzip
  pkgs.sheldon
  nixpkgs-stable.obsidian
]
