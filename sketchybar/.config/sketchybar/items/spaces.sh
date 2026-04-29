sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all)
do
    sketchybar --add item space.$sid left                              \
        --subscribe space.$sid aerospace_workspace_change              \
        --set space.$sid icon=$sid                                     \
                         icon.padding_left=8                           \
                         icon.padding_right=8                          \
                         background.padding_left=5                     \
                         background.padding_right=5                    \
                         background.color=0x44ffffff                   \
                         background.corner_radius=5                    \
                         background.height=22                          \
                         background.drawing=off                        \
                         label.drawing=off                             \
                         script="$PLUGIN_DIR/space.sh $sid"            \
                         click_script="aerospace workspace $sid"       \
                         icon.font="$FONT:Bold:15.0"
done
