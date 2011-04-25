rem This script makes sure that iTunes is playing.
rem If paused, it will start playing.
rem If fast-forwarding or rewinding, it will resume normal playback.

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
		' Do nothing!

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
