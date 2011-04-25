rem This script pauses iTunes, regardless of its current state.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


' Variables
dim iTunes


' Connect to iTunes app
set iTunes = CreateObject("iTunes.Application")


' Pause
iTunes.Pause


' Done; release object
set iTunes = nothing


rem End of script.
