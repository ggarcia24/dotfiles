#!/usr/bin/env bash

# ~/.macos — https://mths.be/macos

set -e
set -x

# Read some values
#echo "Enter the hostname:"
#read hostname
hostname=BER923X0D7

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## Add extra repos
#brew tap homebrew/cask
#brew tap homebrew/cask-versions
#brew tap homebrew/cask-fonts

brew install fish
brew install coreutils
brew install tree
brew install mas # Install MacStore cli tool

# Browsers
brew install --cask finicky
brew install --cask firefox
# brew install --cask google-chrome

# Utils
brew install jq
brew install direnv
brew install --cask keepassxc
brew install --cask deepl
brew install watch

# File Sync
brew install --cask dropbox
brew install --cask google-drive

# Messaging
# brew install --cask google-chat
# brew install --cask slack
# brew install --cask discord
# brew install --cask skype


# Development Tools
brew install git-lfs
brew install --cask font-fira-code-nerd-font
brew install --cask font-noto-nerd-font
brew install --cask sourcetree
brew install --cask kdiff3
brew install --cask kitty
brew install neovim
brew install --cask visual-studio-code
brew install --cask postman
brew install ripgrep
brew install plantuml

brew install --cask mockoon
brew install --cask nosql-workbench

# AWS
brew install --cask aws-vault
brew install awscli
brew install docker-credential-helper-ecr

# CPP
brew install conan

# Requirements for YCM
brew install cmake python mono go nodejs

# Python build requirements (for pyenv)
brew install openssl readline sqlite3 xz zlib cmake
brew install pyenv
brew install pipx

# Terraform
brew install tfenv
brew install terraform-linters/tap/tflint
brew install terraform-docs

# Serverless
brew install cfn-lint

# Java
brew install jenv
# Java 11, 17 and 20
brew install openjdk@11 openjdk@17 openjdk
brew install gradle

# Virtualization tools
# brew install colima
# brew install --cask virtualbox
brew install --cask docker
brew install docker-buildx
brew install helm
brew install minikube
brew install socket_vmnet

# Misc!
brew tap espanso/espanso
brew install espanso
brew install --cask alfred
# brew install --cask authy
# mas install 526298438 # Lightshot
brew install --cask rectangle
brew install --cask the-unarchiver
# brew install --cask openvpn-connect
brew install raindropio
# brew install telegram
brew install gimp
brew install --cask rescuetime
brew install --cask spotify
brew install --cask obsidian
# brew install --cask calibre
brew install --cask notion
# brew install --cask libreoffice

# 
brew install --cask miro
brew install --cask microsoft-onenote


# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName $hostname
sudo scutil --set HostName $hostname
sudo scutil --set LocalHostName $hostname
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $hostname

##### System Preferences #######

####
# General
#######


# Set language and text formats
defaults write -globalDomain AppleLanguages -array "en" "es"
defaults write -globalDomain AppleLocale -string "en_US@currency=EUR"
defaults write -globalDomain AppleMeasurementUnits -string "Centimeters"
defaults write -globalDomain AppleMetricUnits -bool true


defaults write -globalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write -globalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write -globalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -globalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -globalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable the over-the-top focus ring animation
defaults write -globalDomain NSUseAnimatedFocusRing -bool false

# Increase window resize speed for Cocoa applications
defaults write -globalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write -globalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write -globalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write -globalDomain PMPrintingExpandedStateForPrint -bool true
defaults write -globalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write -globalDomain NSDocumentSaveNewDocumentsToCloud -bool false


# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "


# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
defaults write org.cups.PrintingPrefs DefaultPaperID -string "iso-a4"

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write -globalDomain NSTextShowsControlCharacters -bool true

# Disable Resume system-wide
# defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write -globalDomain NSDisableAutomaticTermination -bool true

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

####
# Accessibility
####

# Vision
## Display
defaults write com.apple.transparencyd reduceTransparency -bool true
## Motion
defaults write com.apple.Accessibility ReduceMotionEnabled -bool true

###############################################################################
# Appearance #
###############################################################################

defaults write -globalDomain AppleInterfaceStyle -string "Dark"
defaults write -globalDomain NSGlassDiffusionSetting -int 1

# Windows
defaults write -globalDomain NSTableViewDefaultSizeMode -int 2
defaults write -globalDomain AppleReduceDesktopTinting -bool true
defaults write -globalDomain AppleShowScrollBars -string "Always"
defaults write -globalDomain AppleScrollerPagingBehavior -int 1

########
# Desktop & Dock #
########

# Dock
defaults write com.apple.dock tilesize -int 32
defaults write com.apple.dock largesize -int 128
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool false

# Desktop & Stage Manager
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Widgets
defaults write com.apple.WindowManager StageManagerHideWidgets -bool true
defaults write com.apple.WindowManager StandardHideWidgets -bool true

# Windows
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false

######
# Displays
#######

# Find a way to configure resolution to more spaace


#######
# Menu Bar
#######

# Menu Bar Controls
defaults -currentHost write com.apple.controlcenter Spotlight -int 8
defaults -currentHost write com.apple.controlcenter WiFi -int 1
defaults -currentHost write com.apple.controlcenter Bluetooth -int 2
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -int 1
defaults -currentHost write com.apple.controlcenter FocusModes -int 8
defaults -currentHost write com.apple.controlcenter Display -int 8
defaults -currentHost write com.apple.controlcenter Sound -int 16
defaults -currentHost write com.apple.controlcenter NowPlaying -int 8
defaults -currentHost write com.apple.controlcenter Timer -int 8

#####
# Wallpaper
#######

# Find how to set the wallpaper to black

####
# Lock Screen
####

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults write NSGlobalDomain AppleFontSmoothing -int 1
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"


#####
# Keyboard
#######
defaults write -globalDomain KeyRepeat -int 7
defaults write -globalDomain InitialKeyRepeat -int 15

# Disable the spotlight shortcut
plutil -replace AppleSymbolicHotKeys.64.enabled -bool false ~/Library/Preferences/com.apple.symbolichotkeys.plist 
plutil -replace AppleSymbolicHotKeys.64.value.parameters -json '{}' ~/Library/Preferences/com.apple.symbolichotkeys.plist
# Enable the F1 keys by default
defaults write -globalDomain com.apple.keyboard.fnState -bool true




###########
# Trackpad
###########

defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -bool true
defaults -currentHost write -globalDomain com.apple.trackpad.twoFingerDoubleTapGesture -int 1
defaults -currentHost write -globalDomain com.apple.trackpad.twoFingerFromRightEdgeSwipeGesture -int 3
defaults -currentHost write -globalDomain com.apple.trackpad.threeFingerDragGesture -bool false
defaults -currentHost write -globalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 2
defaults -currentHost write -globalDomain com.apple.trackpad.threeFingerTapGesture -bool false
defaults -currentHost write -globalDomain com.apple.trackpad.threeFingerVertSwipeGesture -bool false
defaults -currentHost write -globalDomain com.apple.trackpad.fourFingerHorizSwipeGesture -int 2
defaults -currentHost write -globalDomain com.apple.trackpad.fourFingerVertSwipeGesture -bool false
defaults -currentHost write -globalDomain com.apple.trackpad.fourFingerPinchSwipeGesture -bool false


# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40



# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Never go into computer sleep mode
sudo systemsetup -setcomputersleep Off > /dev/null


# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null


###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
if [ -d "/private/var/vm/sleepimage" ]; then
    sudo rm /private/var/vm/sleepimage
    # Create a zero-byte file instead…
    sudo touch /private/var/vm/sleepimage
    # …and make sure it can’t be rewritten
    sudo chflags uchg /private/var/vm/sleepimage
fi

# Show language menu in the top right corner of the boot screen
# sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null


###############################################################################
# Finder                                                                      #
###############################################################################

defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.Finder FXArrangeGroupViewBy -string "Name"
defaults write com.apple.finder FXPreferredGroupBy -string "None"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXRemoveOldTrashItems -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false

defaults write com.apple.finder StandardViewSettings -dict-add SettingsType '<string>StandardViewSettings</string>'



defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Remove Dropbox’s green checkmark icons in Finder
# file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
# [ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

#############
# Dashboard #
#############

defaults write com.apple.dashboard mcx-disabled -bool true

# Reset Launchpad, but keep the desktop wallpaper intact
if [ -d "${HOME}/Library/Application Support/Dock" ]; then
    find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete
fi

###############
# Hot corners #
###############
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0



###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
defaults write com.googlecode.iterm2 QuitWhenAllWindowsClosed -bool true
defaults write com.googlecode.iterm2 SUAutomaticallyUpdate -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

defaults write com.apple.iCal CalendarSidebarShown -bool true
defaults write com.apple.iCal "n days of week" -int 5
defaults write com.apple.iCal "Show Week Numbers" -bool true
defaults write com.apple.iCal "TimeZone support enabled" -bool true

# Enable Dashboard dev mode (allows keeping widgets on the desktop)
defaults write com.apple.dashboard devmode -bool true

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool false

###############################################################################
# Mac App Store                                                               #
###############################################################################

defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

defaults write com.apple.appstore ShowDebugMenu -bool true
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

defaults write com.apple.commerce AutoUpdate -bool true
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# VSCode

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false


if ! grep -q "/opt/homebrew/bin/fish" /etc/shells; then
    echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi
chsh -s /opt/homebrew/bin/fish


echo "Done. Note that some of these changes require a logout/restart to take effect."
