## First run do the following:
/* 
  sudo docker run -d \
  --name=comfyui-cu124-mega \
  --gpus all \
  -p 8188:8188 \
  -v "${HOME}/comfyui-storage:/root/" \
  -e CLI_ARGS="" \
  --hostname=comfyui-cu124-mega \
  --security-opt=label=disable \
  --network=host \
  -device=/dev/video1:/dev/video1 \
  docker.io/yanwk/comfyui-boot:cu124-megapak
  */
# 
## Then run the following to watch the logs
#
# sudo docker logs comfyui-cu124-mega
#
## To restart the container after installing some nodes or something run the following
#
# sudo docker restart comfyui-cu124-mega

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # nvidia-docker
  ];

  hardware.nvidia-container-toolkit.enable = true;

  virtualisation = {
    docker = {
      enable = true;
    };
    oci-containers = {
      backend = "docker";
      containers = {
        comfyui-cu124-mega = {
          autoStart = false;
          image = "yanwk/comfyui-boot:cu124-megapak";
          ports = [ "8188:8188" ];
          volumes = [ "${config.users.users.joshk.home}/comfyui-storage:/root/" ];
          environment = {
            CLI_ARGS = "";
          };
          extraOptions = [
            "--gpus all"
            "--name=comfyui-cu124-mega"
            "--hostname=comfyui-cu124-mega"
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
