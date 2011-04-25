rem This script tells iTunes to play the next track.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


Dim iTunes


' Connect to iTunes app
Set iTunes = CreateObject("iTunes.Application")


' Go to next track
iTunes.NextTrack


' Done; release object
set iTunes = nothing


rem End of script.
