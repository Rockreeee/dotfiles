#!/bin/sh

# Trackpad speed
defaults write -g com.apple.mouse.scaling 5.0

# Dock size
defaults write com.apple.dock tilesize -integer 37
killall Dock