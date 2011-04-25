rem This script calls the iTunes "back track" feature.
rem If you're only a few seconds into the current track
rem then this will move to the previous track.  If you're
rem further into the current track then it will restart
rem the current track.
rem You can instead use the script Previous.vbs to always
rem go to the previous track, regardless of your position
rem in the current track.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


' Variables
dim iTunes


' Connect to iTunes app
set iTunes = CreateObject("iTunes.Application")


' Go to previous track or restart current track
iTunes.BackTrack


' Done; release object
set iTunes = nothing


rem End of script.
