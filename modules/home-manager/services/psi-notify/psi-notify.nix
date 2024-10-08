# psi-notify.nix - NixOS module for psi-notify
# Config file location: ~/.config/psi-notify

# Config file example:
/*
  update 5
  log_pressures false

  threshold cpu some avg10 50.00
  threshold memory some avg10 10.00
  threshold io full avg10 15.00
*/

# Config file format:
/*
  Config format
  update
  The update interval in seconds is specified with update [int]. The default is update 5 if unspecified.

  log_pressures
  If you'd like messages like this at every update interval, you can set log_pressures true (the default is false):

  INFO: Current CPU pressures: some avg10=0.00 avg60=0.02 avg300=0.01
  INFO: Current memory pressures: some avg10=0.00 avg60=0.00 avg300=0.00
  INFO: Current memory pressures: full avg10=0.00 avg60=0.00 avg300=0.00
  INFO: Current I/O pressures: some avg10=0.00 avg60=0.00 avg300=0.00
  INFO: Current I/O pressures: full avg10=0.00 avg60=0.00 avg300=0.00
  threshold
  Thresholds are specified with fields in the following format:

  The word threshold.
  The resource name, as shown in cgroup.controllers. cpu, memory, and io are currently supported.
  Whether to use the some or full metric. See the definition here.
  The PSI time period. avg10, avg60, and avg300 are currently supported.
  The threshold, as a real number between 0 and 100. Decimals are ok.
*/

# psi-notify.service:
/*
  [Unit]
  Description=notify on system-wide resource pressure using PSI
  Documentation=man:psi-notify(1)
  PartOf=graphical-session.target

  [Service]
  ExecStart=psi-notify
  ExecReload=kill -HUP $MAINPID
  Type=notify

  Restart=always

  Slice=background.slice

  # Will be updated by watchdog_update_usec() once we parsed the config
  WatchdogSec=2s
*/
{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.services.psi-notify;

  customToKeyValue = attrs:
    let
      renderValue = value:
        if lib.isAttrs value then
          lib.concatStringsSep "\n" (lib.mapAttrsToList (n: v: "threshold ${n} ${v}") value)
        else
          toString value;
    in
    lib.concatStringsSep "\n" (lib.mapAttrsToList
      (name: value:
        if lib.isAttrs value then
          renderValue value
        else
          "${name} ${renderValue value}"
      )
      attrs);

  toConfig = attrs: ''
    ${customToKeyValue attrs}
  '';
in
{
  meta.maintainers = [ ];

  options.services.psi-notify = {
    enable = lib.mkEnableOption "psi-notify, Alert on system resource saturation.";

    package = lib.mkPackageOption pkgs "psi-notify" { };

    settings = lib.mkOption {
      default = { };
      type = lib.types.attrs;
      description = ''
        Configuration for psi-notify.abort
        See the following:
          https://github.com/cdown/psi-notify?tab=readme-ov-file#config
          https://github.com/cdown/psi-notify?tab=readme-ov-file#config-format
      '';
    };

  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile = lib.mkMerge [
      (lib.mkIf (cfg.settings != { }) {
        "psi-notify" = {
          text = toConfig cfg.settings;
          onChange = ''
            systemctl --user restart psi-notify.service
          '';
        };
      })
    ];


    systemd.user.services."psi-notify" = {
      Unit = {
        Description = "Notify on system-wide resource pressure using PSI";
        Documentation = [ "man:psi-notify(1)" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${cfg.package}/bin/psi-notify";
        ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
        Type = "notify";
        Restart = "always";
        Slice = "background.slice";
        WatchdogSec = "2s";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
