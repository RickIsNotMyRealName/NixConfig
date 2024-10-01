{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    acceleration = "cuda";
    environmentVariables = {
      # OLLAMA_LLM_LIBRARY = "cuda_v12";
      OLLAMA_CUDA_LIBRARY = "cuda_v11";
      OLLAMA_HOST = "0.0.0.0";
    };
    listenAddress = "0.0.0.0:11434";
  };
}
