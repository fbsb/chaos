{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.${namespace}.crypto.gpg;
in
{
  options.${namespace}.crypto.gpg = {
    enable = mkEnableOption "Enable gpg";

    pinentryPackage = mkOption {
      type = types.package;
      default = pkgs.pinentry-gnome3;
      description = "The pinentry package to use for passphrase entry";
      example = "pkgs.pinentry-qt";
    };
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;

      mutableKeys = false;
      mutableTrust = false;

      # TODO: make public keys configurable

      settings = {
        personal-cipher-preferences = "AES256 AES192 AES";
        personal-digest-preferences = "SHA512 SHA384 SHA256";
        personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
        default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
        cert-digest-algo = "SHA512";
        s2k-digest-algo = "SHA512";
        s2k-cipher-algo = "AES256";

        charset = "utf-8";
        keyid-format = "0xlong";
        list-options = "show-uid-validity";
        verify-options = "show-uid-validity";

        fixed-list-mode = true;
        ignore-time-conflict = true;
        no-comments = true;
        no-emit-version = true;
        no-greeting = true;
        no-symkey-cache = true;
        require-cross-certification = true;
        use-agent = true;
      };
    };

    services.gpg-agent = {
      enable = true;

      pinentryPackage = cfg.pinentryPackage;

      enableScDaemon = true;

      maxCacheTtl = 3600;
      maxCacheTtlSsh = 3600;
      defaultCacheTtl = 600;
      defaultCacheTtlSsh = 600;
    };
  };
}
