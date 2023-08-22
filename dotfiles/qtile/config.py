###############################################################################
####### IMPORTS ###############################################################

from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras.popup.toolkit import (
    PopupRelativeLayout,
    PopupImage,
    PopupText
)
import os
import subprocess

###############################################################################
####### VARIABLES #############################################################

mod = "mod4"
terminal = "alacritty"
isMultiMonitorMode = "DP-2" in subprocess.getoutput('xrandr | grep "DP-2 connected"')

bar_height = 26
bar_opacity = 0.8
bar_border = 5
bar_margin = [6, 6, 3, 6]
colors = {
  "bar": "#232136",
  "bar-border": "#232136",
  "bar-light": "#2a273f",  # #393552
  "bar-lighter": "#393552", # #44415a
  "foreground": "#ffffff",
  "dimmed": "#f1f1f1",
  "blue": "#96CDFB",
  "green": "#ABE9B3",
  "yellow": "#FAE3B0",
  "pink": "#F5C2E7",
  "orange": "#F8BD96"
}
gap_size = 3

startScreen = 0
groups = []



###############################################################################
####### AUTOSTART #############################################################

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])



###############################################################################
####### CUSTOM CLASSES ########################################################

class screenGenInfo:
    def __init__(self, groupScreen, groups):
        self.groupScreen = groupScreen
        self.groups = groups

class groupGenInfo:
    def __init__(self, spawn=[], layout="", matches=[]):
        self.matches = matches
        self.spawn = spawn
        self.layout = layout



###############################################################################
####### CUSTOM METHODS ########################################################

def focus_group(qtile, screen, group):
    qtile.focus_screen(screen)
    qtile.groups_map[group].cmd_toscreen()
    move_cursor_to_screen(screen)

def move_window(qtile, screen, group):
    qtile.focus_screen(screen)
    qtile.groups_map[group].cmd_toscreen()
    qtile.window.togroup(group)

def longNameParse(text):
    for string in ["Chromium", "Firefox", "Brave", "Slack", "PhpStorm", "FreeTube", "Thunderbird", "Discord"]:
        if string in text:
            text = string
        elif "moonlander@" in text:
            text = "Alacritty"
        else:
            text = text
    return text

@lazy.function
def go_to_prev_group(qtile):
    i = qtile.groups.index(qtile.current_group)
    if qtile.current_window is not None and i != 0:
        qtile.current_screen.toggle_group(qtile.groups[i - 1])

@lazy.function
def go_to_next_group(qtile):
    i = qtile.groups.index(qtile.current_group)
    if qtile.current_window is not None and i != 6:
        qtile.current_screen.toggle_group(qtile.groups[i + 1])

def move_cursor_to_screen(screen):
  if screen == 2: # right screen
    x_axis_position = "4800"
  elif screen == 1: # center screen
    x_axis_position = "2880"
  else: # left screen
    x_axis_position = "960"

  cmd = "xdotool mousemove " + x_axis_position + " 540"
  os.system(cmd)

# Allows you to input a name when adding treetab section.
@lazy.layout.function
def add_treetab_section(layout):
  prompt = qtile.widgets_map["prompt"]
  prompt.start_input("Section name: ", layout.cmd_add_section)


###############################################################################
####### LAYOUTS ###############################################################

layout_defaults = dict(
    border_focus = "#fff243",
    border_width = 2,
    margin = 3,
    font="Ubuntu",
    fontsize=14
)

layouts = [
    layout.MonadTall(
                name = 'MonadTall',
                **layout_defaults
            ),
    layout.MonadWide(
                name = 'MonadWide',
                **layout_defaults
            ),
    layout.Max(
                name = 'Max',
                **layout_defaults
            ),
    layout.TreeTab(
                name = 'TreeTab',
                active_bg = '#393552',
                active_fg = '#ffffff',
                inactive_bg =  '#2a273f',
#                 border_focus = "#fff243",
                bg_color = '232136',
                padding_x = 6,
                padding_y = 6,
                panel_width = 140,
                vspace = 4,
                margin_left = 24,
                # sections = ["Apps"],
                sections = ["Apps 1", "Apps 2", "Apps 3", "Apps 4", "Apps 5"],
                section_fontsize = 13,
                section_padding = 10,
                section_top = 10,
                section_left = 12,
                section_bottom = 20,
                **layout_defaults
            )
]



###############################################################################
####### GENERATE GROUPBOX #####################################################

if isMultiMonitorMode :
    screenGens = [
        screenGenInfo(groupScreen=1, groups=[
            groupGenInfo(
              spawn=["slack", "discord", "signal-desktop", "telegram-desktop"],
              layout="TreeTab"
            ),
            groupGenInfo(
              spawn=["alacritty"],
              layout="TreeTab"
            ),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(
              spawn=["freetube", "rhythmbox"],
              layout="TreeTab"
            ),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo()
        ]),
        screenGenInfo(groupScreen=2, groups=[
            groupGenInfo(
              spawn=["brave"]
            ),
            groupGenInfo(),
            groupGenInfo(
              spawn=["mailspring"]
            ),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo()
        ]),
        screenGenInfo(groupScreen=3, groups=[
            groupGenInfo(
              spawn=["codium"],
              layout="MonadWide"
            ),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(
              spawn=["notion"]
            ),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo()
        ]),
    ]
else:
    screenGens = [
        screenGenInfo(groupScreen=1, groups=[
            groupGenInfo(
            spawn=["brave"]
            ),
            groupGenInfo(),
            groupGenInfo(
              spawn=["thunderbird"]
            ),
            groupGenInfo(
              spawn=["notion"]
            ),
            groupGenInfo(
              spawn=["freetube", "rhythmbox"],
              layout="TreeTab"
            ),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo(),
            groupGenInfo()
        ])
    ]



###############################################################################
####### CREATE GROUP SETS #####################################################

# Create first set of groups (this ensures the initial groups are placed on the correct monitors)
for screenGen in screenGens:
    group = "{screen}:{group}".format(screen=screenGen.groupScreen, group=1)
    groups.append(Group(
        name=group,
        label="1",
        persist=True,
        spawn=screenGen.groups[0].spawn,
        layout=screenGen.groups[0].layout,
        matches=screenGen.groups[0].matches))

# Create remaining groups
# (the rest of the groups aren't created until they get used, so don't need to be created in any special order)
for screenIndex, screenGen in enumerate(screenGens):
    for groupIndex in range(1, len(screenGen.groups)):
        groupGen = screenGen.groups[groupIndex]
        group = "{screen}:{group}".format(
            screen=screenGen.groupScreen,
            group=groupIndex+1)
        groups.append(Group(
            name=group,
            persist=True,
            label=groupIndex + 1,
            spawn=groupGen.spawn,
            layout=groupGen.layout,
            matches=groupGen.matches))

# Ensure the preferred screen is focused on startup
lazy.function(focus_group, startScreen, "{screen}:{group}".format(screen=screenGens[startScreen].groupScreen, group=1))



###############################################################################
####### KEY BINDINGS ##########################################################

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "j", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "k", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "i", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "j", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "i", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "j", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "k", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "i", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Move focus to next screen
    Key([mod, "mod1"], "j", lazy.prev_screen(), desc="Move focus to the previous screen"),
    Key([mod, "mod1"], "l", lazy.next_screen(), desc="Move focus to the next screen"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Floating windows
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "space", lazy.spawn("rofi -m -4 -show drun"), desc="Launch Rofi"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "mod1"], "q", lazy.spawn("rofi -show power-menu -modi power-menu:rofi-power-menu"), desc="Power menu"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Treetab prompt
    Key([mod, "shift"], "a", add_treetab_section, desc='Prompt to add new section in treetab'),

    Key([mod, "shift"], "k",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down().when(layout=["TreeTab"]),
        desc="Move window down/move down a section in treetab"
    ),
    Key([mod, "shift"], "i",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up().when(layout=["TreeTab"]),
        desc="Move window downup/move up a section in treetab"
    ),



    ## Volume Controls
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pw-volume change +2%')),
    Key([], 'XF86AudioLowerVolume', lazy.spawn('pw-volume change -2%')),
    Key([], 'XF86AudioMute', lazy.spawn('pw-volume mute toggle')),
    Key([], 'XF86AudioPlay', lazy.spawn('playerctl play-pause')),
    Key([], 'XF86AudioRewind', lazy.spawn('playerctl previous')),
    Key([], 'XF86AudioForward', lazy.spawn('playerctl next')),
]

# Create key bindings for group sets
for screenIndex, screenGen in enumerate(screenGens):
    screen = screenIndex
    groupKeys = []

    for groupIndex in range(0, len(screenGen.groups)):
        group = "{screen}:{group}".format(
            screen=screenGen.groupScreen,
            group=groupIndex+1)

        groupKeys.extend([
            Key([], "{group}".format(group=groupIndex+1),
                lazy.function(focus_group, screen, group),
                desc="Switch to group {group}".format(group=group)),

            Key([mod, "shift"], "{group}".format(group=groupIndex+1),
                lazy.window.togroup(group),
                desc="Move focused window to group {group}".format(group=group)),
        ])

    keys.append(KeyChord([mod], "{screen}".format(screen=screenGen.groupScreen), groupKeys))

# Drag floating layouts
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod, "shift"], "Button1", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]



###############################################################################
####### FLOATING RULES ########################################################

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="zoom-us"),
        Match(wm_class="1password"),
    ], **layout_defaults
)



###############################################################################
####### WIDGETS ###############################################################

widget_defaults = dict(
    font="Ubuntu Semibold",
    foreground = "#001018",
    fontsize=12,
    padding=8,
)
extension_defaults = widget_defaults.copy()

if isMultiMonitorMode :
    screens = [
        # Left screen
        Screen(
            top=bar.Bar(
                [
                    widget.Sep(
                              linewidth = 0,
                              padding = 2,
                          ),
                    widget.Image(
                              filename = "~/nixos-config/media/images/svg/nix-logo-white.svg",
                              margin_x = 12,
                              margin_y = 3
                          ),
                    widget.Sep(
                              linewidth = 0
                          ),
                    widget.GroupBox(
                              visible_groups=["1:1", "1:2", "1:3", "1:4", "1:5", "1:6", "1:7", "1:8", "1:9"],
                              inactive = "#ffffff",
                              active = "#fff243",
                              font = "Ubuntu Bold",
                              highlight_method = "block",
                              this_current_screen_border = colors['bar-lighter'],
                              this_screen_border = colors['bar-lighter'],
                              rounded = False,
                              borderwidth = 0,
                              padding_x = 12,
                              padding_y = 7,
                              margin = 2,
                          ),
                    widget.Sep(
                            linewidth = 0,
                            padding = 10
                          ),
                    widget.CurrentLayoutIcon(
                              scale = 0.8,
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 10
                          ),
                    widget.CurrentLayout(
                              foreground = colors['foreground'],
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 18
                          ),
                    widget.TextBox(
                              text="󰄾",
                              fontsize = 20,
                              foreground = "#ffffff",
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding =  10
                          ),
                    widget.WindowName(
                              parse_text=longNameParse,
                              font = "Ubuntu Semibold",
                              foreground = "#ffffff"
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6
                          )
                ],
                bar_height,
                background = colors['bar'],
                border_color = colors['bar-border'],
                border_width = bar_border,
                opacity = bar_opacity,
                margin = bar_margin
            ),
            left=bar.Gap(gap_size),
            right=bar.Gap(gap_size),
            bottom=bar.Gap(gap_size),
            wallpaper='~/wallpapers/lamp-macro.jpg'
        ),
        # Center screen
        Screen(
            top=bar.Bar(
                [
                    widget.Sep(
                              linewidth = 0,
                              padding = 2,
                          ),
                    widget.Image(
                              filename = "~/nixos-config/media/images/svg/nix-logo-white.svg",
                              margin_x = 12,
                              margin_y = 3
                          ),
                    widget.Sep(
                              linewidth = 0
                          ),
                    widget.GroupBox(
                              visible_groups=["2:1", "2:2", "2:3", "2:4", "2:5", "2:6", "2:7", "2:8", "2:9"],
                              inactive = "#ffffff",
                              active = "#fff243",
                              font = "Ubuntu Bold",
                              highlight_method = "block",
                              this_current_screen_border = colors['bar-lighter'],
                              this_screen_border = colors['bar-lighter'],
                              rounded = False,
                              borderwidth = 0,
                              padding_x = 12,
                              padding_y = 7,
                              margin = 2,
#                               background = "#03344d"
                          ),
                   widget.Sep(
                           linewidth = 0,
                           padding = 10
                         ),
                   widget.CurrentLayoutIcon(
                             scale = 0.8,
                             padding = 0
                         ),
                   widget.Sep(
                             linewidth = 0,
                             padding = 10
                         ),
                   widget.CurrentLayout(
                             foreground = colors['foreground'],
                             padding = 0
                         ),
                   widget.Sep(
                             linewidth = 0,
                             padding = 18
                         ),
                   widget.TextBox(
                             text="󰄾",
                             fontsize = 20,
                             foreground = "#ffffff",
                             padding = 0
                         ),
                   widget.Sep(
                             linewidth = 0,
                             padding =  10
                         ),
                    widget.WindowName(
                              parse_text=longNameParse,
                              font = "Ubuntu Semibold",
                              foreground = "#ffffff"
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6
                          ),
                    widget.Systray(
                              icon_size = 20,
                              fontsize = 16,
                              background = colors['bar-light']
                          ),
                    widget.OpenWeather(
                              fontsize = 16,
                              location = 'Leek',
                              format='{icon}',
                              foreground = colors['foreground'],
                              background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 10,
                              background = colors['bar-light']
                          ),
#                     widget.Image(
#                               filename = "~/nixos-config/assets/speaker.svg",
#                               margin_y = 3,
#                               background = "#96CDFB"
#                           ),
                    widget.TextBox(
                              text="",
                              fontsize = 20,
                              foreground = colors['blue'],
                              padding = 0,
                              background = colors['bar-light']
                          ),
                    widget.Volume(
                              padding = 6,
                              foreground = colors['foreground'],
                              background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6,
                              background = colors['bar-light']
                          ),
#                     widget.Image(
#                               filename = "~/nixos-config/assets/battery.svg",
#                               margin_y = 4,
#                               margin_x = 4,
#                               background = "#ABE9B3"
#                           ),
                    widget.TextBox(
                              text="󱊣",
                              fontsize = 20,
                              padding = 4,
                              foreground = colors['green'],
                              background = colors['bar-light']
                          ),
                    widget.Battery(
                              format = "{percent:2.0%}",
                              padding = 0,
                              foreground = colors['foreground'],
                              background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6,
                              background = colors['bar-light']
                          ),
#                     widget.Sep(
#                               linewidth = 0,
#                               padding = 6,
#                           ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6,
                              background = colors['bar-light']
                          ),
#                     widget.Image(
#                               filename = "~/nixos-config/assets/keyboard.svg",
#                               margin_y = 1,
#                               background = "#FAE3B0"
#                           ),
                    widget.TextBox(
                              text="󰌌",
                              fontsize = 20,
                              padding = 4,
                              foreground = colors['yellow'],
                              background = colors['bar-light']
                          ),
                    widget.KeyboardLayout(
                              configured_keyboards = ['pl', 'gb', 'us'],
                              foreground = colors['foreground'],
                              background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 8,
#                               background = colors['bar-light']
                          ),
                    widget.TextBox(
                              text="",
                              fontsize = 16,
                              padding = 6,
                              foreground = colors['pink'],
#                               background = colors['bar-light']
                          ),
                    widget.Clock(
                              format = "%a %d %b",
                              foreground = colors['foreground'],
#                               background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 0,
#                               background = colors['bar-light']
                          ),
                    widget.TextBox(
                              text="󱑎",
                              fontsize = 20,
                              padding = 5,
                              foreground = colors['orange'],
#                               background = colors['bar-light']
                          ),
                    widget.Clock(
                              format = "%I:%M %p",
                              foreground = colors['foreground'],
                              margin = 0,
#                               background = colors['bar-light']
                          ),
#                     widget.Clock(
#                               format = "%I:%M %p\n<small>%a %d %b</small>",
#                               foreground = colors['foreground'],
#                               fontsize = 12,
#                               margin = 0
# #                               background = colors['bar-light']
#                           ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 4
                          ),
                    widget.Image(
                              filename = "~/nixos-config/media/images/svg/switch-white.svg",
                              margin_y = 2,
                              mouse_callbacks = {
                                  'Button1': lambda: qtile.cmd_spawn(
                                      "rofi -show power-menu -modi power-menu:rofi-power-menu"
                                  )
                              }
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 8
                          ),
                ],
                bar_height,
                background = colors['bar'],
                border_color = colors['bar-border'],
                border_width = bar_border,
                opacity = bar_opacity,
                margin = bar_margin
            ),
            left=bar.Gap(gap_size),
            right=bar.Gap(gap_size),
            bottom=bar.Gap(gap_size),
            wallpaper='~/wallpapers/lamp-macro.jpg'
        ),
        # Right screen
        Screen(
            top=bar.Bar(
                [
                    widget.Sep(
                              linewidth = 0,
                              padding = 2,
                          ),
                    widget.Image(
                              filename = "~/nixos-config/media/images/svg/nix-logo-white.svg",
                              margin_x = 12,
                              margin_y = 3
                          ),
                    widget.Sep(
                              linewidth = 0
                          ),
                    widget.GroupBox(
                              visible_groups=["3:1", "3:2", "3:3", "3:4", "3:5", "3:6", "3:7", "3:8", "3:9"],
                              inactive = "#ffffff",
                              active = "#fff243",
                              font = "Ubuntu Bold",
                              highlight_method = "block",
                              this_current_screen_border = colors['bar-lighter'],
                              this_screen_border = colors['bar-lighter'],
                              rounded = False,
                              borderwidth = 0,
                              padding_x = 12,
                              padding_y = 7,
                              margin = 2,
#                               background = "#03344d"
                          ),
                    widget.Sep(
                            linewidth = 0,
                            padding = 10
                          ),
                    widget.CurrentLayoutIcon(
                              scale = 0.8,
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 10
                          ),
                    widget.CurrentLayout(
                              foreground = colors['foreground'],
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 18
                          ),
                    widget.TextBox(
                              text="󰄾",
                              fontsize = 20,
                              foreground = "#ffffff",
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding =  10
                          ),
                    widget.WindowName(
                              parse_text=longNameParse,
                              font = "Ubuntu Semibold",
                              foreground = "#ffffff"
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6
                          )
                ],
                bar_height,
                background = colors['bar'],
                border_color = colors['bar-border'],
                border_width = bar_border,
                opacity = bar_opacity,
                margin = bar_margin
            ),
            left=bar.Gap(gap_size),
            right=bar.Gap(gap_size),
            bottom=bar.Gap(gap_size),
            wallpaper='~/wallpapers/lamp-macro.jpg'
        )
    ]
else :
    screens = [
        # Laptop screen
        Screen(
            top=bar.Bar(
                [
                    widget.Sep(
                              linewidth = 0,
                              padding = 2,
                          ),
                    widget.Image(
                              filename = "~/nixos-config/media/images/svg/nix-logo-white.svg",
                              margin_x = 12,
                              margin_y = 3
                          ),
                    widget.Sep(
                              linewidth = 0
                          ),
                    widget.GroupBox(
                              inactive = "#ffffff",
                              active = "#fff243",
                              font = "Ubuntu Bold",
                              highlight_method = "block",
                              this_current_screen_border = colors['bar-lighter'],
                              this_screen_border = colors['bar-lighter'],
                              rounded = False,
                              borderwidth = 0,
                              padding_x = 12,
                              padding_y = 7,
                              margin = 2,
#                               background = "#03344d"
                          ),
                    widget.Sep(
                            linewidth = 0,
                            padding = 10
                          ),
                    widget.CurrentLayoutIcon(
                              scale = 0.8,
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 10
                          ),
                    widget.CurrentLayout(
                              foreground = colors['foreground'],
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 18
                          ),
                    widget.TextBox(
                              text="󰄾",
                              fontsize = 20,
                              foreground = "#ffffff",
                              padding = 0
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding =  10
                          ),
                    widget.WindowName(
                              parse_text=longNameParse,
                              font = "Ubuntu Semibold",
                              foreground = "#ffffff"
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6
                          ),
                    widget.Systray(
                              icon_size = 20,
                              fontsize = 16,
                              background = colors['bar-light']
                          ),
                    widget.OpenWeather(
                              fontsize = 16,
                              location = 'Leek',
                              format='{icon}',
                              foreground = colors['foreground'],
                              background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 10,
                              background = colors['bar-light']
                          ),
#                     widget.Image(
#                               filename = "~/nixos-config/assets/speaker.svg",
#                               margin_y = 3,
#                               background = "#96CDFB"
#                           ),
                    widget.TextBox(
                              text="",
                              fontsize = 20,
                              foreground = colors['blue'],
                              padding = 0,
                              background = colors['bar-light']
                          ),
                    widget.Volume(
                              padding = 6,
                              foreground = colors['foreground'],
                              background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6,
                              background = colors['bar-light']
                          ),
#                     widget.Image(
#                               filename = "~/nixos-config/assets/battery.svg",
#                               margin_y = 4,
#                               margin_x = 4,
#                               background = "#ABE9B3"
#                           ),
                    widget.TextBox(
                              text="󱊣",
                              fontsize = 20,
                              padding = 4,
                              foreground = colors['green'],
                              background = colors['bar-light']
                          ),
                    widget.Battery(
                              format = "{percent:2.0%}",
                              padding = 0,
                              foreground = colors['foreground'],
                              background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6,
                              background = colors['bar-light']
                          ),
#                     widget.Sep(
#                               linewidth = 0,
#                               padding = 6,
#                           ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 6,
                              background = colors['bar-light']
                          ),
#                     widget.Image(
#                               filename = "~/nixos-config/assets/keyboard.svg",
#                               margin_y = 1,
#                               background = "#FAE3B0"
#                           ),
                    widget.TextBox(
                              text="󰌌",
                              fontsize = 20,
                              padding = 4,
                              foreground = colors['yellow'],
                              background = colors['bar-light']
                          ),
                    widget.KeyboardLayout(
                              configured_keyboards = ['pl', 'gb', 'us'],
                              foreground = colors['foreground'],
                              background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 8,
#                               background = colors['bar-light']
                          ),
                    widget.TextBox(
                              text="",
                              fontsize = 16,
                              padding = 6,
                              foreground = colors['pink'],
#                               background = colors['bar-light']
                          ),
                    widget.Clock(
                              format = "%a %d %b",
                              foreground = colors['foreground'],
#                               background = colors['bar-light']
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 0,
#                               background = colors['bar-light']
                          ),
                    widget.TextBox(
                              text="󱑎",
                              fontsize = 20,
                              padding = 5,
                              foreground = colors['orange'],
#                               background = colors['bar-light']
                          ),
                    widget.Clock(
                              format = "%I:%M %p",
                              foreground = colors['foreground'],
                              margin = 0,
#                               background = colors['bar-light']
                          ),
#                     widget.Clock(
#                               format = "%I:%M %p\n<small>%a %d %b</small>",
#                               foreground = colors['foreground'],
#                               fontsize = 12,
#                               margin = 0
# #                               background = colors['bar-light']
#                           ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 4
                          ),
                    widget.Image(
                              filename = "~/nixos-config/assets/switch-white.svg",
                              margin_y = 2,
#                               mouse_callbacks = {
#                                   'Button1': show_power_menu(qtile)
#                               }
                          ),
                    widget.Sep(
                              linewidth = 0,
                              padding = 8
                          ),
                ],
                bar_height,
                background = colors['bar'],
                border_color = colors['bar'],
                border_width = bar_border,
                opacity = bar_opacity,
                margin = bar_margin
            ),
            left=bar.Gap(gap_size),
            right=bar.Gap(gap_size),
            bottom=bar.Gap(gap_size)
        ),
    ]



###############################################################################
####### MOUSE CALLBACKS #######################################################

def show_power_menu(qtile):
    controls = [
        PopupImage(
            filename="/home/moonlander/nixos-config/assets/lock2.svg",
            pos_x=0.15,
            pos_y=0.1,
            width=0.1,
            height=0.5,
            mouse_callbacks={
                "Button1": lazy.spawn("/path/to/lock_cmd")
            }
        ),
        PopupImage(
            filename="/home/moonlander/nixos-config/assets/sleep.svg",
            pos_x=0.45,
            pos_y=0.1,
            width=0.1,
            height=0.5,
            mouse_callbacks={
                "Button1": lazy.spawn("/path/to/sleep_cmd")
            }
        ),
        PopupImage(
            filename="/home/moonlander/nixos-config/assets/turn-off.svg",
            pos_x=0.75,
            pos_y=0.1,
            width=0.1,
            height=0.5,
            highlight="A00000",
            mouse_callbacks={
                "Button1": lazy.shutdown()
            }
        ),
        PopupText(
            text="Lock",
            pos_x=0.1,
            pos_y=0.7,
            width=0.2,
            height=0.2,
            h_align="center"
        ),
        PopupText(
            text="Sleep",
            pos_x=0.4,
            pos_y=0.7,
            width=0.2,
            height=0.2,
            h_align="center"
        ),
        PopupText(
            text="Shutdown",
            pos_x=0.7,
            pos_y=0.7,
            width=0.2,
            height=0.2,
            h_align="center"
        ),
    ]

    layout = PopupRelativeLayout(
        qtile,
        width=700,
        height=200,
        controls=controls,
        background="00000060",
        initial_focus=None,
        close_on_click = True
    )

#     layout.show(centered=False)



###############################################################################
####### QTILE SETTING #########################################################

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floats_kept_above = True

dgroups_key_binder = None
dgroups_app_rules = []  # type: list

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None



###############################################################################
####### MISC ##################################################################

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
wmctrl = "LG3D"



####### END ###################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
