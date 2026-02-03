#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake      \
    sdl2       \
    sdl2_image

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package

# If the application needs to be manually built that has to be done down here
#mv -v ./src/aerofoil-git/build/Packaged ./AppDir/lib/aerofoil/

echo "Making nightly build of Aerofoil..."
echo "---------------------------------------------------------------"
REPO="https://github.com/elasota/Aerofoil"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive --depth 1 "$REPO" ./Aerofoil
echo "$VERSION" > ~/version

cd ./Aerofoil
mkdir -p build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX="/usr" -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
make install
cp "../Resources/Linux/io.github.elasota.aerofoil.desktop" "/usr/share/applications"
cp "../Resources/Linux/io.github.elasota.aerofoil.svg" "/usr/share/pixmaps"
