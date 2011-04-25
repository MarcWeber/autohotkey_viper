rem Set or toggle iTunes muting.
rem Note that this is a different mute control than
rem that provided by your sound card (which can be easily
rem accessed by double-clicking on the speaker icon in the
rem system tray).
rem Use of this script to control the iTunes muting is
rem not recommended (unless you've got a special need in mind).

rem Syntax:
rem Mute [on|off]
rem Examples:
rem Mute		toggles the current muting state
rem Mute on		turns on muting
rem Mute off	turns off muting

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


Dim iTunes
Dim ArgStr
Dim Msg


' Create app object
Set iTunes = WScript.CreateObject("iTunes.Application")


' Get the argument
Select Case Wscript.Arguments.Count
	Case 0
		ArgStr = ""

	Case 1
		ArgStr = Lcase(Trim(Wscript.Arguments.Item(0)))

	Case Else
		ArgStr = "error!"
End Select


' Now interpret the argument and act accordingly
Select Case ArgStr
	Case "on"
		iTunes.Mute = True

	Case "off"
		iTunes.Mute = False

	Case ""
		' Toggle
		iTunes.Mute = Not (iTunes.Mute)

	Case Else
		Msg = "Please specify 'Mute on' or 'Mute off' to set the mute state, or 'Mute'"
		Msg = Msg + " (without an argument) to toggle the mute state."
		Wscript.Echo Msg

End Select


' Done; release object
set iTunes = nothing


rem End of script.
