{
  chaos.berlin =
    let
      deLocale = "de_DE.UTF-8";
      usLocale = "en_US.UTF-8";
      timeZone = "Europe/Berlin";
    in
    {
      nixos = {
        i18n = {
          defaultLocale = usLocale;
          supportedLocales = [ "all" ];
          extraLocaleSettings = {
            LC_ADDRESS = deLocale;
            LC_IDENTIFICATION = deLocale;
            LC_MEASUREMENT = deLocale;
            LC_MONETARY = deLocale;
            LC_NAME = deLocale;
            LC_NUMERIC = deLocale;
            LC_PAPER = deLocale;
            LC_TELEPHONE = deLocale;
            LC_TIME = deLocale;
          };
        };

        time.timeZone = timeZone;
      };
    };
}
