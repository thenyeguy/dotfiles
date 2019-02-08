set -g status on
set -g status-interval 1
set -g status-justify "left"

set -g status-bg "colour239"
set -g status-fg "colour241"

set -g message-bg "colour239"
set -g message-fg "colour250"

set -g pane-border-style "fg=colour239"
set -g pane-active-border-style "fg=colour252"

set -g status-left-length "100"
set -g status-left "#[fg=colour235,bg=colour252] #S #[fg=colour252,bg=colour239]"

set -g window-status-separator ""
set -g window-status-format "#[fg=colour249,bg=colour239] [#I] #W "
set -g window-status-current-format "#[fg=colour239,bg=colour241]#[fg=colour252,bg=colour241,bold] [#I] #W #[fg=colour241,bg=colour239]"

set -g status-right-length "200"
set -g status-right "#(~/.dotfiles/tmux/battery-life.sh) #[fg=colour241,bg=colour239]#[fg=colour252,bg=colour241] %l:%M %p #[fg=colour252]#[fg=colour252] %m/%d/%Y #[fg=colour252,bg=colour241]#[fg=colour235,bg=colour252] $USER@#h "
