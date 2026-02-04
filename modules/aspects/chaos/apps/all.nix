{
  __findFile ? __findFile,
  ...
}:
{
  chaos.apps.provides.all = {
    includes = [
      <chaos/apps/goxlr>
      <chaos/apps/terminals/ghostty>
      <chaos/apps/browsers/zen>
      <chaos/apps/utils/junction>
      <chaos/apps/utils/galaxy-buds-client>
      <chaos/apps/ide/vscode>
    ];
  };
}
