#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm cmake

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini sdl2_image-mini

# Comment this out if you need an AUR package
make-aur-package aerofoil-git

# If the application needs to be manually built that has to be done down here


echo "Building Aerofoil..."
echo "---------------------------------------------------------------"
REPO="https://github.com/elasota/Aerofoil"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./Aerofoil
echo "$VERSION" > ~/version

cd ./Aerofoil
cmake -DCMAKE_BUILD_TYPE=Release -B build
cmake --build build
