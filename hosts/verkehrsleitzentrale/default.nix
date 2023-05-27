{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./loki.nix
    ./grafana.nix
    ./prometheus.nix
  ];

  boot.loader.grub.device = "/dev/sda";

  networking = {
    hostName = "verkehrsleitzentrale";
    useDHCP = false;
    enableIPv6 = true;

    interfaces.enp1s0 = {
      useDHCP = true;
      ipv6.addresses = [
        {
          address = "2a01:4f8:1c1c:313::1";
          prefixLength = 64;
        }
      ];
    };
    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp1s0";
    };
    nameservers = [ "2a01:4ff:ff00::add:1" "2a01:4ff:ff00::add:2" "185.12.64.1" "185.12.64.2" ];

    firewall = {
      allowedUDPPorts = [ 51820 ];
    };
    wireguard.interfaces.wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets."verkehrsleitzentrale-priv".path;

      peers = [
        {
          # Maglev (prod)
          publicKey = "QsndGEtRK4LYYurSxgZF1zeGmAeFAV0eynM2cKnw8mw=";
          allowedIPs = [ "10.100.0.2/32" ];
          endpoint = "traewelling.de:51820";
        }
      ];
    };

    hosts = {
      "10.100.0.1" = [ "verkehrsleitzentrale.local" ];
      "10.100.0.2" = [ "maglev.local" ];
    };
  };
  age.secrets."verkehrsleitzentrale-priv".file = ../../secrets/verkehrsleitzentrale-priv.age;
}
