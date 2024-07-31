# This file imports all my various small tools.

{ ... }:
{
  imports = [
    ./gpt4v_tool/gpt4v_tool.nix
    ./tempedit_tool/tempedit_tool.nix
  ];
}
