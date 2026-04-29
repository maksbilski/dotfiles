#!/usr/bin/env sh

osascript <<'EOF'
tell application "System Events"
    tell (first process whose frontmost is true)
        try
            click menu bar item 1 of menu bar 1
        end try
    end tell
end tell
EOF
