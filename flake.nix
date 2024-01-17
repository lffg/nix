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
    nixosConfigurations.nixos = let
      system = "x86_64-linux";

      pkgs = mkPkgs {
        inherit (inputs) nixpkgs;
        inherit system;
      };
      pkgs-unstable = mkPkgs {
        inherit (inputs) nixpkgs-unstable;
        inherit system;
      };
    in
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit pkgs-unstable;};

        modules = [
          ./hosts/hebra/configuration.nix

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit pkgs-unstable;
              };
              users."luiz" = import ./home/home.nix;
            };
          }
        ];
      };
  };
}
