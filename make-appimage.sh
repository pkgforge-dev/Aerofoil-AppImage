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
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/AerofoilX /usr/lib/aerofoil

# Turn AppDir into AppImage
quick-sharun --make-appimage
