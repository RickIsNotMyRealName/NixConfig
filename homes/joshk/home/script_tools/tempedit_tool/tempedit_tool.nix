{ pkgs, lib, ... }:
{
  home.packages = [
    (pkgs.stdenv.mkDerivation {
      name = "TempEdit_Pkg";
      src = ./script;
      buildInputs = [ pkgs.makeWrapper ];
      installPhase = ''
        mkdir -p $out/bin
        cp -r * $out/bin
        chmod +x $out/bin/tempedit.sh
        wrapProgram $out/bin/tempedit.sh --prefix PATH : $out/bin
      '';
    })
  ];
}
