{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/release-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, ...}: let
    mkPkgs = {
      nixpkgs,
      system,
    }: (import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    });
  in {
    nixosConfigurations = let
      inherit (inputs.nixpkgs.lib) nixosSystem;

      system = "x86_64-linux";

      pkgs = mkPkgs {
        inherit system;
        nixpkgs = inputs.nixpkgs;
      };
      pkgs-unstable = mkPkgs {
        inherit system;
        nixpkgs = inputs.nixpkgs-unstable;
      };
    in {
      hebra = nixosSystem {
        inherit system;

        specialArgs = {inherit inputs pkgs-unstable;};

        modules = [
          ./hosts/hebra/configuration.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs pkgs-unstable;};
              users."luiz" = import ./home/home.nix;
            };
          }
        ];
      };
    };
  };
}
