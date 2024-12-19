#!/bin/zsh

SCREENSHOTS_FOLDER="${HOME}/Screenshots"

# f.lux
defaults write org.herf.Flux dayColorTemp -int 5500
defaults write org.herf.Flux lateColorTemp -int 1600
defaults write org.herf.Flux nightColorTemp -int 2700

# rocket
defaults write net.matthewpalmer.Rocket "deactivated-apps" -array Slack Xcode Terminal "Sublime Text" "Sublime Text 2" Discord WezTerm Obsidian Code
defaults write net.matthewpalmer.Rocket "launch-at-login" -bool true

# stats
defaults write eu.exelban.Stats runAtLoginInitialized -bool true
defaults write eu.exelban.Stats setupProcess -bool true
defaults write eu.exelban.Stats update-interval -string "At start"
defaults write eu.exelban.Stats version -string "2.11.21"

defaults write eu.exelban.Stats "Battery_state" -bool true
defaults write eu.exelban.Stats "Battery_battery_color" -bool true
defaults write eu.exelban.Stats "Battery_oneView" -bool true
defaults write eu.exelban.Stats "Battery_widget" -string "mini,battery"

defaults write eu.exelban.Stats "Network_state" -bool true
defaults write eu.exelban.Stats "CPU_state" -bool false
defaults write eu.exelban.Stats "Disk_state" -bool false
defaults write eu.exelban.Stats "RAM_state" -bool false

# jordanbaird/Ice i cannot figure out how to set defaults for the config, so do that yourself

# mos
defaults write com.caldis.Mos smooth -bool true
defaults write com.caldis.Mos speed -int 1
defaults write com.caldis.Mos duration -int 1

# clock
defaults write com.apple.menuextra.clock ShowAMPM -int 1
defaults write com.apple.menuextra.clock ShowDayOfWeek -int 1

# finder
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# "are you sure you want to open this?"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock "autohide-delay" -int 0
defaults write com.apple.dock "autohide-time-modifier" -float 0.1
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock tilesize -int 64
defaults write com.apple.dock show-recents -bool false

defaults write NSGlobalDomain _HIHideMenuBar -bool true

# keyboard
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# mouse
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# screenshots
mkdir -p "${SCREENSHOTS_FOLDER}"
defaults write com.apple.screencapture location -string "${SCREENSHOTS_FOLDER}"
defaults write com.apple.screencapture type -string "png"

# software update
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# arc
defaults write company.thebrowser.Browser AppleEnableSwipeNavigateWithScrolls -bool false


for app in "Dock" "Finder" "SystemUIServer"; do
  killall "${app}" &> /dev/null
done
