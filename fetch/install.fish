#!/usr/bin/env fish

# Simple installer for the custom fetch utility.

if test (status current-command) != fish
    echo "Please run this installer with Fish."
    exit 1
end

set -l project_dir (status dirname)
set -l config_dir ~/.config/fetch
set -l function_dir ~/.config/fish/functions

echo "Installing fetch..."

mkdir -p $config_dir
mkdir -p $function_dir

# Install project files.
cp $project_dir/colors.fish $config_dir/
cp $project_dir/fetch.fish $config_dir/
cp $project_dir/info.fish $config_dir/
cp $project_dir/logo.fish $config_dir/
cp $project_dir/render.fish $config_dir/

mkdir -p $config_dir/logos
cp $project_dir/logos/* $config_dir/logos/

# Install Fish function.
cp $project_dir/fetch.fish $function_dir/fetch.fish

echo
echo "Installation complete."
echo "Run: fetch"
