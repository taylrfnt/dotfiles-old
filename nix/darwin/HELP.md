# Upgrade packages
You can upgrade packages via
```
nix flake upgrade
```
and then rebuilding:
```
darwin-rebuild -- switch --flake ~/path/to/flake/dir#flake_name
```

