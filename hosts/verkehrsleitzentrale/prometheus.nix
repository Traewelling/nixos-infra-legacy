{ pkgs
, config
, ...
}: {
  services.prometheus = {
    enable = true;
    enableReload = true;

    globalConfig.scrape_interval = "15s";
    scrapeConfigs = [
      {
        job_name = "prometheus";
        static_configs = [
          {
            targets = [
              "localhost:${toString config.services.prometheus.port}"
            ];
          }
        ];
      }
      {
        job_name = "node";
        static_configs = [
          {
            targets = [
              "localhost:${toString config.services.prometheus.exporters.node.port}"
              "10.100.0.2:${toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "instance";
            regex = "10.100.0.2:9100";
            replacement = "maglev";
          }
          {
            source_labels = [ "__address__" ];
            target_label = "instance";
            regex = "localhost:9100";
            replacement = "verkehrsleitzentrale";
          }
        ];
      }
    ];
  };
}
