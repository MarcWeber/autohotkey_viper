var iTunesApp = WScript.CreateObject("iTunes.Application");
var oTrackToDelete = iTunesApp.CurrentTrack;

if (oTrackToDelete != null) {
	var objWSH = WScript.CreateObject("Wscript.Shell");
	var intChoice = objWSH.Popup("Do you really want to perminantly delete " + oTrackToDelete.Name + "?", 5000, "Delete " + oTrackToDelete.Name + "?", 52);
	if (intChoice == 6) {
		iTunesApp.NextTrack();
		var fs = new ActiveXObject("Scripting.FileSystemObject");
		fs.DeleteFile(oTrackToDelete.Location);
		oTrackToDelete.Delete();
	}
}