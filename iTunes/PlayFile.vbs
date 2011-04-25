rem This script will cause iTunes play the specified file.
rem The file will also be added to your iTunes "Library"
rem if it isn't already in it.

rem Syntax:
rem	    PlayFile "FullPath"
rem Example:
rem     PlayFile "C:\My Music\Devo\Freedom of Choice\Whip It.MP3"
rem Be sure to enclose the path in quotes if it includes spaces.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


' Variables
dim iTunes, FullPath


' Get the full path of the file to play
if Wscript.Arguments.Count <> 1 then
	' Error!
	Wscript.Echo "Error!  Please specify the full path (enclosed in quotes) to the music file that you wish to play."
	Wscript.Quit
end if

FullPath = Wscript.Arguments.Item(1)


' Connect to iTunes app
set iTunes = CreateObject("iTunes.Application")


' Play the file
iTunes.PlayFile FullPath


' Done; release object
set iTunes = nothing


rem End of script.
