# https://github.com/MattSturgeon/nix-config/blob/029ec2073373c79ece97b66d82878b5ba48e1987/modules/home-manager/firefox.nix#L50
{ pkgs, inputs, ... }:
let
  addons = inputs.firefox-addons.packages.${pkgs.system};
  serversHtmlContent = builtins.readFile ./servers.html;

  # Create function to take in an html string and return a string that can be used in a bookmarklet
  createBookmarklet = html: "javascript:(function(){ var html = '" + html + "'; var newWindow = window.open(); newWindow.document.write(html); newWindow.document.close(); })();";
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox;
    profiles = {
      joshk = {
        isDefault = true;
        id = 0;
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
            {
              "label" = "MyNixOS";
              "url" = "https://mynixos.com/";
            }
            {
              "label" = "Homepage";
              "url" = "http://192.168.1.27:3000";
            }
          ];
        };
        bookmarks = [
          {
            name = "Servers";
            toolbar = true;
            bookmarks = [
              {
                url = createBookmarklet serversHtmlContent;
                name = "Servers";
              }
            ];
          }
          {
            name = "PKG Watchlist";
            toolbar = true;
            bookmarks = [
              {
                name = "comfyui: init by fazo96 · Pull Request #268378 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/pull/268378";
              }
            ];
          }
        ];
      };
    };
  };
}
