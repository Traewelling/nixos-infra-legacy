{ config, ... }: {
  age.secrets."grafana-admin" = {
    file = ../../secrets/grafana-admin.age;
    owner = "grafana";
  };
  services = {
    grafana = {
      enable = true;
      domain = "monitoring.traewelling.de";
      rootUrl = "https://monitoring.traewelling.de";
      security.adminPasswordFile = config.age.secrets."grafana-admin".path;
    };

    nginx = {
      enable = true;
      virtualHosts.${config.services.grafana.domain} = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.grafana.port}";
          proxyWebsockets = true;
        };
      };
    };
  };
}
