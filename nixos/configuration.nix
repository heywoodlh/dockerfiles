{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/profiles/docker-container.nix"
  ];

  networking.dhcpcd.enable = false;

  system.stateVersion = "25.05";
}

