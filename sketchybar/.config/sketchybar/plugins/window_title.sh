#!/usr/bin/env sh

APP=$(aerospace list-windows --focused 2>/dev/null | awk -F' *\\| *' 'NR==1 {print $2}')
sketchybar --set "$NAME" label="${APP:-}"
