{ runCommand
, fetchFromGitHub
}:

let
  src = fetchFromGitHub {
    owner = "ucb-bar";
    repo = "testchipip";
    rev = "1952231569c939a9a5e47fa2eef8168405d0136d";
    sha256 = "sha256-iAXZvmIcsZffVCYum8oE95IwkkR4RNJLh5SXEFniqzU=";
  };
in

runCommand "testchipip-h" {} ''
  mkdir -p $out/include
  cp ${src}/csrc/{*.h,testchip_tsi.cc} $out/include/
''
