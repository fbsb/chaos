{
  lib,
  ...
}:

with lib;

rec {
  /*
    Recursively apply mkDefault to all leaf values in an attribute set.

    This function traverses a nested attribute set and wraps all non-attribute-set
    values with lib.mkDefault, making them lower priority than explicitly set values.
    Useful for providing sensible defaults that can be easily overridden.

    Type: mkDefaultValues :: AttrSet -> AttrSet

    Example:
      mkDefaultValues {
        foo = true;
        bar = {
          baz = "hello";
          qux = 42;
        };
      }
      => {
        foo = mkDefault true;
        bar = {
          baz = mkDefault "hello";
          qux = mkDefault 42;
        };
      }
  */
  mkDefaultValues =
    attrs:
    mapAttrs (
      name: value:
      if isAttrs value then
        mkDefaultValues value # Recurse for nested attrsets
      else
        mkDefault value # Apply mkDefault to leaf values
    ) attrs;
}
