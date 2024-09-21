# My NixOS configuration

## Todo

- Waybar
  - Add highest cpu using processes on tooltip
- wpgtk
  - Look into using it for theming gtk apps with pywal
- Zsh
  - Add plugins?
  - Fix the autocompletion
- Hyprland
  - Setup a better theme
    - Setup resize mode for windows
    - Add lockscreen
      - Theme it
- home-manager
  - Migrate zsh config
  - Make an alacritty config
- Setup fonts
- Thunar
  - Make it work with pywal to change colors
- Wofi
  - Fix selected text color to be more visible
- Create a control center of sorts
  - Basic bluetooth settings
  - Media controls
  - Volume controls
  - Brightness controls
  - Basic network settings
  - System Information
    - CPU
      - Temp
      - Usage
      - Frequency
    - RAM
      - Usage
    - Disk
    - Battery
  - Power settings
    - Shutdown
    - Restart
    - Sleep
    - Hibernate
    - Lock
  - Etc
- GPT4VTool.sh
  - Add more actions
    - Save to a file
    - Open in a text editor
    - Add to log file
    - Proper commands
- OpenRGP
  - Install it
- sops-nix
- [spicetify](https://github.com/the-argus/spicetify-nix)
  - Configure something so i can have full screened lyrics
  - Configure something so i can have a mini player
- lf
  - I dont know what i will all need to do to make this viable. More research needed.
  - Add default file types to open with certain programs
  - Add the `enter` key to open files?
- lm-studio
- open-webui
  - Find way to automatically create ~/open-webui otherwise starting the service will fail
- cachix
  - https://wiki.hyprland.org/0.19.2beta/Nix/#cachix
- Virtualization
  - https://angrysysadmins.tech/index.php/2022/07/grassyloki/vfio-tuning-your-windows-gaming-vm-for-optimal-performance/
  - https://mathiashueber.com/performance-tweaks-gaming-on-virtual-machines/
  - https://leduccc.medium.com/improving-the-performance-of-a-windows-10-guest-on-qemu-a5b3f54d9cf5
  - vfio-isolate
    - vfio-isolate is a crazy good project for mapping interrupts and host CPU prioritizes to other CPUs. This is important because host interrupts and CPU usage will cause high latency, stutters, or even crashing in the VM.
- Gamemode
  - Look into using gamemode for better performance

## Useful commands

- `nix-shell -p ncdu --run 'ncdu ./'`: Check disk usage of the current directory
- `nix-shell -p htop --run 'htop'`: Check system usage
- `nix-store --add-fixed sha256 ./CiscoPacketTracer822_amd64_signed.deb`: Adds `cisco packet tracer` deb to the nix store
- `sops updatekeys ./secrets/secrets.yaml`: Update the keys in the secrets file

## Proxmox Containers

- Ensure `Unprivileged container` is enabled.
- Add the `nixos` tag.
- Verify that `Nesting` is enabled.

> **Note:** The password field in the Proxmox UI does not function with NixOS containers.

- After creating the VM, navigate to the `Options` tab and change the console mode to `shell`. Boot the VM and execute the following commands:

    ```sh
    source /etc/set-environment
    passwd
    ```

  You can revert to the default console mode afterward.

- Run `nix-channel --update` to refresh the channels.

- Execute the following command to configure caching:

    ```sh
    sudo nixos-rebuild switch --flake 'github:RickIsNotMyRealName/NixConfig#NixOSBaseContainer'
    ```

  Then run:

    ```sh
    sudo nixos-rebuild switch --flake 'github:RickIsNotMyRealName/NixConfig#<hostname>'
    ```

- Update the password for the user added by the flake.
- Also ensure you run `sudo chown -R <user>:<group> /home/<user>/` to fix the permissions for the user. As they get messed up for some reason.

- Add one or both of the following features:

    ```plaintext
    features: keyctl=1,nesting=1
    ```
- Check if you need to generate a new ssh key for the container. `sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key`

