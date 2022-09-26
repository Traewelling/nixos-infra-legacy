inputs: {
  nodes = with inputs.deploy-rs.lib.x86_64-linux; {
    verkehrsleitzentrale = {
      hostname = "verkehrsleitzentrale.traewelling.de";
      profiles.system = {
        user = "root";
        path = activate.nixos inputs.self.nixosConfigurations.verkehrsleitzentrale;
      };
    };
  };

  sshUser = "root";
}
