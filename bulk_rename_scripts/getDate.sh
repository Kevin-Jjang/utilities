date -r $@ "+%Y%m%d_%H%M%S"

echo "$@"
date="$(exiftool -d "%Y%m%d_%H%M%S" -CreateDate "$@" | awk '{print $4}')"
if [ -z "$date"]; then
    date="$(date -r $@ "+%Y%m%d_%H%M%S")"
fi
echo "final date $date"

basename=$(basename "$@" "$EXT")
echo "$basename"
newname="$date-$basename$EXT"
echo "$@->$newname"
    