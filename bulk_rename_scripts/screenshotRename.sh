echo "starting miscellaneous rename of $@"

sh delAAE.sh "$@"
sh pngRename.sh "$@"
sh jpgMiscRename.sh "$@"

echo "rename complete"
