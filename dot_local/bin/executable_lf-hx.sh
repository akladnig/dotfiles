#!/usr/bin/env sh

fpath="$1"

# Get the current tab id
tab_id=$(wezterm cli list | awk -v pane_id="$WEZTERM_PANE" '$3==pane_id { print $2 }')
# Get the pane id for the explorer pane
explorer_id=$(wezterm cli list | awk -v tab_id="$tab_id" '$2==tab_id && $6=="lf" { print $3 }')
 # Then get the pane id for the helix instance if it exists
hx_pane_id=$(wezterm cli list | awk -v tab_id="$tab_id" '$2==tab_id && $6=="hx2" { print $3 }')

# if the helix pane does not exist then create it and a terminal pane
if [ -z "${hx_pane_id}" ]; then
  hx_pane_id=$(wezterm cli split-pane --right --cells 150)
  wezterm cli split-pane --pane-id $hx_pane_id --bottom --cells 15
fi

program=$(wezterm cli list | awk -v hx_pane_id="$hx_pane_id" '$3==hx_pane_id { print $6 }')
if [ "$program" = "hx2" ]; then
  echo ":open ${fpath}\r" | wezterm cli send-text --pane-id $hx_pane_id --no-paste
else
  echo "hx2 ${fpath}" | wezterm cli send-text --pane-id $hx_pane_id --no-paste
fi

# Update lf to show just 2x panes and navigate to parent directory

# wezterm cli send-text ":set ratios 1:2\n" --pane-id $explorer_id --no-paste
lf -remote "send $id set ratios 1:2"
lf -remote "send $id set drawbox false"
# lf -remote "send $id updir"
lf -remote "send $id set preview false"

wezterm cli activate-pane --pane-id $hx_pane_id