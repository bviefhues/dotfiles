# System Preferences 

## General 
### Dark mode
defaults write -g NSRequiresAquaSystemAppearance -bool false
### Highlight color
defaults write AppleHighlightColor -string "1.000000 0.874510 0.701961 Orange"
### Always show scrollbars, Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"
### Click in the scrollbar to: Jump to the spot that's clicked
defaults write -globalDomain AppleScrollerPagingBehavior -bool false
### Sidebar icon size: Medium
defaults write -globalDomain NSTableViewDefaultSizeMode -int 2
### Close windows when quitting a program
defaults write -globalDomain NSQuitAlwaysKeepsWindows -int 0

## Desktop & Screen Saver
### Start after
defaults -currentHost write com.apple.screensaver idleTime -int 300

## Dock
### Size
defaults write com.apple.dock tilesize -int 44
### Magnification
defaults write com.apple.dock magnification -bool false
### Size (magnified):
defaults write com.apple.dock largesize -int 44
### Minimize windows using: Scale effect
defaults write com.apple.dock mineffect -string "scale"
### Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true
###Automatically hide and show the Dock:
defaults write com.apple.dock autohide -bool true
### Automatically hide and show the Dock (duration)
defaults write com.apple.dock autohide-time-modifier -float 0.5
### Automatically hide and show the Dock (delay)
defaults write com.apple.dock autohide-delay -float 0
### Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true
### Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false
### Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

## Keyboard 
### Key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
### Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
### Show/hide language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool false

## Trackpad 
### Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

## Accessibility
### Reduce Transparency
defaults write com.apple.universalaccess reduceTransparency -bool true


# Finder 

## Preferences
### Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## View
### As List, Four-letter codes for theview modes: `'Nlsv', icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
### Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true
### Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
### Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
### When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

### Set Desktop as the default location for new Finder windows
### For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

### Show/hide icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

## Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

## Show the ~/Library folder
chflags nohidden ~/Library # && xattr -d com.apple.FinderInfo ~/Library

## Show the /Volumes folder
sudo chflags nohidden /Volumes


# Mail

## Disable send and reply animations in Mail.app
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true
## Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Senden" "@\U21a9" # german localization
## Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"


# Others

## Completely Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

## Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true


# Kill affected apps
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

# Done
echo "Done."
