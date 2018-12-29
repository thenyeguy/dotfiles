set -g status on
set -g status-interval 1
set -g status-justify "left"

set -g status-bg "colour24"
set -g status-fg "colour31"

set -g message-bg "colour24"
set -g message-fg "colour117"
set -g message-command-fg "colour24"
set -g message-command-bg "colour117"

set -g pane-border-fg "colour24"
set -g pane-active-border-fg "colour231"

set -g status-left-length "100"
set -g status-left "#[fg=colour23,bg=colour231] #S #[fg=colour231,bg=colour24]"

set -g window-status-separator ""
set -g window-status-format "#[fg=colour81,bg=colour24] [#I] #W "
set -g window-status-current-format "#[fg=colour24,bg=colour31]#[fg=colour153,bg=colour31] [#I] #W #[fg=colour31,bg=colour24]"

set -g status-right-length "200"
set -g status-right "#(~/.dotfiles/tmux/tmux-prompts.sh) #[fg=colour31,bg=colour24]#[fg=colour153,bg=colour31] %l:%M %p #[fg=colour81]#[fg=colour153] %m/%d/%Y #[fg=colour231,bg=colour31]#[fg=colour23,bg=colour231] $USER@#h "
