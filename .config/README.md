# .config
## What This Is
This directory (and sbdirectories within it) are the various configuration files which are used to configure various packages
that can be installed on a given system.

## `nix` replacements
Several packages in this repository are able to be configured via `nix` and its various modules (e.g. Home Manager).  As a result, the files previousy used to manager these packages' conifgurations are stored in the `${package_name}.bkp` directories for systems which are not currently configured
to/cannot be managed using Nix.

