# Install and Setup NixOS

1. Install git. use nix-shell.

   ```sh
   nix-shell git
   ```

2. Download dotfiles.

   ```sh
   cd ~
   git clone https://github.com/shutils/dotfiles.git
   ```

3. Setup nix configuration.

   ```sh
   cd ~/dotfiles
   sudo nixos-rebuild switch --flake .#shutils --impure # 'impure' is for wsl.
   ```

4. Install home-manager.
   see: [home-manager](https://nix-community.github.io/home-manager/)

   ```sh
   nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
   nix-channel --update
   # Restart shell
   nix-shell '<home-manager>' -A install
   ```

5. Run home-manager

   ```sh
   cd ~/dotfiles
   home-manager switch --file $HOME/dotfiles/home-manager/home.nix
   ```
