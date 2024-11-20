{ lib, ... }:

{
  # prependAttrs: prefixes a key in an attribute set

  # Example:
  # foo = prependAttrs "dir/" { bar = "example"; };
  # -> foo = { "dir/bar" = "example"; };

  prependAttrs = prefix:
    lib.attrsets.mapAttrs' (name: value:
      lib.nameValuePair "${prefix}${name}" value);
}
