/*
  Sections
  General
  name	description	type	default
  sensitivity	mouse sensitivity (legacy, may cause bugs if not 1, prefer input:sensitivity)	float	1.0
  border_size	size of the border around windows	int	1
  no_border_on_floating	disable borders for floating windows	bool	false
  gaps_in	gaps between windows, also supports css style gaps (top, right, bottom, left -> 5,10,15,20)	int	5
  gaps_out	gaps between windows and monitor edges, also supports css style gaps (top, right, bottom, left -> 5,10,15,20)	int	20
  gaps_workspaces	gaps between workspaces. Stacks with gaps_out.	int	0
  col.inactive_border	border color for inactive windows	gradient	0xff444444
  col.active_border	border color for the active window	gradient	0xffffffff
  col.nogroup_border	inactive border color for window that cannot be added to a group (see denywindowfromgroup dispatcher)	gradient	0xffffaaff
  col.nogroup_border_active	active border color for window that cannot be added to a group	gradient	0xffff00ff
  cursor_inactive_timeout	in seconds, after how many seconds of cursor’s inactivity to hide it. Set to 0 for never.	int	0
  layout	which layout to use. [dwindle/master]	str	dwindle
  no_cursor_warps	if true, will not warp the cursor in many cases (focusing, keybinds, etc)	bool	false
  no_focus_fallback	if true, will not fall back to the next available window when moving focus in a direction where no window was found	bool	false
  apply_sens_to_raw	if on, will also apply the sensitivity to raw mouse output (e.g. sensitivity in games) NOTICE: really not recommended.	bool	false
  resize_on_border	enables resizing windows by clicking and dragging on borders and gaps	bool	false
  extend_border_grab_area	extends the area around the border where you can click and drag on, only used when general:resize_on_border is on.	int	15
  hover_icon_on_border	show a cursor icon when hovering over borders, only used when general:resize_on_border is on.	bool	true
  allow_tearing	master switch for allowing tearing to occur. See the Tearing page.	bool	false
  Prefer using input:sensitivity over general:sensitivity to avoid bugs, especially with Wine/Proton apps.
  
  Decoration
  name	description	type	default
  rounding	rounded corners’ radius (in layout px)	int	0
  active_opacity	opacity of active windows. [0.0 - 1.0]	float	1.0
  inactive_opacity	opacity of inactive windows. [0.0 - 1.0]	float	1.0
  fullscreen_opacity	opacity of fullscreen windows. [0.0 - 1.0]	float	1.0
  drop_shadow	enable drop shadows on windows	bool	true
  shadow_range	Shadow range (“size”) in layout px	int	4
  shadow_render_power	in what power to render the falloff (more power, the faster the falloff) [1 - 4]	int	3
  shadow_ignore_window	if true, the shadow will not be rendered behind the window itself, only around it.	bool	true
  col.shadow	shadow’s color. Alpha dictates shadow’s opacity.	color	0xee1a1a1a
  col.shadow_inactive	inactive shadow color. (if not set, will fall back to col.shadow)	color	unset
  shadow_offset	shadow’s rendering offset.	vec2	[0, 0]
  shadow_scale	shadow’s scale. [0.0 - 1.0]	float	1.0
  dim_inactive	enables dimming of inactive windows	bool	false
  dim_strength	how much inactive windows should be dimmed [0.0 - 1.0]	float	0.5
  dim_special	how much to dim the rest of the screen by when a special workspace is open. [0.0 - 1.0]	float	0.2
  dim_around	how much the dimaround window rule should dim by. [0.0 - 1.0]	float	0.4
  screen_shader	a path to a custom shader to be applied at the end of rendering. See examples/screenShader.frag for an example.	str	[[Empty]]
  Blur
  Subcategory decoration:blur:

  name	description	type	default
  enabled	enable kawase window background blur	bool	true
  size	blur size (distance)	int	8
  passes	the amount of passes to perform	int	1
  ignore_opacity	make the blur layer ignore the opacity of the window	bool	false
  new_optimizations	whether to enable further optimizations to the blur. Recommended to leave on, as it will massively improve performance.	bool	true
  xray	if enabled, floating windows will ignore tiled windows in their blur. Only available if blur_new_optimizations is true. Will reduce overhead on floating blur significantly.	bool	false
  noise	how much noise to apply. [0.0 - 1.0]	float	0.0117
  contrast	contrast modulation for blur. [0.0 - 2.0]	float	0.8916
  brightness	brightness modulation for blur. [0.0 - 2.0]	float	0.8172
  vibrancy	Increase saturation of blurred colors. [0.0 - 1.0]	float	0.1696
  vibrancy_darkness	How strong the effect of vibrancy is on dark areas . [0.0 - 1.0]	float	0.0
  special	whether to blur behind the special workspace (note: expensive)	bool	false
  popups	whether to blur popups (e.g. right-click menus)	bool	false
  popups_ignorealpha	works like ignorealpha in layer rules. If pixel opacity is below set value, will not blur. [0.0 - 1.0]	float	0.2

  Parameter explanation
  Param type	Description
  window	a window. Any of the following: Class regex, title: and a title regex, pid: and the pid, address: and the address, floating, tiled
  workspace	see below.
  direction	l r u d left right up down
  monitor	One of: direction, ID, name, current, relative (e.g. +1 or -1)
  resizeparams	relative pixel delta vec2 (e.g. 10 -10), optionally a percentage of the window size (e.g. 20 25%) or exact followed by an exact vec2 (e.g. exact 1280 720), optionally a percentage of the screen size (e.g. exact 50% 50%)
  floatvalue	a relative float delta (e.g -0.2 or +0.2) or exact followed by a the exact float value (e.g. exact 0.5)
  zheight	top or bottom
  List of Dispatchers
  Dispatcher	Description	Params
  exec	executes a shell command	command (supports rules, see below)
  execr	executes a raw shell command (does not support rules)	command
  pass	passes the key (with mods) to a specified window. Can be used as a workaround to global keybinds not working on Wayland.	window
  killactive	closes (not kills) the active window	none
  closewindow	closes a specified window	window
  workspace	changes the workspace	workspace
  movetoworkspace	moves the focused window to a workspace	workspace OR workspace,window for a specific window
  movetoworkspacesilent	same as above, but doesnt switch to the workspace	workspace OR workspace,window for a specific window
  togglefloating	toggles the current window’s floating state	left empty / active for current, or window for a specific window
  fullscreen	toggles the focused window’s fullscreen state	0 - fullscreen (takes your entire screen), 1 - maximize (keeps gaps and bar(s)), 2 - fullscreen (same as fullscreen except doesn’t alter window’s internal fullscreen state)
  fakefullscreen	toggles the focused window’s internal fullscreen state without altering the geometry	none
  dpms	sets all monitors’ DPMS status. Do not use with a keybind directly.	on, off, or toggle. For specific monitor add monitor name after a space
  pin	pins a window (i.e. show it on all workspaces) note: floating only	left empty / active for current, or window for a specific window
  movefocus	moves the focus in a direction	direction
  movewindow	moves the active window in a direction or to a monitor. For floating windows, moves the window to the screen edge in that direction	direction or mon: and a monitor
  swapwindow	swaps the active window with another window in the given direction	direction
  centerwindow	center the active window note: floating only	none (for monitor center) or 1 (to respect monitor reserved area)
  resizeactive	resizes the active window	resizeparams
  moveactive	moves the active window	resizeparams
  resizewindowpixel	resizes a selected window	resizeparams,window, e.g. 100 100,^(kitty)$
  movewindowpixel	moves a selected window	resizeparams,window
  cyclenext	focuses the next window on a workspace	none (for next) or prev (for previous) additionally tiled for only tiled, floating for only floating. prev tiled is ok.
  swapnext	swaps the focused window with the next window on a workspace	none (for next) or prev (for previous)
  focuswindow	focuses the first window matching	window
  focusmonitor	focuses a monitor	monitor
  splitratio	changes the split ratio	floatvalue
  toggleopaque	toggles the current window to always be opaque. Will override the opaque window rules.	none
  movecursortocorner	moves the cursor to the corner of the active window	direction, 0 - 3, bottom left - 0, bottom right - 1, top right - 2, top left - 3
  movecursor	moves the cursor to a specified position	x y
  renameworkspace	rename a workspace	id name, e.g. 2 work
  exit	exits the compositor with no questions asked.	none
  forcerendererreload	forces the renderer to reload all resources and outputs	none
  movecurrentworkspacetomonitor	Moves the active workspace to a monitor	monitor
  focusworkspaceoncurrentmonitor	Focuses the requested workspace on the current monitor, swapping the current workspace to a different monitor if necessary. If you want XMonad/Qtile-style workspace switching, replace workspace in your config with this.	workspace
  moveworkspacetomonitor	Moves a workspace to a monitor	workspace and a monitor separated by a space
  swapactiveworkspaces	Swaps the active workspaces between two monitors	two monitors separated by a space
  bringactivetotop	Deprecated in favor of alterzorder. Brings the current window to the top of the stack	none
  alterzorder	Modify the window stack order of the active or specified window. Note: this cannot be used to move a floating window behind a tiled one.	zheight[,window]
  togglespecialworkspace	toggles a special workspace on/off	none (for the first) or name for named (name has to be a special workspace’s name)
  focusurgentorlast	Focuses the urgent window or the last window	none
  togglegroup	toggles the current active window into a group	none
  changegroupactive	switches to the next window in a group.	b - back, f - forward, or index start at 1
  focuscurrentorlast	Switch focus from current to previously focused window	none
  lockgroups	Locks the groups (all groups will not accept new windows)	lock for locking, unlock for unlocking, toggle for toggle
  lockactivegroup	Lock the focused group (the current group will not accept new windows or be moved to other groups)	lock for locking, unlock for unlocking, toggle for toggle
  moveintogroup	Moves the active window into a group in a specified direction. No-op if there is no group in the specified direction.	direction
  moveoutofgroup	Moves the active window out of a group. No-op if not in a group	left empty / active for current, or window for a specific window
  movewindoworgroup	Behaves as moveintogroup if there is a group in the given direction. Behaves as moveoutofgroup if there is no group in the given direction relative to the active group. Otherwise behaves like movewindow.	direction
  movegroupwindow	Swaps the active window with the next or previous in a group	b for back, anything else for forward
  denywindowfromgroup	Prohibit the active window from becoming or being inserted into group	on, off or, toggle
  setignoregrouplock	Temporarily enable or disable binds:ignore_group_lock	on, off, or toggle
  global	Executes a Global Shortcut using the GlobalShortcuts portal. See here	name
  submap	Change the current mapping group. See Submaps	reset or name
  it is NOT recommended to set DPMS with a keybind directly, as it might cause undefined behavior. Instead, consider something like

  bind = MOD,KEY,exec,sleep 1 && hyprctl dispatch dpms off
  Grouped (tabbed) windows
  Hyprland allows you to make a group from the current active window with the togglegroup bind dispatcher.

  A group is like i3wm’s “tabbed” container. It takes the space of one window, and you can change the window to the next one in the tabbed “group” with the changegroupactive bind dispatcher.

  The new group’s border colors are configurable with the appropriate col. settings in the group config section.

  You can lock a group with the lockactivegroup dispatcher in order to stop new window from entering this group. In addition, the lockgroups dispatcher can be used to toggle an independent global group lock that will prevent new window from entering any groups, regardless of their local group lock stat.

  You can prevent a window from being added to group or becoming a group with the denywindowfromgroup dispatcher. movewindoworgroup will behave like movewindow if current active window or window in direction has this property set.

  Workspaces
  You have eight choices:

  ID: e.g. 1, 2, or 3

  Relative ID: e.g. +1, -3 or +100

  Relative workspace on monitor: e.g. m+1, m-1 or m+3

  Relative workspace on monitor including empty workspaces: e.g. r+1 or r-3

  Relative open workspace: e.g. e+1 or e-10

  Name: e.g. name:Web, name:Anime or name:Better anime

  Previous workspace: previous

  First available empty workspace: empty

  Special Workspace: special or special:name for named special workspaces.

  special is supported ONLY on movetoworkspace and movetoworkspacesilent. Any other dispatcher will result in undocumented behavior.
  Numerical workspaces (e.g. 1, 2, 13371337) are allowed ONLY between 1 and 2147483647 (inclusive)

  Neither 0 nor negative numbers are allowed.

  Special Workspace
  A special workspace is what is called a “scratchpad” in some other places. A workspace that you can toggle on/off on any monitor.

  You can define multiple named special workspaces, but the amount of those is limited to 97 at a time.
  For example, to move a window/application to a special workspace you can use the following syntax:

  bind = SUPER, C, movetoworkspace, special
  #The above syntax will move the window to a special workspace upon pressing 'SUPER'+'C'.
  #To see the hidden window you can use the togglespecialworkspace dispatcher mentioned above.
  Executing with rules
  The exec dispatcher supports adding rules. Please note some windows might work better, some worse. It records the PID of the spawned process and uses that. If your process e.g. forks and then the fork opens a window, this will not work.

  The syntax is:

  bind = mod, key, exec, [rules...] command
  For example:

  bind = SUPER, E, exec, [workspace 2 silent;float;noanim] kitty
*/
{ config, pkgs, ... }:
{
  source = "$HOME/.cache/wal/colors-hyprland.conf";

  "$mod" = "SUPER";
  "$superMod" = "SUPER_SHIFT";
  "$winKey" = "SUPER";
  "$terminal" = "alacritty";
  "$menu" = "wofi --show=drun --matching fuzzy --normal-window";
  # "$menu" = "rofi -show drun -show-icons";
  # "$launcher" = "wofi --show=run";
  # "$launcher" = "rofi -show drun -show-icons";
  "$opacityActive" = "1";
  "$opacityInactive" = "1";
  "$opacityFullscreen" = "1";
  "$floatOpacity" = "1";

  general = {
    "sensitivity" = "1.0";
    "border_size" = "3";
    "no_border_on_floating" = "true";
    "gaps_in" = "5";
    "gaps_out" = "10";
    # "gaps_workspaces" = "30";
    "col.inactive_border" = "$color0";
    "col.active_border" = "$foreground";
    "col.nogroup_border" = "$color13";
    "col.nogroup_border_active" = "$color10";
    "cursor_inactive_timeout" = "0";
    "layout" = "master";
    "no_cursor_warps" = "true";
    "no_focus_fallback" = "true";
    "apply_sens_to_raw" = "false";
    "resize_on_border" = "true";
    "extend_border_grab_area" = "15";
    "hover_icon_on_border" = "true";
    "allow_tearing" = "true";
  };

  dwindle = { };

  master = { };

  decoration = {
    "rounding" = "12";
    "active_opacity" = "$opacityActive";
    "inactive_opacity" = "$opacityInactive";
    "fullscreen_opacity" = "$opacityFullscreen";

    "drop_shadow" = "true";
    "shadow_range" = "4";
    "shadow_render_power" = "3";
    "shadow_ignore_window" = "true";
    "col.shadow" = "$color0";
    "col.shadow_inactive" = "$color1";
    "shadow_offset" = "0, 0";
    "shadow_scale" = "1.0";
    "dim_inactive" = "false"; # ---------------------------------------------
    "dim_strength" = "0.5";
    "dim_special" = "0.2";
    "dim_around" = "0.4";
    "screen_shader" = "";

    blur = {
      "enabled" = "true";
      "size" = "8";
      "passes" = "1";
      "ignore_opacity" = "false";
      "new_optimizations" = "true";
      "xray" = "false";
      "noise" = "0.0117";
      "contrast" = "0.8916";
      "brightness" = "0.8172";
      "vibrancy" = "0.1696";
      "vibrancy_darkness" = "0.0";
      "special" = "false";
      # "popups" = "false";
      # "popups_ignorealpha" = "0.2";
    };
  };

  monitor = [
    # DP-3 Left
    "DP-3, highrr, 0x0, 1, vrr, 1"
    # HDMI-A-1 Right 
    "HDMI-A-1, highrr, 1920x0, 1"
    "eDP-1, 1920x1080@144, 0x0, 1"
    "Unknown-1, disable"
  ];





  workspace = [
    "1"
    "2"
    "3"
    "4"
    "5"
    "6"
    "7"
    "8"
    "9"
    "10"
  ];

  input = {
    touchpad = {
      natural_scroll = "false";
    };
    accel_profile = "flat";
  };

  /*
    # l -> do stuff even when locked
    # e -> repeats when key is held down
    # m -> mouse
  */

  bind = [
    "$mod, RETURN, exec, alacritty"
    "SUPER_SHIFT, Q, killactive"
    "$mod, D, exec, $menu"
    "$mod, L, exec, hyprlock"

    "$mod, 1, workspace, 1"
    "$mod, 2, workspace, 2"
    "$mod, 3, workspace, 3"
    "$mod, 4, workspace, 4"
    "$mod, 5, workspace, 5"
    "$mod, 6, workspace, 6"
    "$mod, 7, workspace, 7"
    "$mod, 8, workspace, 8"
    "$mod, 9, workspace, 9"
    "$mod, 0, workspace, 10"

    "$superMod, 1, movetoworkspace, 1"
    "$superMod, 2, movetoworkspace, 2"
    "$superMod, 3, movetoworkspace, 3"
    "$superMod, 4, movetoworkspace, 4"
    "$superMod, 5, movetoworkspace, 5"
    "$superMod, 6, movetoworkspace, 6"
    "$superMod, 7, movetoworkspace, 7"
    "$superMod, 8, movetoworkspace, 8"
    "$superMod, 9, movetoworkspace, 9"
    "$superMod, 0, movetoworkspace, 10"

    # binds to resize active window
    "$superMod, UP, resizeactive, 0 -5%"
    "$superMod, DOWN, resizeactive, 0 5%"
    "$superMod, LEFT, resizeactive, -5% 0"
    "$superMod, RIGHT, resizeactive, 5% 0"

    # Reload the configuration file
    "$superMod, C, exec, hyprctl reload"

    # binds to switch focus
    "$mod, LEFT, movefocus, l"
    "$mod, RIGHT, movefocus, r"
    "$mod, UP, movefocus, u"
    "$mod, DOWN, movefocus, d"

    # Full screen and fake full screen
    "$mod, F, fullscreen"
    "$mod, G, fakefullscreen"

    # Set current window to floating
    "$mod, SPACE, togglefloating"

    # Pin current window
    "$mod, P, pin"

    # Open notification center
    "superMod, n, exec, swaync-client -t"

    # Screenshots
    ## To clipboard
    ", Print, exec, grim -g \"$(slurp -w 0)\" - | wl-copy"

    ## To file
    "$mod, Print, exec, grim -g \"$(slurp -w 0)\" ~/Pictures/Screenshots/$(date +'%Y-%m-%d-%H-%M-%S').png"

    ## Call GPT4VTool
    "$mod, N, exec, GPT4VTool.sh"

    "CTRL, ALT_L, submap, passthrough\nsubmap = passthrough"
    "CTRL, ALT_L, submap, reset\nsubmap = reset"



    # Reload background using `~/.config/hypr/scripts/changeWallpaper.sh`
    "$mod, U, exec, ~/.config/hypr/scripts/changeWallpaper.sh"
  ];

  bindm = [
    # mouse movements
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
    "$mod ALT, mouse:272, resizewindow"
  ];

  binde = [
    # Volume control
    ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
  ];

  bindle = [
    # Media control
    ",XF86AudioPlay, exec, playerctl play-pause"
    ",XF86AudioNext, exec, playerctl next"
    ",XF86AudioPrev, exec, playerctl previous"
  ];

  bezier = [
    "overshoot, 0.5, 1.5, 0.5, 1.5"
  ];

  animation = [
    "workspaces, 1, 3, overshoot"
  ];

  windowrulev2 = [
    "float, title:^(Picture in picture)$"
  ];

  # every reload
  exec = [
    ".config/hypr/scripts/reload.sh"

  ];

  # every launch
  exec-once = [
    ".config/hypr/scripts/launch.sh"
    # ".config/hypr/scripts/reload.sh"
    "exec ${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
    "[workspace 9 silent] google-chrome-stable --app=https://messages.google.com/web"
    "[workspace 0 silent] google-chrome-stable --app=https://calendar.google.com"
    "[workspace 8 silent] spotify"
    "[workspace 9 silent] google-chrome-stable --app=https://chat.openai.com"
    "wayvnc -o HDMI-A-1 0.0.0.0"
  ];
}
