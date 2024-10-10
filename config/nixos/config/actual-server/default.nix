# Note to self: The selfsigned certificate will need to be regenerated in 365 days.
# Today is: Oct 09, 2024
# Symptoms: Syncing errors.
{ ... }:
{
  myConfig = {
    secrets = {
      "actualbudget-cert.crt" = {
        path = "/var/lib/actual-server/certs/";
        owner = "actual";
      };
      "actualbudget-key.key" = {
        path = "/var/lib/actual-server/certs/";
        owner = "actual";
      };
    };
  };

  services.actual-server = {
    enable = true;
    hostname = "::";
    openFirewall = true;
    https = {
      "key" = "/var/lib/actual-server/certs/actualbudget-key.key";
      "cert" = "/var/lib/actual-server/certs/actualbudget-cert.crt";
    };
    upload = {
      fileSizeLimitMB = "200";
      syncEncryptedFileSizeLimitMB = "200";
      fileSizeSyncLimitMB = "200";
    };
  };
}
