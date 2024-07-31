{ config, ... }:
{
  networking.wireless = {
    enable = true;

    environmentFile = config.sops.secrets."wireless.env".path;

    networks = {
      "@HomeSSID@" = {
        psk = "@HomePassword@";
      };
      "@SchoolSSID@" = {
        auth = ''
          key_mgmt=WPA-EAP
          eap=PEAP
          phase2="auth=MSCHAPV2"
          identity="@SchoolIdentity@"
          password="@SchoolPassword@"
        '';
      };
      "@PhoneHotspotSSID@" = {
        psk = "@PhoneHotspotPassword@";
      };
    };
  };

}
