EXT=".JPG"

cd "$@"
echo "$@"

modifiedCt=0
totalCt=0

extensionFiles=(*"$EXT")
numFiles=${#extensionFiles[@]}


for file in *"$EXT"
do
  date="$(exiftool -d "%Y%m%d_%H%M%S" -CreateDate "$file" | awk '{print $4}')"
  if [ -z "$date"]; then
      date="$(date -r $file "+%Y%m%d_%H%M%S")"
  fi
  # echo "$date"
  basename=$(basename "$file" "$EXT")
  # echo "$basename"
  newname="$date-$basename$EXT"
  # echo "$file->$newname"
  newFile="$(mv -n "$file" "../$newname")"

  origHash=`echo $(sha256sum $file) | awk '{ print $1 }'`
  # echo $origHash
  newFileHash=`echo $(sha256sum "../$newname") | awk '{ print $1 }'`
  # echo $newFileHash
  if [ "$origHash" = "$newFileHash" ]; then
    modifiedCt=$((modifiedCt+1))
  else
    echo "WARN: Cannot validate the contents of $file are the same after renaming. Check for file corruption."
  fi

  totalCt=$((totalCt+1))
  echo -ne "Renaming $totalCt/$numFiles\r"
done

echo "$modifiedCt/$totalCt $EXT" "files were modified"

# IMG.* (new name) enumerate
# (.*) \(([0-9]+)\) $1-$2 do not enumerate