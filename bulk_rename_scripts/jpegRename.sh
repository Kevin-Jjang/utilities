EXT=".JPEG"

cd "$@"
echo "$@"

modifiedCt=0
totalCt=0
for file in *"$EXT"
do
    # echo "$file"
    date="$(exiftool -d "%Y%m%d_%H%M%S" -CreateDate "$file" | awk '{print $4}')"
    # echo "$date"
    basename=$(basename "$file" "$EXT")
    # echo "$basename"
    newname="$date-$basename$EXT"
    # echo "$file->$newname"
    mv -n "$file" "$newname" && modifiedCt=$((modifiedCt+1))
    totalCt=$((totalCt+1))
done

echo "$modifiedCt/$totalCt $EXT" "files were modified"

# IMG.* (new name) enumerate
# (.*) \(([0-9]+)\) $1-$2 do not enumerate