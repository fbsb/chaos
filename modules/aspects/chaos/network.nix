{
  chaos.network = {
    nixos = {
      networking = {
        networkmanager.enable = true;
        firewall = {
          enable = true;
          allowPing = true;
        };
      };

      services.resolved.enable = true;
    };
  };
}
