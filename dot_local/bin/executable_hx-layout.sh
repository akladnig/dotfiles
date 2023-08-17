#!/usr/bin/env sh

fpath="$1"

# Get the pane id
hx_pane=$WEZTERM_PANE
echo "hx pane"
  echo $hx_pane
explorer_pane=$(wezterm cli split-pane --left --cells 1)
echo "lf -config ~/.config/lf/lfhxrc" | wezterm cli send-text --pane-id $explorer_pane --no-paste
terminal_pane=$(wezterm cli split-pane --bottom --cells 1)

# open the file in helix or open the explorer
if [ -z "${fpath}" ]; then
  echo "hx" | wezterm cli send-text --pane-id $hx_pane --no-paste
  wezterm cli adjust-pane-size --pane-id $explorer_pane --amount 60 Right
  wezterm cli activate-pane --pane-id $explorer_pane
else
  echo "hx ${fpath}" | wezterm cli send-text --pane-id $hx_pane --no-paste
  wezterm cli activate-pane --pane-id $hx_pane
fi
