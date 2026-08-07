{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "siddrs";
    repo = "tokyo-night-sddm";
    rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
    sha256 = "1gf074ypgc4r8pgljd8lydy0l5fajrl2pi2avn5ivacz4z7ma595";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
