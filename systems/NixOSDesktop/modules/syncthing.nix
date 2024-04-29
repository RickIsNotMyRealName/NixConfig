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
        "Laptop" = { id = "S3P5RBJ-KAUXPE3-4CZAA4D-WOFJSQI-GQRMVEN-W3MAIY6-NVA5JIA-XYJMVAE"; };
      };
      folders = {
        "Apex Obsidian" = {
          id = "puxod-femtr";
          path = "/home/joshk/Desktop/SyncStuff/Apex Obsidian";
          devices = [
            "Phone"
            "Laptop"
          ];
        };
        "Bible" = {
          id = "vbtma-4zy6q";
          path = "/home/joshk/Desktop/SyncStuff/Bible";
          devices = [
            "Phone"
            "Laptop"
          ];
        };
        "Books" = {
          id = "eyf6l-uogcs";
          path = "/home/joshk/Desktop/SyncStuff/Books";
          devices = [
            "Phone"
            "Laptop"
          ];
        };
        "Camera" = {
          id = "motorola_edge_2022_33f5-photos";
          path = "/home/joshk/Desktop/SyncStuff/Camera";
          devices = [
            "Phone"
            "Laptop"
          ];
        };
        "Other" = {
          id = "zn9ne-yzwvu";
          path = "/home/joshk/Desktop/SyncStuff/Other";
          devices = [
            "Phone"
            "Laptop"
          ];
        };
        "SchoolStuff" = {
          id = "SchoolStuff";
          path = "/home/joshk/Desktop/SyncStuff/SchoolStuff";
          devices = [
            "Phone"
            "Laptop"
          ];
        };
        "NixOSConfig" = {
          path = "/home/joshk/NixConfig";
          devices = [
            "Phone"
            "Laptop"
          ];
        };
      };
    };
  };
}
