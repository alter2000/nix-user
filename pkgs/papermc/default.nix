{ pkgs, fetchurl, jre }:
let
  mcVersion = "1.16.3";
  execOpts = "nogui";
  buildNum = "244";
  jar = fetchurl {
    url = "https://papermc.io/api/v1/paper/${mcVersion}/${buildNum}/download";
    sha256 = "1ky4l8y5lkzkipzs0ha7797hx9hr5lnji6vwjvq490059i7ajihq";
  };
in
pkgs.mkDerivation {
  pname = "papermc";
  version = "${mcVersion}r${buildNum}";

  preferLocalBuild = true;

  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp ${jar} $out/papermc.jar
    cat > $out/bin/minecraft-server << EOF
    #!/bin/sh
    exec ${jre}/bin/java \$@ -jar $out/papermc.jar ${execOpts}
    EOF
    chmod +x $out/bin/minecraft-server
  '';

  phases = "installPhase";

  meta = {
    description = "High-performance Minecraft Server";
    homepage    = "https://papermc.io/";
    license     = pkgs.lib.licenses.gpl3;
    platforms   = pkgs.lib.platforms.unix;
    maintainers = with pkgs.lib.maintainers; [ aaronjanse ];
  };
}
