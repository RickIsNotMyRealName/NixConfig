## First run do the following:
/* 
sudo docker run -d \
  --name=comfyui \
  --gpus all \
  -p 8188:8188 \
  -v "${HOME}/comfyui-storage:/home/runner" \
  -e CLI_ARGS="" \
  --hostname=comfyui \
  --security-opt=label=disable \
  --network=host \
  -device=/dev/video1:/dev/video1 \
  yanwk/comfyui-boot:latest
  */
# 
## Then run the following to watch the logs
#
# sudo docker logs comfyui
#
## To restart the container after installing some nodes or something run the following
#
# sudo docker restart comfyui

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # nvidia-docker
  ];

  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
    };
    oci-containers = {
      backend = "docker";
      containers = {
        comfyui = {
          autoStart = true;
          image = "yanwk/comfyui-boot:latest";
          ports = [ "8188:8188" ];
          volumes = [ "${config.users.users.joshk.home}/comfyui-storage:/home/runner" ];
          environment = {
            CLI_ARGS = "";
          };
          extraOptions = [
            "--gpus all"
            "--name=comfyui"
            "--hostname=comfyui"
            "--device=nvidia.com/gpu=all"
            "--security-opt=label=disable"
            "--network=host"
            "-device=/dev/video1:/dev/video1"
          ];
        };
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ 80 443 8080 8188 ];
  };
}
