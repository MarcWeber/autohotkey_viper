var iTunesApp = WScript.CreateObject("iTunes.Application");

iTunesApp.Pause();
iTunesApp.SoundVolume = 0;
iTunesApp.Play();

var i = 1;
while (i <= 50) {
	iTunesApp.SoundVolume = i;
	WScript.Sleep(3000);
	i++;
}
while (i <= 100) {
	iTunesApp.SoundVolume = i;
	WScript.Sleep(6000);
	i++;
}

WScript.Quit();