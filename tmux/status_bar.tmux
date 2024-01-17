# Borders:
set -g pane-border-style "bg=default,fg=brightblack"
set -g pane-active-border-style "bg=default,fg=blue"

# Messages:
set -g message-style "bg=brightblack,fg=cyan"
set -g message-command-style "bg=brightblack,fg=cyan"

# Status bar:
set -g status-position top
set -g status-style "bg=black,fg=white"

set -g status-right-length 20
set -g status-left "#[fg=black,bg=blue,bold] #S #[fg=blue,bg=black]"

set -g window-status-bell-style ""
set -g window-status-separator ""
set -g window-status-format "#[fg=black,bg=brightblack] #[fg=white,bg=brightblack]#I  #W #(~/.dotfiles/tmux/window_flags.sh '#{window_flags}')#[fg=brightblack,bg=black]"
set -g window-status-current-format "#[fg=black,bg=cyan] #[fg=black,bg=cyan,bold]#I  #W #(~/.dotfiles/tmux/window_flags.sh '#{window_flags}')#[fg=cyan,bg=black]"

set -g status-right-length 80
set -g status-right "#[fg=brightblack,bg=black]#[fg=white,bg=brightblack] %l:%M %p  %m/%d/%Y #[fg=blue,bg=brightblack]#[fg=black,bg=blue,bold] #H #(~/.dotfiles/tmux/ssh.sh)"
