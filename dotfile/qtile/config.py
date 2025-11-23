# Complete Qtile config for NixOS with AMD, VLC, Chrome, 1Password, AnyDesk, Thunar
# Tuned for your setup

from libqtile import bar, layout, widget
from libqtile.config import Key, Group, Match, Screen
from libqtile.lazy import lazy
import os

# ---------------------------------------------------------
# VARIABLES
# ---------------------------------------------------------
mod = "mod4"
terminal = "kitty"

apps = {
    "browser": "google-chrome-stable",
    "filemanager": "thunar",
    "launcher": "rofi -show drun",
    "password": "1password",
    "remote": "anydesk",
    "player": "vlc",
}

# ---------------------------------------------------------
# KEYBINDINGS
# ---------------------------------------------------------
keys = [
    # Launch apps
    Key([mod], "Return", lazy.spawn(terminal)),
    Key([mod], "d", lazy.spawn(apps["launcher"])),
    Key([mod], "b", lazy.spawn(apps["browser"])),
    Key([mod], "e", lazy.spawn(apps["filemanager"])),
    Key([mod], "v", lazy.spawn(apps["player"])),
    Key([mod], "p", lazy.spawn(apps["password"])),
    Key([mod], "a", lazy.spawn(apps["remote"])),

    # Window management
    Key([mod], "w", lazy.window.kill()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "t", lazy.window.toggle_floating()),

    # Layout controls
    Key([mod], "h", lazy.layout.shrink()),
    Key([mod], "l", lazy.layout.grow()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),

    # Qtile controls
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "q", lazy.shutdown()),
]

# ---------------------------------------------------------
# WORKSPACES
# ---------------------------------------------------------
groups = [
    Group("1", label=""),  # Web
    Group("2", label=""),  # Code
    Group("3", label=""),  # Files
    Group("4", label=""),  # Terminal
    Group("5", label=""),  # Docs
    Group("6", label=""),  # Media
    Group("7", label=""),  # NAS / Network
    Group("8", label=""),  # Chat
    Group("9", label=""),  # Misc
]

for group in groups:
    keys.append(Key([mod], group.name, lazy.group[group.name].toscreen()))
    keys.append(Key([mod, "shift"], group.name, lazy.window.togroup(group.name)))

# ---------------------------------------------------------
# LAYOUTS
# ---------------------------------------------------------
layouts = [
    layout.MonadTall(margin=10, border_focus="#89b4fa", border_width=2),
    layout.Max(),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=14,
    padding=6,
)

# ---------------------------------------------------------
# BAR
# ---------------------------------------------------------
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    rounded=False,
                    highlight_method="line",
                    this_current_screen_border="#89b4fa",
                    this_screen_border="#585b70",
                    inactive="#a0a0a0",
                ),
                widget.CurrentLayout(),
                widget.WindowName(),

                widget.Spacer(),

                widget.CPU(format="CPU {load_percent}%", update_interval=1),
                widget.Memory(format="RAM {MemUsed: .0f}MB"),
                widget.Net(format="↓{down} ↑{up}"),

                widget.Systray(),

                widget.Clock(format="%Y-%m-%d  %H:%M"),

            ],
            30,
            background="#1e1e2e",
        )
    )
]

# ---------------------------------------------------------
# AUTOSTART
# ---------------------------------------------------------
def autostart():
    script = os.path.expanduser("~/.config/qtile/autostart.sh")
    if os.path.isfile(script):
        os.system(script)

from libqtile import hook
hook.subscribe.startup_once(autostart)

# ---------------------------------------------------------
# FLOATING RULES
# ---------------------------------------------------------
floating_layout = layout.Floating(
    border_focus="#89b4fa",
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="error"),
        Match(title="1Password"),
        Match(title="Picture-in-Picture"),
        Match(wm_class="anydesk"),
    ]
)

# ---------------------------------------------------------
# REQUIRED
# ---------------------------------------------------------
auto_fullscreen = True
focus_on_window_activation = "smart"
