{ config, ... }: {
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
              "verkehrsleitzentrale.local:${toString config.services.prometheus.port}"
            ];
          }
        ];
      }
      {
        job_name = "loki";
        static_configs = [
          {
            targets = [
              "verkehrsleitzentrale.local:3030"
            ];
          }
        ];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "instance";
            regex = "(.*):3030";
            replacement = "$1";
          }
        ];
      }
      {
        job_name = "promtail";
        static_configs = [
          {
            targets = [
              "maglev.local:9080"
            ];
          }
        ];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "instance";
            regex = "(.*):9080";
            replacement = "$1";
          }
        ];
      }
      {
        job_name = "mysql";
        static_configs = [
          {
            targets = [
              "maglev.local:9104"
            ];
          }
        ];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "instance";
            regex = "(.*):9104";
            replacement = "$1";
          }
        ];
      }
      {
        job_name = "node";
        static_configs = [
          {
            targets = [
              "verkehrsleitzentrale.local:${toString config.services.prometheus.exporters.node.port}"
              "maglev.local:${toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
        relabel_configs = [
          {
            source_labels = [ "__address__" ];
            target_label = "instance";
            regex = "(.*):9100";
            replacement = "$1";
          }
        ];
      }
    ];
  };
}
