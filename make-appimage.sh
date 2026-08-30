#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/elasota/Aerofoil/eccf2cf528af04cd87d741719db34d7745c05be5/Resources/Linux/io.github.elasota.aerofoil.svg
export DESKTOP=https://raw.githubusercontent.com/elasota/Aerofoil/refs/heads/master/Resources/Linux/io.github.elasota.aerofoil.desktop
export STARTUPWMCLASS=AerofoilX
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/bin/AerofoilX /usr/lib/aerofoil

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
