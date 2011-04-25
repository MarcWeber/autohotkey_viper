rem This script causes iTunes to "rewind" through the current track.
rem Call the Play or PlayPause script to resume playing.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


' Variables
dim iTunes


' Connect to iTunes app
set iTunes = CreateObject("iTunes.Application")


' Start rewinding
iTunes.Rewind


' Done; release object
set iTunes = nothing


rem End of script.
