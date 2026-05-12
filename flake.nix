{
  description = "dockerfiles flake";

  inputs = {
    nixos-configs.url = "git+https://tangled.org/heywoodlh.io/nixos-configs";
  };

  outputs =
    inputs@{
      nixos-configs,
      ...
    }:
    let
      nixpkgs = inputs.nixos-configs.inputs.nixpkgs;
      forAllSystems = with nixpkgs; (lib.genAttrs lib.systems.flakeExposed);
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          tangled-sync = nixos-configs.packages.${system}.tangled-sync;
        in
        {
          default = pkgs.mkShell {
            name = "default";
            buildInputs = with pkgs; [
              dockerfile-language-server
            ];
            shellHook = ''
              ${tangled-sync}/bin/tangled-sync.sh
            '';
          };
        }
      );

      inherit formatter;
    };
}
