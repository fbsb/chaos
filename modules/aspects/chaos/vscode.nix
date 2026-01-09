{
  __findFile ? __findFile,
  lib,
  ...
}:
{
  chaos.vscode = {
    homeManager =
      {
        pkgs,
        ...
      }:
      {
        programs.vscode = {
          enable = true;
          profiles.default = {
            extensions = with pkgs.vscode-extensions; [
              github.copilot
              github.copilot-chat
              # TODO: enable this when we have podman configured
              # ms-vscode-remote.remote-containers
              mhutchie.git-graph
            ];
          };
        };

        nixpkgs.config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "vscode"
              "vscode-extension-github-copilot"
              "vscode-extension-mhutchie-git-graph"
            ];
        };
      };
  };
}
