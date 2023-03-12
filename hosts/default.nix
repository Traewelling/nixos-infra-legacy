inputs:
let
  sharedModules = [
    ../modules/minimal.nix
    { _module.args = { inherit inputs; }; }
    inputs.agenix.nixosModules.default
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
