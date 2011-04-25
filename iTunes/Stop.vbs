rem This script stops iTunes, regardless of its current mode.
rem (Possible modes are playing, paused, fast-forwarding, or rewinding.)
rem Note that "stopping" means that iTunes will stop any playback
rem and return to the beginning of the current track.
rem Of course, this is different than pausing.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


' Variables
dim iTunes, CurState


' Connect to iTunes app
set iTunes = WScript.CreateObject("iTunes.Application")


' Stop and return to beginning of current track
iTunes.Stop


' Done; release object
set iTunes = nothing


rem End of script.
