#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/io.github.elasota.aerofoil.svg
export DESKTOP=/usr/share/applications/io.github.elasota.aerofoil.desktop
export STARTUPWMCLASS=AerofoilX
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/AerofoilX /usr/lib/aerofoil

# Turn AppDir into AppImage
quick-sharun --make-appimage
