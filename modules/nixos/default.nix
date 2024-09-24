{
  # sunshine = import ./services/sunshine.nix; # FIXME: use this

  actual-server = import ./services/actual-server/default.nix;
}
