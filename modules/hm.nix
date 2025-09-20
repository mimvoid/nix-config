{ flakePath }:
{ config, lib, ... }:

{
  options.voids = {
    lib = lib.mkOption {
      description = "Utility functions";
      readOnly = true;
    };
  };

  config = {
    home.sessionVariables.NH_FLAKE = flakePath;

    voids = {
      lib = {
        inherit flakePath;

        # Simple wrapper around mkOutOfStoreSymlink to make direct symlinks.
        #
        # Due to the nature of how flakes are stored, making paths absolute with `toString`
        # or `/. +` creates a path to a copy in the Nix store, not the actual file.
        # The paths could be broken, and nothing will update until a rebuild.
        #
        # Since this is impure, only use it if the benefits of instant updates outweigh the
        # cost of purity.
        symlink = hmPathStr: {
          source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home-manager/${hmPathStr}";
        };

        # hardlink =
        #   src: dst:
        #   lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        #     $DRY_RUN_CMD ln -fn ${flakePath}/home-manager/${src} ${config.home.homeDirectory}/${dst}
        #   '';
      };
    };
  };
}
