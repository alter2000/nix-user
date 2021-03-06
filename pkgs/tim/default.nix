{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "ti";
  version = "0.5.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = super.lib.fakeSha;
  };

  doCheck = false;

  meta = {
    homepage = https://github.com/MatthiasKauer/tim;
    description = "A simple time tracker with powerful aggregation via hledger";
    license = lib.licenses.mit;
  };
}
