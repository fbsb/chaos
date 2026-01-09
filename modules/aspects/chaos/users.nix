{
  chaos.users =
    {
      user,
      ...
    }:
    {
      nixos = {
        users.mutableUsers = false;
        users.users.${user.userName} = {
          isNormalUser = true;
          description = user.description;
          initialHashedPassword = user.passwordHash;
        };
      };
    };
}
