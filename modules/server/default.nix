{ config
, pkgs
, lib
, name
, ...
}: {
  imports = [
    ./nginx.nix
    ./promtail.nix
    ./node_exporter.nix
  ];

  zramSwap.enable = true;

  networking = {
    domain = "traewelling.de";
  };
}
