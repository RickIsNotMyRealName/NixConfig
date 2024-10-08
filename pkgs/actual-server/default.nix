# actual-server.nix
{ lib, pkgs, stdenv, fetchFromGitHub, nodejs, python3, jq, moreutils, makeWrapper, yarn-berry, cacert, ... }:
let
  pname = "actual-server";
  version = "24.9.0";

  src = fetchFromGitHub {
    owner = "actualbudget";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-KfVRWnr1x26spbCPMvhqdXqdjKL4vFaWGw4dZ7mtTiw=";
  };
in
stdenv.mkDerivation {

  pname = pname;
  name = "${pname}-${version}";
  version = version;

  src = src;

  nativeBuildInputs = [
    nodejs
    python3
    jq
    moreutils
    makeWrapper
    yarn-berry
  ];

  yarnOfflineCache = pkgs.stdenvNoCC.mkDerivation {
    name = "actual-deps";
    nativeBuildInputs = with pkgs; [ yarn-berry ];
    src = src;

    NODE_EXTRA_CA_CERTS = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

    supportedArchitectures = builtins.toJSON {
      os = [ "darwin" "linux" ];
      cpu = [ "arm" "arm64" "ia32" "x64" ];
      libc = [ "glibc" "musl" ];
    };

    configurePhase = ''
      runHook preConfigure

      export HOME="$NIX_BUILD_TOP"
      export YARN_ENABLE_TELEMETRY=0

      yarn config set enableGlobalCache false
      yarn config set cacheFolder $out
      yarn config set supportedArchitectures --json "$supportedArchitectures"

      runHook postConfigure
    '';

    buildPhase = ''
      runHook preBuild

      mkdir -p $out
      yarn install --immutable --mode skip-build

      runHook postBuild
    '';

    dontInstall = true;

    outputHashAlgo = "sha256";
    outputHash = "sha256-wuwWNGZ4dq91Whq1yk0gOSPvhw0RV6jLAPpORXU5N7I=";
    outputHashMode = "recursive";
  };


  patchPhase = ''
    sed -i '1i#!${pkgs.nodejs}/bin/node' app.js
  '';

  configurePhase = ''
    runHook preConfigure

    export HOME="$NIX_BUILD_TOP"
    export YARN_ENABLE_TELEMETRY=0
    export npm_config_nodedir=${pkgs.nodejs}

    yarn config set enableGlobalCache false
    yarn config set cacheFolder $yarnOfflineCache

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    yarn install --immutable --immutable-cache
    yarn build
    yarn workspaces focus --all --production

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{bin,lib}

    mkdir $out/lib/actual
    cp -r package.json app.js src migrations node_modules $out/lib/actual/

    chmod +x $out/lib/actual/app.js

    makeWrapper $out/lib/actual/app.js $out/bin/actual --chdir $out/lib/actual

    runHook postInstall
  '';

  fixupPhase = ''
    runHook preFixup

    patchShebangs $out/lib

    runHook postFixup
  '';
}
