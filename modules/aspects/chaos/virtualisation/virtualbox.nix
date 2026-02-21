{
  chaos.virtualisation.provides.virtualbox =
    {
      user,
      ...
    }:
    {
      nixos = {
        virtualisation.virtualbox.host.enable = true;
        virtualisation.virtualbox.host.enableExtensionPack = true;
        users.extraGroups.vboxusers.members = [ user.userName ];
      };
    };
}
