{
  services.skhd = {
    enable = true;
    skhdConfig = ''
alt - h : yabai -m window --focus west
# focus window
alt - j : yabai -m window --focus south
alt - k : yabai -m window --focus north
alt - l : yabai -m window --focus east

# swap managed window
shift + alt - h : yabai -m window --swap west
shift + alt - j : yabai -m window --swap south
shift + alt - k : yabai -m window --swap north
shift + alt - l : yabai -m window --swap east

shift + alt - m : yabai -m window --swap mouse

# move managed window
shift + alt + ctrl - h : yabai -m window --warp west
shift + alt + ctrl - j : yabai -m window --warp south
shift + alt + ctrl - k : yabai -m window --warp north
shift + alt + ctrl - l : yabai -m window --warp east

# rotate tree
alt - r : yabai -m space --rotate 90

# toggle window fullscreen zoom
alt - f : yabai -m window --toggle zoom-fullscreen

# alt - s : yabai -m window --toggle 
alt - s : yabai -m window --toggle sticky;\
          yabai -m window --toggle topmost;\
          yabai -m window --toggle pip

# toggle padding and gap
alt - g : yabai -m space --toggle padding; yabai -m space --toggle gap

# float / unfloat window and center on screen
alt - t : yabai -m window --toggle float;\
          yabai -m window --grid 4:4:1:1:2:2

# toggle window split type
alt - e : yabai -m window --toggle split

# balance size of windows
# shift + alt - 0 : yabai -m space --balance

# move window and focus desktop
shift + alt - 1 : yabai -m window --space 1
shift + alt - 2 : yabai -m window --space 2
shift + alt - 3 : yabai -m window --space 3
shift + alt - 4 : yabai -m window --space 4
shift + alt - 5 : yabai -m window --space 5
shift + alt - 6 : yabai -m window --space 6
shift + alt - 7 : yabai -m window --space 7
shift + alt - 8 : yabai -m window --space 8
shift + alt - 9 : yabai -m window --space 9
shift + alt - 0 : yabai -m window --space 10

# move window and focus desktop
alt - 1 : yabai -m space --focus 1
alt - 2 : yabai -m space --focus 2
alt - 3 : yabai -m space --focus 3
alt - 4 : yabai -m space --focus 4
alt - 5 : yabai -m space --focus 5
alt - 6 : yabai -m space --focus 6
alt - 7 : yabai -m space --focus 7
alt - 8 : yabai -m space --focus 8
alt - 9 : yabai -m space --focus 9
alt - 0 : yabai -m space --focus 10
# alt - m : yabai -m space --focus 10
alt - v : yabai -m space --focus 11
shift + alt - v : yabai -m space --focus 12

alt - y : /Users/viktornagy/Clones/subtube/subtube play
shift + alt - y : /Users/viktornagy/Clones/subtube/subtube update

# fast focus desktop
alt - tab : yabai -m space --focus recent
alt - q : yabai -m space --focus recent

# send window to monitor and follow focus
shift + alt - n : yabai -m window --display next; yabai -m display --focus next
shift + alt - p : yabai -m window --display previous; yabai -m display --focus previous
shift + alt - p : yabai -m window --display previous; yabai -m display --focus previous

# alacritty
alt - return : open -n -a 'Alacritty.app'

# tmux controller
shift + alt - e : /Users/viktornagy/.scripts/tmux_controller
    '';
  };
}
