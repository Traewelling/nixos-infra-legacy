inputs:
let
  sharedModules = [
    ../modules/minimal.nix
    { _module.args = { inherit inputs; }; }
    inputs.agenix.nixosModule
  ];

  inherit (inputs.nixpkgs.lib) nixosSystem;
in
{
  verkehrsleitzentrale = nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./verkehrsleitzentrale
      ../modules/server
    ]
    ++ sharedModules;
  };
}
