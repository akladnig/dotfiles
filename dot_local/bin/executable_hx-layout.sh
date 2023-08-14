#!/usr/bin/env sh

# get the current pane id.
hx_pane=$(wezterm cli activate-pane)
lf_pane=$(wezterm cli split-pane --left --cells 60)
echo "lf -config ~/.config/lf/lfhxrc" | wezterm cli send-text --pane-id $lf_pane --no-paste
t_pane=$(wezterm cli split-pane --bottom --cells 1)
wezterm cli activate-pane-direction up
echo "hx ." | wezterm cli send-text --no-paste
wezterm cli activate-pane-direction left

