{
  description = "Koji's Dotfiles Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      linuxSystem = "x86_64-linux";
      macSystem = "aarch64-darwin"; # Apple Silicon (M1/M2等) の場合
      
      linuxPkgs = nixpkgs.legacyPackages.${linuxSystem};
      macPkgs = nixpkgs.legacyPackages.${macSystem};
    in {
      homeConfigurations = {
        # Linux (WSL/Ubuntu等) 向け
        "koji-linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPkgs;
          modules = [ ./nix/home.nix ];
        };

        # Mac (Apple Silicon) 向け
        "koji-mac" = home-manager.lib.homeManagerConfiguration {
          pkgs = macPkgs;
          modules = [ ./nix/home.nix ];
        };
      };
    };
}
