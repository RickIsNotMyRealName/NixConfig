{ pkgs, lib, ... }:
{
  home.packages = [
    (pkgs.stdenv.mkDerivation {
      name = "GPT4VToolPkg";
      src = ./script;
      buildInputs = [ pkgs.makeWrapper ];
      installPhase = ''
        mkdir -p $out/bin
        cp -r * $out/bin
        chmod +x $out/bin/GPT4VTool.sh
        wrapProgram $out/bin/GPT4VTool.sh --prefix PATH : $out/bin
      '';
    })
  ];
}
