{ lib, fetchurl, appimageTools, ... }:
let
  pname = "lm-studio";
  version = "0.2.24";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://releases.lmstudio.ai/linux/${version}/beta/LM_Studio-${version}.AppImage";
    sha256 = "sha256-1ahPRRgcYfW9eD04yeF4ft+yLn9+nIPOV5Vkv7rMiT8=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  name = name;
  # pname = pname;
  version = version;
  src = src;


  extraInstallCommands = ''
            mkdir -p $out/share/applications
            mv $out/bin/${name} $out/bin/${pname}
            install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop
            install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/256x256/apps/${pname}.png
            substituteInPlace $out/share/applications/${pname}.desktop \
    	        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
  '';
  meta = {

    description = "Discover, download, and run local LLMs";
    homepage = "https://lmstudio.ai/";
    license = lib.licenses.unfree;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
