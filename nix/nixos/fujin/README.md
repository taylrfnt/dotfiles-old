# fujin
Fujin is my NixOS virtual machine configuration that I run via [UTM](https://mac.getutm.app/), a
QEMU interface designed for MacOS.

I plan to use fujin as my dev environment within MacOS/darwin systems, and perhaps later use this
configuration as a base for other bare-metal NixOS systems.

## Specifications
Fujin has been created with the following specs:
- 5 vCPU cores
- 8 GB vRAM
- 150 GB SCSI disk

Fujin currently runs NixOS 24.11.

## Important Notes & Limitations
- Fujin uses the minimal NixOS installation no graphical environment.
- The `aarch64-linux` minimal image is finnicky, and I could never get it to work properly.  As a
result, fujin is an emulated `x84_64` NixOS VM.
  - If I manage to get the `aarch64-linux` iso image working, then I'll update this repo.  I am
  in no rush to migrate.

## Reproducing this VM configuration
This system was intially bootstrapped using [Mitchell Hashimoto's NixOS configuration](https://github.com/mitchellh/nixos-config).

I'd like to have this defined using nixos-anywhere someday soon.

