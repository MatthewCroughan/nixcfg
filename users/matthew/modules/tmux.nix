{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    terminal = "screen-256color";
    sensibleOnTop = false;
    secureSocket = false;

    extraConfig = ''
      # {{{ general
      set -ga terminal-overrides ",*256col*:Tc"
      set -g default-shell /run/current-system/sw/bin/fish
      set -s escape-time 0
      set -sg repeat-time 600
      set -s focus-events on
      set -g mode-keys vi
      set-option -g history-limit 50000
      set -g prefix2 C-a
      bind C-a send-prefix -2
      # bind -n End send-key C-e
      # bind -n Home send-key C-a
      # clear both screen and history
      bind -n C-l send-keys C-l \; run 'sleep 0.1' \; clear-history
      # edit configuration
      bind e new-window -n '~/.tmux.conf' "sh -c 'nvim -u ~/.config/nvim/init.vim ~/.tmux.conf && tmux source ~/.tmux.conf && tmux display \"~/.tmux.conf sourced\"'"
      # reload configuration
      bind r source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'
      # Allows us to use C-a a <command> to send commands to a TMUX session inside
      # another TMUX session
      bind-key a send-prefix
      # start with mouse mode disabled
      set -g mouse on
      # }}}
      # {{{ display
      setw -g automatic-rename on # rename window to reflect current program
      set -g renumber-windows on  # renumber windows when a window is closed
      set -g set-titles on                        # set terminal title
      set -g set-titles-string '#h — #S — #I #W'
      set -g display-panes-time 800 # slightly longer pane indicators display time
      set -g display-time 1000      # slightly longer status messages display time
      set -g status-interval 1     # redraw status line every 1 seconds
      set -g status-left-length 20
      set -g status-right ""
      set -g status-right-length 0
      # Activity monitoring
      setw -g monitor-activity off
      set -g visual-activity off
      # }}}
      # {{{ navigation
      # create session
      bind C-c new-session
      # find session
      bind C-f command-prompt -p find-session 'switch-client -t %%'
      # Swap window with last used
      bind-key S-Left swap-window -t -1
      bind-key S-Right swap-window -t +1
      # pane navigation
      bind > swap-pane -D    # swap current pane with the next one
      bind < swap-pane -U    # swap current pane with the previous one
      bind-key Up    select-pane -U
      bind-key Down  select-pane -D
      bind-key Left  select-pane -L
      bind-key Right select-pane -R
      # pane resizing
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2
      # window navigation
      unbind n
      unbind p
      bind C-h previous-window # select previous window
      bind C-l next-window     # select next window
      bind Tab last-window     # move to last active window
      # }}}
      # {{{ misc
      # status bar
      # fix pane_current_path on new window and splits
      bind c new-window -c '#{pane_current_path}'
      bind b split-window -v -c '#{pane_current_path}'
      bind v split-window -h -c '#{pane_current_path}'
      bind % split-window -h -c '#{pane_current_path}'
      # }}}
      ## base16 dracula
      # default statusbar colors
      set-option -g status-style "fg=#62d6e8,bg=#3a3c4e"
      # default window title colors
      set-window-option -g window-status-style "fg=#62d6e8,bg=default"
      # active window title colors
      set-window-option -g window-status-current-style "fg=#00f769,bg=default"
      # pane border
      set-option -g pane-border-style "fg=#3a3c4e"
      set-option -g pane-active-border-style "fg=#4d4f68"
      # message text
      set-option -g message-style "fg=#e9e9f4,bg=#3a3c4e"
      # pane number display
      set-option -g display-panes-active-colour "#ebff87"
      set-option -g display-panes-colour "#00f769"
      # clock
      set-window-option -g clock-mode-colour "#ebff87"
      # copy mode highlight
      set-window-option -g mode-style "fg=#62d6e8,bg=#4d4f68"
      # bell
      set-window-option -g window-status-bell-style "fg=#3a3c4e,bg=#ea51b2"
    '';
  };
}
