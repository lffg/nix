{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/release-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
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

    mkNixosConfiguration = vars: let
      inherit (vars) system;
      inherit (importPkgsSets system) pkgs pkgs-unstable;
    in
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs pkgs-unstable vars;
        };

        modules = [
          (./hosts + "/${vars.host.name}" + /configuration.nix)

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

    mkDarwinHomeManagerConfiguration = vars: let
      inherit (importPkgsSets vars.system) pkgs pkgs-unstable;
    in {
      "${vars.user.name}" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs pkgs-unstable vars;
        };

        modules = [(import ./home/home.nix)];
      };
    };
  in {
    # NixOS configurations
    nixosConfigurations = {
      hebra = mkNixosConfiguration {
        system = "x86_64-linux";
        host.name = "hebra";
        user = rec {
          name = "luiz";
          home = "/home/${name}";
        };
      };
    };

    # Darwin home-manager configurations
    packages = let
      user = rec {
        name = "luiz";
        home = "/Users/${name}";
      };
    in {
      aarch64-darwin.homeConfigurations = mkDarwinHomeManagerConfiguration {
        inherit user;
        system = "aarch64-darwin";
        host.name = "akkala";
      };
      x86_64-darwin.homeConfigurations = mkDarwinHomeManagerConfiguration {
        inherit user;
        system = "x86_64-darwin";
        host.name = "lanayru";
      };
    };
  };
}
