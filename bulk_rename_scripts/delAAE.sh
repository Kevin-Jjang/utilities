cd "$@"
echo "$@"

delCt=0
for file in *.AAE
do
    echo "$file"
    rm "$file" && delCt=$((delCt+1))
done

echo "$delCt .AAE" "files were deleted"
