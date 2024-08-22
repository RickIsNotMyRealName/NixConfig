{ config, ... }:
{
  networking.wireless = {
    enable = true;

    environmentFile = config.sops.secrets."wireless.env".path;

    networks = {
      "@HomeSSID@" = {
        psk = "@HomePassword@";
      };
      # "@MomsHouseSSID@" = {
      #   psk = "@MomsHousePassword@";
      # };
      "@NathansHouseSSID@" = {
        psk = "@NathansHousePass@";
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
