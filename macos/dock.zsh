#!/bin/zsh

# =============================================================================
# macOS Dock Configuration
# =============================================================================

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Zen.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/Ghostty.app"
dockutil --no-restart --add "/Applications/Cursor.app"
dockutil --no-restart --add "/Applications/Discord.app"
dockutil --no-restart --add '~/Downloads' --view grid --display folder --allhomes

killall Dock
