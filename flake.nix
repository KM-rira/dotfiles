{
  description = "Koji's Dotfiles Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-neovim.url = "github:nixos/nixpkgs/a1bab9e494f5f4939442a57a58d0449a109593fe";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-neovim, ... }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin"; # Apple Silicon (M1/M2等) の場合
      
      linuxPkgs = nixpkgs.legacyPackages.${linuxSystem};
      macPkgs = nixpkgs.legacyPackages.${macSystem};

      # Neovim 0.11.5 を提供する pkgs
      linuxNeovimPkgs = nixpkgs-neovim.legacyPackages.${linuxSystem};
      macNeovimPkgs = nixpkgs-neovim.legacyPackages.${macSystem};
    in {
      homeConfigurations = {
        # Linux (WSL/Ubuntu等) 向け
        "koji-linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPkgs;
          extraSpecialArgs = { 
            neovim-pkg = linuxNeovimPkgs.neovim; 
          };
          modules = [ ./nix/home.nix ];
        };

        # Mac (Apple Silicon) 向け
        "koji-mac" = home-manager.lib.homeManagerConfiguration {
          pkgs = macPkgs;
          extraSpecialArgs = { 
            neovim-pkg = macNeovimPkgs.neovim; 
          };
          modules = [ ./nix/home.nix ];
        };
      };
    };
}
