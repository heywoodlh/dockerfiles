{
  description = "An starter multiarch flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.myFlakes.url = "github:heywoodlh/flakes";

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    myFlakes,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      # Determine corresponding linuxSystem for MacOS linux-builder
      arch = pkgs.stdenv.hostPlatform.uname.processor;
      linuxSystem = "${arch}-linux";
      tmuxExec = pkgs.writeShellScript "tmux.sh" ''
        TERM="screen-256color" ${myFlakes.packages.${linuxSystem}.tmux}/bin/tmux -u
      '';

      # Image configuration
      devImage = pkgs.dockerTools.buildImageWithNixDb {
        name = "docker.io/heywoodlh/dev";
        tag = "latest";
        copyToRoot = pkgs.buildEnv {
          name = "image-root";
          pathsToLink = [ "/bin" "/var" "/etc" ];
          paths = with pkgs.dockerTools; [
            usrBinEnv
            binSh
            caCertificates
            myFlakes.packages.${linuxSystem}.vim
            myFlakes.packages.${linuxSystem}.git
            pkgs.bash
            pkgs.coreutils
            pkgs.curl
            pkgs.mosh
            pkgs.nix
            pkgs.openssh
            pkgs.shadow
            pkgs.which
          ];
        };
        runAsRoot = ''
          #!${pkgs.runtimeShell}
          ${pkgs.dockerTools.shadowSetup}
          groupadd -r heywoodlh
          useradd -m -g heywoodlh heywoodlh

          # Enable nix flakes
          mkdir -p /etc/nix
          printf 'experimental-features = nix-command flakes' > /etc/nix/nix.conf

          # Tmux fixes
          mkdir -p /tmp
          chmod 777 /tmp
        '';
        config = {
          User = "heywoodlh";
          WorkingDir = "/home/heywoodlh";
          Env = [
            "NIX_PAGER=cat"
          ];
          Entrypoint = [ "${tmuxExec}" ];
        };
      };
    in {
      packages = {
        dockerImage = devImage;
      };

      formatter = pkgs.alejandra;
    });
}
