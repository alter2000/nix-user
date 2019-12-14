{ stdenv, fetchFromGitHub
, SDL2, libpng, libjpeg, glew, openal, scons, libmad
}:

stdenv.mkDerivation rec {
  pname = "endless-sky";
  version = "0.9.10";

  src = fetchFromGitHub {
    owner = "endless-sky";
    repo = "endless-sky";
    rev = "v${version}";
    sha256 = "1wax9qhxakydg6bs92d1jy2fki1n9r0wkps1np02y0pvm1fl189i";
  };

  enableParallelBuilding = true;

  buildInputs = [
    SDL2 libpng libjpeg glew openal scons libmad
  ];

  prefixKey = "PREFIX=";

  patches = [
    ./fixes.patch
  ];

  meta = with stdenv.lib; {
    description = "A sandbox-style space exploration game similar to Elite, Escape Velocity, or Star Control";
    homepage = https://endless-sky.github.io/;
    license = with licenses; [
      gpl3Plus cc-by-sa-30 cc-by-sa-40 publicDomain
    ];
    maintainers = with maintainers; [ lheckemann ];
    platforms = platforms.linux; # Maybe other non-darwin Unix
  };
}