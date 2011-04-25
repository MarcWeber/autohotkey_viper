rem This script tells iTunes to play the previous track.
rem Note that this will always move to the previous track,
rem regardless of the position within the current track.
rem You can use the script BackTrack.vbs to use the "back track"
rem feature of iTunes, which restarts the current track if you're
rem at least a few seconds into it, or goes to the previous track
rem if you're within the first few seconds of the current track.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


Dim iTunes


' Connect to iTunes app
Set iTunes = CreateObject("iTunes.Application")


' Go to previous track
iTunes.PreviousTrack


' Done; release object
set iTunes = nothing


rem End of script.
