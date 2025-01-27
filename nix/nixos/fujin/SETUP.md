# Reproducing fujin on your own host
This configuration is designed to be reproducible, so here are the steps to follow if you wish
to emulate this conifguration/machine in another host.

## Prerequisites
This guide assumes a few prereuqisites are met:
1. You have UTM or some other virtualization tool installed.
2. You have a [NixOS minimal iso image](https://nixos.org/download/) downloaded and ready for use.
    - This guide uses the `x86_64` iso image for NixOS 24.11, but there may be a newer version
    available if you are reading this later.

## Build your VM
Open UTM and select a new VM
Choose Virtualize or Emulate (if you are in an `x86_64` arch)
Choose "Other" in the OS, CD/DVD image, then add the iso file
Configure hardware (CPU, Memory, Disk)
Add shred directory, if desired
Review summary & name VM, then save.
Open VM settings, remove sound card, save.
Run VM

## Booting from NixOS "USB"
This is a virtual USB image, so you aren't really inserting a USB or anything like that.  Launching
the VM should be enough to get you to the NixOS installation screen, and your can just boot the
installer, or let it do it for you after the 10sec timer.

You'll see lots of console output whiz by as the installer does its thing, and then eventually
a welcome screen.

## Preparing for `nixos-anywhere`
We will use [`nixos-anywhere`](https://github.com/nix-community/nixos-anywhere) to configure our
new NixOS VM.  This module uses SSH to run various configurations & installs.
Remeber that right now, the VM is still running off of the USB image, which is totally fine.

### Setting a password for SSH
We will need to set a password for the user to enable SSH, so go ahead and do that with this command:
```
passwd
```
You can set the password to something simple like "foo", since this image is not going to be used
again after this process :)

### Get IP of our VM
We also need to get the IP of our VM.  You can do that with the following command:
```
ip addr
```

Typically your VM's IP will be something like `192.168.XXX.XXX`, but it may be different based on
your ISP.  I find my VM's IP under the `enp0s1` device in the output of the command above, but your
VM's devices may be different in different images/VM configurations.

Once you have the VM's IP, export it to a variable in your host machine's session:
```
export NIXADDR={your VM's IP}
```

## Final Configuration Changes
At this point, everything we need to run `nixos-anywhere` is configured, which is really just
verifying that SSH is available on our VM.  `nixos-anywhere` will essentially run all of the steps
that most people manually perform (or maybe use a Makefile, like Mitchell does!) to get a new NixOS
system operational:
- Disk configuration
- Disk formatting
- Configure & intall NixOS on the newly formatted disk
- Install additional files/software (via flake rebuild/switch)

However, you should **NOT** just blindly use my configuration.  It will probably work for most people
without many issues, but there's going to be some immediate problems if you don't make changes to
accomodate your setup (e.g. my user being created on your VM, with no login of your own).

### Verify disko configuration
If you followed my configuration, you should have a 150GB SCSI disk attached to your NixOS VM.
You can use the following command to confirm the disk name/size:
```
lsblk
```

In my case, I have a 150G disk (my SCSI disk):
```
$ lsblk
NAME    MAJ:MIN  RM   SIZE  RO  TYPE  MOUNTPOINTS
sda       8:0     0   150G   0  disk
```

If you do not see your desired disk displayed as `sda`, you will need to modify
the `disko-configuration.nix` file to use your disk name:
- Take the name of the disk you see in the output of `lsblk` and replace `sda` in the file with
whatever the disk name is in your VM:
```
  disko.devices = {
     [...]
        device = "/dev/**sda**";
```
### Modify the user configuration
The `configuration.nix` file in this directory contains configurations specifically for my user
on my `fujin` VM.  **You will (probably?) not want to have my user, password, and SSH key set up on
your VM.**
```
  users.users.taylor = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    # Created using mkpasswd
    hashedPassword = "$6$EcgX/2U/ER4pXYJT$2TqLnUlDH2su53HEM7vOqShajVzrEcJe4Fc52OrAPd6eMRPGERitY6AD5xd.RJkuP6eOR9fKA5q6tsxidlZLE/";
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoMCwWgzQHTKEms1wqK4j3Ztbs7dEw44XyqYFAxXm/cMCdZoyhTlutr44PKylfSCugTe3y1aKdTkOGyJTgRlbloGI5api5QWI80E8dDozP1E4HJPptDQzisl/Lv6aqPdEduxwjDS/SYFFGAzGgnJaj06EBp/3RYv5iMda98SRi/SgzQJ2MdYcDLpB3iWwm/J3mVVkvtU9Uw5K97TTN4LkcbMgscZlOBXmB/yrjIbN4QEFh3TZH9woxEmaA0KRf4V9hd7+TLdcpCiG1v6uP6+a5wH/tJaPJrLZkp7TSRDTWnlHzROU3Z3Ux57q5wLwtgzcnS1vMEt00p6+lp7N9tFhgssuh8GbuiP427xR4SDTiL8lB8PTT48ELuSiDvRjE9VWN94GFcDZVwPUq6hsxBwrCGnwYEjlQR3LZ5MOcs/fWpiAD0/28uZJuA7s4eCM14gBf0PS9qY6+KWarlFRUcSysIWi6bw7hT2ysoJpl31pG8ua2lw1x6wiHs9E2Zh/rNcU= amaterasu access key"
    ];
  };
```

Make sure to change the following values to your configurations with `configuration.nix`:
- username value (`users.users.{your user here}`)
- hashed password (`users.users.{your user here}.hashedPassword`)
- authorized key(s) (`users.users.{your user here}.openssh.authorizedKeys.keys`)

If you need to make a new password hash, you can do so with the following:
```
mkpasswd -m sha-512
```

### Modify the flake name
If you like my hostname setup (Japanese deities), then you can skip this step.  However, I know
that a lot of people like to use their own conventions (`shrek`, `donkey`, `mario`, etc.).

The `flake.nix` in this directory defines the hostname and the name for the flake as `fujin`.
```
  outputs = { self, nixpkgs, disko, ... }@inputs: let
    nodes = [
      "fujin"
    ];
```
If you want to use a custom hostname and flake name, you need to change this value to whatever
value you want.

### Use `nixos-anywhere`
With our configuration verified and SSH open on the VM, we can run `nixos-anywhere` to get our VM
fully configured.

The command you use will differ slightly based on your host machine.  If you, like me, are running
on an `aarch64-darwin` host, but your VM is an emulated `x86_64` system, then you should use the
following command:
```
sudo nix run github:nix-community/nixos-anywhere \
--extra-experimental-features "nix-command flakes" \
-- --flake '/path/to/nix/config#{flake name here}' --build-on-remote nixos@${NIXADDR}
```
- The `--build-on-remote` flag allows the nix flake build to be done on the VM, rather than the host
OS.

If you are on an `x86_64` host, you can use the same command above, just without the extra flag, that
way you can take advantage of your host's additional compute resources so the build is a little quicker:
```
sudo nix run github:nix-community/nixos-anywhere \
--extra-experimental-features "nix-command flakes" \
-- --flake '/path/to/nix/config#{flake name here}' nixos@${NIXADDR}
```

## Post `nixos-anywhere` checkout
After the `nixos-anywhere` process completes (it will take a littl while), your VM will reboot.
Ideally, the USB image you had booted from previously will be skipped and you should boot directly
into NixOS on the VM disk; however, I can never get this to work.  If you are sent to the Installer
screen on reboot, navigate to "Firmware Setup" > "Boot Manager" and select your disk for booting.

Note: You can also remove the USB image to avoid this ever needing to be done again.

You'll probably  want to send the configuration files over to your VM so you don't have to always
perform rebuilds remotely via SSH, so create a git repo and clone it over to the new machine.  The
configuration in this repo contains `git` by default for this purpose.  You can also SCP/SFTP it,
but then you lose version control and backups.  Do whatever floats your boat.

Now you should have a fully operational NixOS VM, and you can do whatever you need to with it.  Enjoy!

