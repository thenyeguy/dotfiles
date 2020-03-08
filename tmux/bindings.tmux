# Start clean
unbind -a

# Set prefix to C-a
set -g prefix C-a
bind C-a send-prefix

# Rebind basic commands
bind : command-prompt
bind ^d detach-client
bind D detach-client -a
bind ^v copy-mode
bind -r \{ swap-pane -U
bind -r \} swap-pane -D

# Configure pane navigation with vim-like motions.
bind -T root -r ^j run-shell "~/.dotfiles/tmux/navigate.sh j"
bind -T root -r ^k run-shell "~/.dotfiles/tmux/navigate.sh k"
bind -T root -r ^h run-shell "~/.dotfiles/tmux/navigate.sh h"
bind -T root -r ^l run-shell "~/.dotfiles/tmux/navigate.sh l"
bind -r H resize-pane -L
bind -r J resize-pane -D
bind -r K resize-pane -U
bind -r L resize-pane -R

# Configure quick switch to windows.
bind 1 select-window -t 1
bind 2 select-window -t 2
bind 3 select-window -t 3
bind 4 select-window -t 4
bind 5 select-window -t 5
bind 6 select-window -t 6
bind 7 select-window -t 7
bind 8 select-window -t 8
bind 9 select-window -t 9
bind 0 select-window -t 10

# Enter search without entering copy mode
bind / command-prompt -p "(search up)" "copy-mode; send -X search-backward \"%%%\""
bind -T copy-mode-vi / command-prompt -p "(search up)" "copy-mode; send -X search-backward \"%%%\""

# Vim-like selection/copy
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe "clipboard copy"

# Pane splitting
bind -r ^s run-shell "~/.dotfiles/tmux/layout.py split"
bind -r - run-shell "~/.dotfiles/tmux/layout.py split -v"
bind -r | run-shell "~/.dotfiles/tmux/layout.py split -h"

# Pane zooming
bind -r ^z resize-pane -Z

# Pane rebalancing
bind ^b run-shell "~/.dotfiles/tmux/layout.py resize"

# Window navigation
bind -r ^p previous-window
bind -r ^n next-window
bind -r P swap-window -d -t -1
bind -r N swap-window -d -t +1

# Ask for name on new window
bind ^c command-prompt -p "new window:" "new-window -n '%%' -a"

# Rename window
bind ^r command-prompt -p "window name:" "rename-window '%%'"

# Reloading macro
bind R source-file ~/.tmux.conf \; display "Reloaded!"

# Rebind mouse
bind -n MouseDown1Pane select-pane -t=\; send-keys -M
bind -n MouseDrag1Pane if -Ft= '#{mouse_any_flag}' 'send-keys -M' 'copy-mode -M'
bind -n WheelUpPane if-shell -Ft= '#{?pane_in_mode,1,#{mouse_any_flag}}' \
        'send -Mt=' \
        'if-shell -Ft= "#{alternate_on}" "send -t= Up" "copy-mode -et="'
bind -n WheelDownPane if-shell -Ft = '#{?pane_in_mode,1,#{mouse_any_flag}}' \
        'send -Mt=' 'if-shell -Ft= "#{alternate_on}" \
        "send -t= Down" "send -Mt="'
bind -n MouseDrag1Border resize-pane -M
bind -n MouseDown1Status select-window -t=
bind -n WheelUpStatus previous-window
bind -n WheelDownStatus next-window
