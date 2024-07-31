#
{ config, lib, pkgs, ... }:
let
  # Use `mkLiteral` for string-like values that should show without
  # quotes, e.g.:
  # {
  #   foo = "abc"; =&gt; foo: "abc";
  #   bar = mkLiteral "abc"; =&gt; bar: abc;
  # };
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  # Empty for now


}
