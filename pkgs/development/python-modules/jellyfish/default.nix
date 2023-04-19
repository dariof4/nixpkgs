{ lib
, buildPythonPackage
, fetchPypi
, isPy3k
, pytest
, unicodecsv
, rustPlatform
}:

buildPythonPackage rec {
  pname = "jellyfish";
  version = "0.11.2";

  format = "pyproject";
  disabled = !isPy3k;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-ZU8rFUO5knxEKb1dZvmNH0fm65pOViEuGQf7TuoljFo=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-eRjmQoNDqJMWeZPiMGRaZ9LoP3DibSk7NLZKUV1evlk=";
  };

  nativeBuildInputs = [ rustPlatform.cargoSetupHook rustPlatform.maturinBuildHook ];

  nativeCheckInputs = [ pytest unicodecsv ];

  meta = {
    homepage = "https://github.com/sunlightlabs/jellyfish";
    description = "Approximate and phonetic matching of strings";
    maintainers = with lib.maintainers; [ koral ];
  };
}
