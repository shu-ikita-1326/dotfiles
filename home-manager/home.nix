{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
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
    pkgs.dust
    pkgs.go-task
  ];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    shellAliases = {
      ll = "ls -la";
      n = "nvim";
      lg = "lazygit";
      dot = "cd ~/dotfiles";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ];}
      ];
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
    ";
  };
}
