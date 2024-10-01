# Note to self: The selfsigned certificate will need to be regenerated in 365 days.
# Today is: Sept 23, 2024
# Symptoms: Syncing errors.
{ ... }:
{
  services.actual-server = {
    enable = true;
    hostname = "::";
    openFirewall = true;
    https = {
      "key" = "/var/lib/actual-server/certs/selfhost.key";
      "cert" = "/var/lib/actual-server/certs/selfhost.crt";
    };
    upload = {
      fileSizeLimitMB = "200";
      syncEncryptedFileSizeLimitMB = "200";
      fileSizeSyncLimitMB = "200";
    };
  };
}
