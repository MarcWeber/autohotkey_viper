rem This script immediately exits, setting the ERRORLEVEL value to
rem indicate the current play state of iTunes.

rem Possible return values:
rem 0 = Stopped
rem 1 = Playing
rem 2 = Fast-forwarding
rem 3 = Rewinding

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


' Variables
dim iTunes, CurState


' Connect to iTunes app
set iTunes = CreateObject("iTunes.Application")


' Get current state
CurState = iTunes.PlayerState


' Done; release object
set iTunes = nothing


' Quit, returning state
Wscript.Quit CurState


rem End of script.
