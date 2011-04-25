rem This script will cause iTunes play the specified song.

rem Examples:
rem	    PlaySong /song:"Whip It"
rem	    PlaySong /song:"Whip It" /album:"Freedom of Choice"
rem	    PlaySong /song:"Whip It" /artist:"Devo"
rem	    PlaySong /song:"Whip It" /album:"Freedom of Choice" /artist:Devo
rem	    PlaySong /song:"Whip It" /album:"Freedom of Choice" /artist:"Devo"
rem	    PlaySong /song:"Whip It" /album:"Freedom of Choice" /artist:"Devo" /playlist:"5 stars"
rem		PlaySong "Whip It"
rem Be sure to enclose the names in quotes if they include spaces.

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
Dim ArgArtist 'As String
Dim ArgAlbum 'As String
Dim ArgSongName 'As String
Dim Tracks_Artist 'As IITTrackCollection
Dim Tracks_Album 'As IITTrackCollection
Dim Tracks_SongName 'As IITTrackCollection
Dim FoundEverwhere 'As Boolean
Dim Track 'As IITTrack
Dim TempTrack 'As IITTrack
Dim FoundTrack 'As IITTrack
Dim Playlist 'As IITPlaylist
Dim TempPlaylist 'As IITPlaylist
Dim SyntaxErr 'As Boolean
Dim Msg 'As String


' Init
ArgPlaylist = GetNamedArg("playlist")
ArgArtist = GetNamedArg("artist")
ArgAlbum = GetNamedArg("album")
ArgSongName = GetNamedArg("song")
Set Playlist = Nothing
Set Tracks_Artist = Nothing
Set Tracks_Album = Nothing
Set Tracks_SongName = Nothing

' Special support: if they provide exactly one unnamed argument, then
' assume that it's the song name (assuming /song hasn't been specified)
If (ArgSongName = "") And (Wscript.Arguments.Unnamed.Count = 1) Then
	' Use it!
	ArgSongName = Wscript.Arguments.Unnamed.Item(0)
End If


' Bounds check
SyntaxErr = False
If ArgSongName = "" Then SyntaxErr = True
If (ArgAlbum = "") And (ArgArtist = "") And (ArgSongName = "") Then SyntaxErr = True

If SyntaxErr = True Then
    Msg = "Please specify the song to play.  You can also specify an album, artist, or playlist name." + vbCrLf + vbCrLf
	Msg = Msg + "Examples:" + vbCrLf
	Msg = Msg + vbTab + "PlaySong /song:""Girl U Want""" + vbCrLf
	Msg = Msg + vbTab + "PlaySong /song:""Girl U Want"" /artist:Devo" + vbCrLf
	Msg = Msg + vbTab + "PlaySong /song:""Girl U Want"" /artist:Devo /album:""Freedom of Choice""" + vbCrLf
	Msg = Msg + vbTab + "PlaySong /song:""Girl U Want"" /artist:Devo /album:""Freedom of Choice"" /playlist:""5 stars"""
    Wscript.echo Msg
    Wscript.Quit
End If


' Connect to iTunes app
Set iTunes = Wscript.CreateObject("iTunes.Application")


' Did they specify a playlist?
If ArgPlaylist <> "" Then
    ArgPlaylistLcase = LCase(ArgPlaylist)
    ' Find the specified playlist
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
    End If
Else
    ' No special playlist, so use the default (library)
    Set Playlist = iTunes.LibraryPlaylist
End If


' Get the collections of tracks for the specified fields
If ArgSongName <> "" Then
    Set Tracks_SongName = Playlist.Search(ArgSongName, 5)
End If

If Tracks_SongName Is Nothing Then
    ' No matching songs found
    Wscript.echo "The song """ + ArgSongName + """ was not found."
    Wscript.Quit
End If

If ArgArtist <> "" Then
    Set Tracks_Artist = Playlist.Search(ArgArtist, 2)
End If

If ArgAlbum <> "" Then
    Set Tracks_Album = Playlist.Search(ArgAlbum, 3)
End If


' Now iterate through the found songs.
' We're going to play the first song we find which is also in
' Tracks_Artist and Tracks_Album if specified
Set FoundTrack = Nothing
For Each Track In Tracks_SongName
    ' Assume success
    FoundEverwhere = True
    
    ' Album?
    If Not (Tracks_Album Is Nothing) Then
        Set TempTrack = Nothing
        Set TempTrack = Tracks_Album.ItemByName(Track.Name)
        If TempTrack Is Nothing Then
            ' Song not found in this album
            FoundEverwhere = False
        Else
            ' Found!  Do nothing.
        End If
    End If
    
    ' Artist?
    If (FoundEverwhere = True) And (Not (Tracks_Artist Is Nothing)) Then
        Set TempTrack = Nothing
        Set TempTrack = Tracks_Artist.ItemByName(Track.Name)
        If TempTrack Is Nothing Then
            ' Song not found in this Artist
            FoundEverwhere = False
        Else
            ' Found!  Do nothing.
        End If
    End If
    
    ' Result?
    If FoundEverwhere = True Then
        ' Success!
        Set FoundTrack = Track
        Exit For
    End If
    
Next 'Track


If FoundTrack Is Nothing Then
	' Explain that the song wasn't found
    Wscript.echo "The song """ + ArgSongName + """ was not found."
Else
	' Play it!
	FoundTrack.Play
End If


' Done; clean up
Set Track = Nothing
Set FoundTrack = Nothing
Set TempTrack = Nothing
Set Playlist = Nothing
Set Tracks_Artist = Nothing
Set Tracks_Album = Nothing
Set Tracks_SongName = Nothing
Set iTunes = Nothing


Rem End of script.
