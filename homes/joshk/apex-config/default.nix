{ config, ... }:
let
  steamApexDataPath = "${config.xdg.dataHome}/Steam/steamapps/common/Apex Legends/";
  r5ReloadedApexDataPath = "${config.home.homeDirectory}/Games/ea-app/drive_c/R5Reloaded/";

  steamApexSaveDataPath = "${config.xdg.dataHome}/Steam/steamapps/compatdata/1172470/pfx/drive_c/users/steamuser/Saved Games/Respawn/Apex/";
  r5ReloadedApexSaveDataPath = "${config.home.homeDirectory}/Games/ea-app/drive_c/users/steamuser/Saved Games/Respawn/Apex/";
in
{
  # ./cfg/autoexec.cfg
  xdg.dataFile."${steamApexDataPath}/cfg/autoexec.cfg" = {
    source = ./cfg/autoexec.cfg;
  };
  xdg.dataFile."${r5ReloadedApexDataPath}/cfg/autoexec.cfg" = {
    source = ./cfg/autoexec.cfg;
  };

  
  # ./local/settings.cfg
  xdg.dataFile."${steamApexDataPath}/local/settings.cfg" = {
    source = ./local/settings.cfg;
  };

  
  # ./local/videoconfig.txt
  xdg.dataFile."${steamApexDataPath}/local/videoconfig.txt" = {
    source = ./local/videoconfig.txt;
  };
  xdg.dataFile."${r5ReloadedApexDataPath}/local/videoconfig.txt" = {
    source = ./local/videoconfig.txt;
  };

  
  # ./profile/profile.cfg
  xdg.dataFile."${steamApexDataPath}/profile/profile.cfg" = {
    source = ./profile/profile.cfg;
  };
  xdg.dataFile."${r5ReloadedApexDataPath}/profile/profile.cfg" = {
    source = ./profile/profile.cfg;
  };

}
