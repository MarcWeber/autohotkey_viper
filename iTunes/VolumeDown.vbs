rem Decrement the volume within iTunes by 10 points.
rem Note that this is a different volume control than
rem that provided by your sound card (which can be easily
rem accessed by double-clicking on the speaker icon in the
rem system tray).
rem Normally you will want to keep iTunes set to its maximum
rem volume and adjust your sound card's volume using the
rem normal mapping of your multimedia keyboard.  Therefore,
rem use of this script to control the iTunes volume is
rem not recommended (unless you've got a special need in mind).

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


Dim iTunes


' Create app object
Set iTunes = WScript.CreateObject("iTunes.Application")


' Decrement volume by 10 points
iTunes.SoundVolume = iTunes.SoundVolume - 10


' Done; release object
set iTunes = nothing


rem End of script.
