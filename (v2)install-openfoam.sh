#!/bin/env bash
# This script will download OpenFOAM, build it, and set environment variables.

# Exit when any command fails.
set -e

# Keep track of the last executed command.
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG

# Echo an error message before exiting.
if [ $? -ne 0 ]; then
    trap 'echo "\"${last_command}\" command had an exit code $?."' EXIT
fi

# Specify the URL to download OpenFOAM.
DOWNLOAD_URL="https://dl.openfoam.org/source/11"

# Specify the installation directory.
INSTALL_DIR="/nfs_share/openfoam"

# Check for directory and create it.
[ -d "$INSTALL_DIR" ] && echo "OpenFOAM directory already exists" || mkdir -p "$INSTALL_DIR"

cd "$INSTALL_DIR"

# Download OpenFOAM from the specified URL.
echo "Downloading OpenFOAM from $DOWNLOAD_URL"
wget "$DOWNLOAD_URL" -O openfoam-11.tar.gz

# Check if the download was successful.
if [ -f "$INSTALL_DIR/openfoam-11.tar.gz" ]; then
    echo "OpenFOAM downloaded successfully"
else
    echo "OpenFOAM download failed"
    exit 1
fi

# Extract OpenFOAM from the tarball.
tar -xvzf openfoam-11.tar.gz


rm openfoam-11.tar.gz

mv OpenFOAM-11-version-11 openfoam-11

# Navigate to the OpenFOAM source directory.
cd openfoam-11

# Build OpenFOAM (you may need to configure this part depending on your system).
./Allwmake -j4 # Adjust the number of parallel jobs as needed.
