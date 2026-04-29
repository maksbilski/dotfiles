sketchybar --add item battery right                      \
           --set battery script="$PLUGIN_DIR/battery.sh" \
                         update_freq=10                  \
                         icon.font="$FONT:Bold:15.0"     \
                         label.font="$FONT:Semibold:15.0" \
           --subscribe battery system_woke
