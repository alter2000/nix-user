{ pkgs, fetchFromGitHub, cmake, ncurses }:

pkgs.mkDerivation rec {
  name = "slurm-git-${version}";
  version = "0.4.3";

  src = fetchFromGitHub {
    owner = "mattthias";
    repo = "slurm";
    rev = "0.4.3";
    # sha256 = "";
    sha256 = "0cyazh7a66pgcabijd27xnk1alhsccywivv6yihw378dqxb22i1p";
  };

  buildInputs = [ cmake ];
  propagatedBuildInputs = [ ncurses ];

  meta = with pkgs.lib; {
    homepage = "https://github.com/mattthias/slurm";
    description = "Yet another network load monitor";
    # maintainers = [ maintainers.infinisil ];
    license = licenses.gpl2;
  };
}
