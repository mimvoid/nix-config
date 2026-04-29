{ lib }:

{
  /**
    Prefixes a key in an attribute set.

    # Examples

    prependAttrs "dir/" { bar = "example"; }
    => { "dir/bar" = "example"; }
  */
  prependAttrs =
    prefix:
    lib.attrsets.mapAttrs' (
      name: value: {
        name = prefix + name;
        inherit value;
      }
    );
}
