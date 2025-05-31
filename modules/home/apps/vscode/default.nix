{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.${namespace}.apps.vscode;
in
{
  options.${namespace}.apps.vscode = {
    enable = mkEnableOption "Visual Studio Code";

    extensions = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        vscode-extensions.github.copilot
        vscode-extensions.github.copilot-chat
        # TODO: enable this when we have podman configured
        # vscode-extensions.ms-vscode-remote.remote-containers
        vscode-extensions.eamodio.gitlens
      ];
      description = "List of VSCode extensions to install";
    };
  };

  config = mkIf cfg.enable {
    # TODO: switch vscode to flatpak
    # services.flatpak = {
    #   packages = [
    #     "com.visualstudio.code"
    #   ];
    # };

    programs.vscode = {
      enable = true;
      profiles.default = {
        extensions = cfg.extensions;
      };
    };
  };
}
