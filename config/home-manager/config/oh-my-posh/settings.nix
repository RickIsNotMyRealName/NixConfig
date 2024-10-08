/*
  # https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/agnoster.minimal.omp.json
  {
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
  {
      "alignment": "left",
      "segments": [
        {
          "foreground": "#ffffff",
          "style": "plain",
          "template": "{{ reason .Code }}\u274c ",
          "type": "status"
        },
        {
          "foreground": "#ff0000",
          "style": "plain",
          "template": "# ",
          "type": "root"
        },
        {
          "foreground": "#ffffff",
          "style": "plain",
          "template": "{{ .UserName }}@{{ .HostName }} ",
          "type": "session"
        },
        {
          "background": "#007ACC",
          "foreground": "#ffffff",
          "properties": {
            "folder_icon": "\u2026",
            "folder_separator_icon": " \ue0b1 ",
            "style": "agnoster_short",
            "max_depth": 3
          },
          "style": "plain",
          "template": "<transparent>\ue0b0</> {{ .Path }} ",
          "type": "path"
        },
        {
          "background": "#007ACC",
          "foreground": "#ffffff",
          "properties": {
            "cherry_pick_icon": "\u2713 ",
            "commit_icon": "\u25b7 ",
            "fetch_status": true,
            "merge_icon": "\u25f4 ",
            "no_commits_icon": "[no commits]",
            "rebase_icon": "\u2c62 ",
            "tag_icon": "\u▶ "
          },
          "style": "plain",
          "template": "{{ .HEAD }}{{ if and (eq .Ahead 0) (eq .Behind 0) }} \u≡{{end}}{{ if gt .Ahead 0 }} \u↑{{.Ahead}}{{end}}{{ if gt .Behind 0 }} \u↓{{.Behind}}{{end}} {{ if .Working.Changed }}+{{ .Working.Added }} ~{{ .Working.Modified }} -{{ .Working.Deleted }} {{ end }}",
          "type": "git"
        },
        {
          "foreground": "#007ACC",
          "style": "plain",
          "template": "\ue0b0 ",
          "type": "text"
        }
      ],
      "type": "prompt"
  }
  ],
  "version": 2
  }
*/

{
  "$schema" = ''https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json"'';
  "blocks" = [
    {
      "alignment" = "left";
      "segments" = [
        {
          "foreground" = "#ffffff";
          "style" = "plain";
          "template" = ''{{ reason .Code }}❌ '';
          "type" = "status";
        }
        {
          "foreground" = "#ff0000";
          "style" = "plain";
          "template" = "# ";
          "type" = "root";
        }
        {
          "foreground" = "#ffffff";
          "style" = "plain";
          "template" = "{{ .UserName }}@{{ .HostName }} ";
          "type" = "session";
        }
        {
          "background" = "#007ACC";
          "foreground" = "#ffffff";
          "properties" = {
            "folder_icon" = "…";
            "folder_separator_icon" = "  ";
            "style" = "agnoster_short";
            "max_depth" = 3;
          };
          "style" = "plain";
          "template" = "<transparent></> {{ .Path }} ";
          "type" = "path";
        }
        {
          "background" = "#007ACC";
          "foreground" = "#ffffff";
          "properties" = {
            "cherry_pick_icon" = "✓ ";
            "commit_icon" = "▷ ";
            "fetch_status" = true;
            "merge_icon" = "◴ ";
            "no_commits_icon" = "[no commits]";
            "rebase_icon" = "Ɫ ";
            "tag_icon" = "▶ ";
          };
          "style" = "plain";
          "template" = "{{ .HEAD }}{{ if and (eq .Ahead 0) (eq .Behind 0) }} ≡{{end}}{{ if gt .Ahead 0 }} ↑{{.Ahead}}{{end}}{{ if gt .Behind 0 }} ↓{{.Behind}}{{end}} {{ if .Working.Changed }}+{{ .Working.Added }} ~{{ .Working.Modified }} -{{ .Working.Deleted }} {{ end }}";
          "type" = "git";
        }
        {
          "foreground" = "#007ACC";
          "style" = "plain";
          "template" = " ";
          "type" = "text";
        }
      ];
      "type" = "prompt";
    }
  ];
  "transient_prompt" = {
    "background" = "transparent";
    "foreground" = "#ffffff";
    "template" = " ";
  };

  "version" = 2;
}
