# FFmpeg Quick Reference

Personal reference page for the [FFmpeg documentation](https://www.ffmpeg.org/ffmpeg.html).

## Compression

Higher quality

`ffmpeg -i input.mp4 -vcodec libx265 -crf 28 output.mp4`

If desiring speed on older hardware, use libx264 and increase the constant rate factor. CRF can be between 0 and 51. 

`ffmpeg -i input.mp4 -vcodec libx264 -crf 36 output.mp4`

- CRF 28 does not have significant noticable pixelation.
- CRF 36 has obvious pixelation and rough edges with a higher compression ratio. Do not compress videos that have small text because they will become illegible. 

## Trimming

Skip the first 30 seconds, and then extract the next 10 seconds as a new file.

`ffmpeg -ss 30 -i input.mp4 -c copy -t 10 output.mp4`

Timestamps can be in seconds and milliseconds (s.ms) or in HH:MM:SS.ms format. Refer to [FFmpeg time duration syntax](https://www.ffmpeg.org/ffmpeg-utils.html#time-duration-syntax).

`ffmpeg -ss 00:00:30.0 -i input.mp4 -c copy -t 00:00:10.0 output.mp4`

When -t is before -i, it limits the duration of data read from the file. When -t is after -i, it is considered an output option and will halt operation once ffmpeg reaches the specified time.

Use `-to` instead of `-t` to specify a timestamp range to cut. 

`ffmpeg -ss 00:00:30.0 -i input.mp4 -c copy -to 00:00:40.0 output.mp4`

## Extracting Audio

Given a video, extract the audio.

`ffmpeg -i input.mp4 -q:a 0 -map a "output.mp3"`

- `-q:a 0` (alias for `-aq q`) Audio quality is set to 0 for variable bitrate. 
- `-map a` Only extracts the audio channel, meaning no video or subtitle channels. 

