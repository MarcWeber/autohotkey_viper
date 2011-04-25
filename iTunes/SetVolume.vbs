rem Set the volume within iTunes.
rem Note that this is a different volume control than
rem that provided by your sound card (which can be easily
rem accessed by double-clicking on the speaker icon in the
rem system tray).
rem Normally you will want to keep iTunes set to its maximum
rem volume and adjust your sound card's volume using the
rem normal mapping of your multimedia keyboard.  Therefore,
rem use of this script to control the iTunes volume is
rem not recommended (unless you've got a special need in mind).

rem Syntax:
rem SetVolume [+|-]number
rem Examples:
rem SetVolume 0       sets volume to "off" (but not the same as "mute")
rem SetVolume 100     sets volume to highest possible value
rem SetVolume 50      sets volume to 50 (ie, half)
rem SetVolume -10     turns volume down by 10%
rem Note that the volume ranges from 0 to 100.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


Dim iTunes
Dim ArgErr
Dim ArgStr
Dim ArgVal
Dim p
Dim IsRelative
Dim NewLevel


' Create app object
Set iTunes = WScript.CreateObject("iTunes.Application")


' Get the argument
ArgErr = false
if Wscript.Arguments.Count <> 1 then
	' Error!
	ArgErr = true
else
	' See if it's reasonable
	ArgStr = Wscript.Arguments.Item(0)
	ArgVal = -127	' some unlikely value

	if IsNumeric(ArgStr) then
		' Try to convert
		on error resume next
		Err.Clear
		ArgVal = cint(ArgStr)
		if (Err.Number <> 0) or (ArgVal = -127) then
			' Couldn't convert string to a number
			ArgErr = true
		end if
		on error goto 0
	else
		ArgErr = true
	end if
end if


if ArgErr then
	' Display error message
	Wscript.Echo "Error!  Please specify a volume level between 0 and 100, or a relative value such as -10."
else
	' Calculate new volume level
	IsRelative = (  (left(ArgStr,1) = "+") or (left(ArgStr,1) = "-")  )
	if IsRelative then
		NewLevel = iTunes.SoundVolume + ArgVal
	else
		NewLevel = ArgVal
	end if

	' Set the new level
	iTunes.SoundVolume = NewLevel
end if


' Done; release object
set iTunes = nothing


rem End of script.
