{
  chaos.system.provides.hostname =
    {
      host,
      ...
    }:
    {
      ${host.class}.networking.hostName = host.hostName;
    };
}
