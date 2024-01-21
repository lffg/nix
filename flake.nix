{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, ...}: let
    importPkgsSets = system: let
      importPkgs = i: (import i {
        inherit system;
        config.allowUnfree = true;
      });
    in {
      pkgs = importPkgs inputs.nixpkgs;
      pkgs-unstable = importPkgs inputs.nixpkgs-unstable;
    };

    vars = {
      user.name = "luiz";
    };
  in {
    nixosConfigurations = let
      system = "x86_64-linux";
      inherit (importPkgsSets system) pkgs pkgs-unstable;
    in {
      hebra = inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs pkgs-unstable vars;
        };

        modules = [
          ./hosts/hebra/configuration.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs pkgs-unstable vars;
              };
              users.${vars.user.name} = import ./home/home.nix;
            };
          }
        ];
      };
    };
  };
}
