# https://github.com/MattSturgeon/nix-config/blob/029ec2073373c79ece97b66d82878b5ba48e1987/modules/home-manager/firefox.nix#L50
{ pkgs, inputs, ... }:
let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.joshk = {
      extensions = with addons;[
        ublock-origin
        proton-pass
      ];
      settings = {
        # Use `about:config` to find the keys and values
        "signon.rememberSignons" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.pinned" = [
          {
            "label" = "ChatGPT";
            "url" = "https://chat.openai.com/";
          }
        ];
      };
    };
  };
}
