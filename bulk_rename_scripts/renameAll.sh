echo "starting rename of $@"

sh heicRename.sh "$@"
sh jpgRename.sh "$@"
sh jpegRename.sh "$@"
sh movRename.sh "$@"
sh mp4Rename.sh "$@"

echo "rename complete"

# IMG.* (new name) enumerate
# (.*) \(([0-9]+)\) $1-$2 do not enumerate