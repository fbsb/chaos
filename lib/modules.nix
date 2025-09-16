{ lib, ... }:

rec {
  # Recursively find all Nix modules in a directory tree
  # If a directory contains default.nix, it returns that file
  # Otherwise, it returns all .nix files in the directory
  findIn =
    dir:
    let
      # Get all entries in the directory
      entries = builtins.readDir dir;

      # Filter entries by type
      directories = lib.filterAttrs (name: type: type == "directory") entries;
      nixFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) entries;

      # Check if default.nix exists
      hasDefault = nixFiles ? "default.nix";

      subModules = lib.flatten (lib.mapAttrsToList (name: _: findIn (dir + "/${name}")) directories);

      modules =
        if hasDefault then
          # Directory contains default.nix - return it
          [ (dir + "/default.nix") ]
        else
          # Return all .nix files in the directory
          lib.mapAttrsToList (name: _: dir + "/${name}") nixFiles;
    in
    modules ++ subModules;
}
