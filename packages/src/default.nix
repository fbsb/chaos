{
  lib,
  stdenv,
  makeWrapper,
  bash,
  git,
  fzf,
  fd,
  coreutils,
}:

stdenv.mkDerivation {
  pname = "src";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ bash ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp src.sh $out/bin/src
    chmod +x $out/bin/src

    wrapProgram $out/bin/src \
      --prefix PATH : ${
        lib.makeBinPath [
          git
          fzf
          fd
          coreutils
        ]
      }

    runHook postInstall
  '';

  meta = with lib; {
    description = "A tool for managing source code repositories";
    longDescription = ''
      A tool that helps manage source code repositories with commands for:
      - Cloning repositories (get)
      - Navigating to project directories (go)
      - Searching for projects (find)
      - Reindexing projects (reindex)
    '';
    license = licenses.mit; # Adjust license as appropriate
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
