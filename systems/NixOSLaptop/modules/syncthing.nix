{ ... }:
{



  services.syncthing = {
    enable = true;
    user = "joshk";

    dataDir = "/home/joshk/Desktop/SyncStuff/";
    configDir = "/home/joshk/.config/syncthing/";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "Phone" = { id = "BB2RSBN-GZFJD7C-RIUKG25-TM6XUYX-PYECN7Z-FBGJFP2-JYF27D7-XHMR2AU"; };
        "Desktop" = { id = "3KXYBCD-CPUKQMO-YAXCSK4-YEU6JJU-5SJXD4Z-3N4BAW5-ZHGY2ID-XCVYRA6"; };
        "NixDesktop" = { id = "6U76ECD-UC55YWI-DUVBXM5-VZUX7Q6-KF2EHSX-2G3CVRX-LFMV4NO-CUEGWQN"; };
      };
      folders = {
        "Apex Obsidian" = {
          id = "puxod-femtr";
          path = "/home/joshk/Desktop/SyncStuff/Apex Obsidian";
          devices = [
            "Phone"
            "Desktop"
            "NixDesktop"
          ];
        };
        "Bible" = {
          id = "vbtma-4zy6q";
          path = "/home/joshk/Desktop/SyncStuff/Bible";
          devices = [
            "Phone"
            "Desktop"
            "NixDesktop"
          ];
        };
        "Books" = {
          id = "eyf6l-uogcs";
          path = "/home/joshk/Desktop/SyncStuff/Books";
          devices = [
            "Phone"
            "Desktop"
            "NixDesktop"
          ];
        };
        "Camera" = {
          id = "motorola_edge_2022_33f5-photos";
          path = "/home/joshk/Desktop/SyncStuff/Camera";
          devices = [
            "Phone"
            "Desktop"
            "NixDesktop"
          ];
        };
        "Other" = {
          id = "zn9ne-yzwvu";
          path = "/home/joshk/Desktop/SyncStuff/Other";
          devices = [
            "Phone"
            "Desktop"
            "NixDesktop"
          ];
        };
        "SchoolStuff" = {
          id = "SchoolStuff";
          path = "/home/joshk/Desktop/SyncStuff/SchoolStuff";
          devices = [
            "Phone"
            "Desktop"
            "NixDesktop"
          ];
        };
        "NixOSConfig" = {
          path = "/home/joshk/NixConfig";
          devices = [
            "Desktop"
            "Phone"
            "NixDesktop"
          ];
        };
      };
    };
  };
}
