let
  xanderio = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDvsq3ecdR4xigCpOQVfmWZYY74KnNJIJ5Fo0FsZMGW";

  # servers 
  verkehrsleitzentrale = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID50oq3Q8VPh8Z1DqiVYdOuB9Wcx5URwZuU2zT1cxjoO";
in
{
  "grafana-admin.age".publicKeys = [ verkehrsleitzentrale xanderio ];

  "verkehrsleitzentrale-priv.age".publicKeys = [ verkehrsleitzentrale xanderio ];
}
