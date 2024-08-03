{ fetchFromGitHub
, stdenv
, lib
, python311Packages
}:

let
  mkComfyUICustomNodes = args: stdenv.mkDerivation ({
    installPhase = ''
      runHook preInstall
      mkdir -p $out/
      cp -r $src/* $out/
      runHook postInstall
    '';

    passthru.dependencies = args.dependencies or [ ];
  } // args);
in
{
  # https://github.com/ssitu/ComfyUI_UltimateSDUpscale
  ultimate-sd-upscale = mkComfyUICustomNodes {
    pname = "ultimate-sd-upscale";
    version = "unstable-2023-08-16";

    src = fetchFromGitHub {
      owner = "ssitu";
      repo = "ComfyUI_UltimateSDUpscale";
      rev = "6ea48202a76ccf5904ddfa85f826efa80dd50520";
      hash = "sha256-fUZ0AO+LARa+x30Iu+8jvEDun4T3f9G0DOlB2XNxY9Q=";
      fetchSubmodules = true;
    };
  };

  # https://github.com/RickIsNotMyRealName/ComfyUI-Florence2
  florence2 = mkComfyUICustomNodes {
    pname = "florence2";
    version = "unstable-2024-06-22";

    src = fetchFromGitHub {
      owner = "RickIsNotMyRealName";
      repo = "ComfyUI-Florence2";
      rev = "b8d7f9db6b46b7ff60dd763405b21d1a75491fbe";
      hash = "sha256-gQOA2Bzyf+2vD/DZGz4udcSrrV1BQqdzddiJrCVjG84=";
      fetchSubmodules = true;
    };
    dependencies = with python311Packages; [ transformers matplotlib timm ];

    shellHook = ''
      export FLORENCE2_MODELS_DIR=$TMPDIR/florence2_models
    '';
  };
}
