# Bulk Media Rename Scripts

*"I want to view image collections and be able to see the date they were taken alongside what they were about. It would be most convienient to have this info in the filename but there are tens of thousands of images to rename!"*

Created for personal use. These bash scripts are an iterative way to rename hundreds of images and videos at a time based on the time the media was originally taken. This is done by reading the EXIF metadata attached to each image and attaching the Creation Date to the file.

This personal project was motivated by the lack of file naming by date in PowerRename, and therefore, is a supplementary utility to organize media files using both programs.

## Prerequisites

You must be able to run Bash scripts. For windows users, this would either be Windows Subsystem for Linux or Git Bash.

These scripts use [ExifTool](https://github.com/exiftool/exiftool), an open source library that can read meta information from a wide range of filetypes. You must install ExifTool to use these scripts.

## Intended Workflow
Using a media arrangement of 
```
/images
/images/photos2010
/images/photos2020
```
1. Place the scripts in the root media directory (`images`).
2. Create a copy of a target media directory. This is to prevent accidentally overwriting a file or other mistakes as these operations are irreversible and may not show up in the Recycle Bin. In this example we can make a copy of 2020 as `/images/photos2020renamed`
3. Run the script with the copied target directory as the first argument. `./renameAll.sh './photos2020renamed'`
4. In the console, check that each media extension has modified counts equal to total counts. If they are equal, then that extension was renamed properly. Otherwise, some images were not renamed.
5. Perform a checksum between the original folder and now-renamed copied folder to ensure that there were no losses in data.
6. The original, unmodified folder can now be removed as all of the files have been renamed in the copied folder.

#### The number of modified files does not match the total number of files

Each script will return a statement in the console stating "`numMod of numTotal .extension files were modified`". If `numMod` is less than `numTotal`, then some files of that `extension` type were not renamed.

This often occurs with JPG and PNG images that were taken as screenshots. Depending on the device, screenshots may not have EXIF data that defines their Creation Date. There is another field that can be checked for a valid date.  

```
date="$(exiftool -d "%Y%m%d_%H%M%S" -CreateDate "$file" | awk '{print $4}')"

if [ -z "$date"]; then
    date="$(date -r $file "+%Y%m%d_%H%M%S")"
fi
```

The `-z` flag checks if the date variable is an empty string, then attempts to set it by the file's original date value using Linux's `date` command. Note that this date value might not be the same as the date that a photograph was taken, which is why the Creation Date is given priority first.

# Further Improvements

- Add flags to simplify how commands should be run
- Abstract the main rename function so that it can take in multiple extensions at once 

### See Also

For Windows users, Microsoft PowerToys's PowerRename tool can help with renaming the images further. If you would like to keep the date format but rename the rest of the file name, you would have to select by the first dash and split the string.
