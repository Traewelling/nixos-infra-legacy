{ config, ... }: {
  age.secrets."grafana-admin" = {
    file = ../../secrets/grafana-admin.age;
    owner = "grafana";
  };
  services = {
    grafana = {
      enable = true;
      rootUrl = "https://monitoring.traewelling.de";
      settings = {
        server.domain = "monitoring.traewelling.de";
      };
    };

    nginx = {
      enable = true;
      virtualHosts.${config.services.grafana.settings.server.domain} = {
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
