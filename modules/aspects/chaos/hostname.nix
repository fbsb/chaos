{
  chaos.hostname =
    {
      host,
      ...
    }:
    {
      ${host.class}.networking.hostName = host.hostName;
    };
}
