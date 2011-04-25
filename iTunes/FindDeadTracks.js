/* 	Rename me to FindDeadTracks.js
	Double Click in Explorer to run

Script by Otto - http://ottodestruct.com       */

var ITTrackKindFile	= 1;
var	iTunesApp = WScript.CreateObject("iTunes.Application");
var	deletedTracks = 0;
var	mainLibrary = iTunesApp.LibraryPlaylist;
var	tracks = mainLibrary.Tracks;
var	numTracks = tracks.Count;
var	i;

var fso, tf;
fso = new ActiveXObject("Scripting.FileSystemObject");
tf = fso.CreateTextFile("Dead Tracks.txt", true);

while (numTracks != 0)
{
	var	currTrack = tracks.Item(numTracks);
	
	// is this a file track?
	if (currTrack.Kind == ITTrackKindFile)
	{
		// yes, does it have an empty location?
		if (currTrack.Location == "")
		{
			// write info about the track to a file
			tf.WriteLine(currTrack.Artist + "," + currTrack.Album + "," + currTrack.Name);
			deletedTracks++;
		}
	}
	
	numTracks--;
}

if (deletedTracks > 0)
{
	if (deletedTracks == 1)
	{
		WScript.Echo("Found 1 dead track.");
	}
	else
	{
		WScript.Echo("Found " + deletedTracks + " dead tracks.");
	}
}
else
{
	WScript.Echo("No dead tracks were found.");
}
tf.Close();

