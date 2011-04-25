rem This script toggles iTunes between playing and pausing.
rem It can also resume playing if currently fast-forwarding or rewinding.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


' Variables
dim iTunes, CurState


' Connect to iTunes app
set iTunes = CreateObject("iTunes.Application")


' Get current state
CurState = iTunes.PlayerState


' Do the appropriate thing
select case CurState
	case 0
		' Stopped
		iTunes.PlayPause

	case 1
		' Playing
		iTunes.PlayPause

	case 2
		' Fast-forwarding
		iTunes.Resume

	case 3
		' Rewinding
		iTunes.Resume

end select


' Done; release object
set iTunes = nothing


rem End of script.
