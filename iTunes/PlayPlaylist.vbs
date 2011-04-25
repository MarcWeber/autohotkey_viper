rem This script will cause iTunes play the first song in the specified playlist.

rem Examples:
rem	    PlayPlaylist "5 stars"
rem	    PlayPlaylist /playlist:"5 stars"
rem Be sure to enclose the playlist name in quotes if it includes spaces.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


rem =================================================
function GetNamedArg(ArgName)


with Wscript.Arguments.Named
	if .Exists(ArgName) then
		GetNamedArg = .Item(ArgName)
	else
		GetNamedArg = ""
	end if
end with


end function
rem =================================================




rem =================================================
rem Main script:


' Variables
Dim iTunes 'As iTunes
Dim ArgPlaylist 'As String
Dim ArgPlaylistLcase 'As String
Dim Playlist 'As IITPlaylist
Dim TempPlaylist 'As IITPlaylist
Dim SyntaxErr 'As Boolean
Dim Msg 'As String


' Init
ArgPlaylist = GetNamedArg("playlist")
Set Playlist = Nothing

' Special support: if they provide exactly one unnamed argument, then
' assume that it's the playlist name (assuming /playlist hasn't been specified)
If (ArgPlaylist = "") And (Wscript.Arguments.Unnamed.Count = 1) Then
	' Use it!
	ArgPlaylist = Wscript.Arguments.Unnamed.Item(0)
End If


' Bounds check
SyntaxErr = False
If ArgPlaylist = "" Then SyntaxErr = True

If SyntaxErr = True Then
    Msg = "Please specify the playlist to play." + vbCrLf + vbCrLf
	Msg = Msg + "Examples:" + vbCrLf
	Msg = Msg + vbTab + "PlayPlaylist ""5 stars""" + vbCrLf
	Msg = Msg + vbTab + "PlayPlaylist /playlist:""5 stars"""
    Wscript.echo Msg
    Wscript.Quit
End If


' Connect to iTunes app
Set iTunes = Wscript.CreateObject("iTunes.Application")


' Find the specified playlist
Set Playlist = Nothing
ArgPlaylistLcase = LCase(ArgPlaylist)
For Each TempPlaylist In iTunes.LibrarySource.Playlists
    If LCase(TempPlaylist.Name) = ArgPlaylistLcase Then
        ' Match!
        Set Playlist = TempPlaylist
        Exit For
    End If
Next 'TempPlaylist

' Did we find one?
If Playlist Is Nothing Then
    Wscript.echo "The playlist """ + ArgPlaylist + """ could not be found."
    Wscript.Quit
Else
	' Start playing the playlist
	Playlist.PlayFirstTrack
End If


' Done; clean up
Set Playlist = Nothing
Set iTunes = Nothing


Rem End of script.
