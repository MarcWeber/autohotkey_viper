;
; CustomHotkeys.ahk
;
; This file contains custom keybindings ONLY.
;

; Special Characters ============================================ ;

#UseHook on

`::
     if (KMD_Enabled == true)
     {
          if (KMD_ViperMode == true)
               KMD_StartKommandMode(false)
          else if (KMD_InsertMode == true)
               KMD_StartViperMode(false)
     }
     else
          Send, ``
return

#UseHook off

#`::
     if (KMD_Enabled == true)
          Send, ``
     else
          Send, #`
return

#Space:: RunAndFocusInMode("http://docs.google.com/", 1)

#Backspace::
     EnvGet, UserProfile, USERPROFILE
     RunAndFocusInMode("""C:\Program Files (x86)\Prism\prism.exe"" -override """ UserProfile "\AppData\Roaming\WebApps\k.rss@prism.app\override.ini"" -webapp k.rss@prism.app", 1)
return

#Enter:: RunAndFocusInMode("http://localhost/Cityworks.WebApp/Login.aspx", 1)
#+Enter:: RunAndFocusInMode("http://localhost/CwPortal/Login.aspx", 1)
#Insert:: RunAndFocusInMode("http://www.rememberthemilk.com/home/kylir/", 1)
#+Insert:: RunAndFocus("C:\Program Files (x86)\Focus Booster\Focus Booster.exe")

#Delete::
     EnvGet, UserProfile, USERPROFILE
     RunAndFocusInMode("""C:\Program Files (x86)\Prism\prism.exe"" -override """ UserProfile "\AppData\Roaming\WebApps\k.cal@prism.app\override.ini"" -webapp k.cal@prism.app", 1)
return

;#Home::
;#End::
;#PgUp::
;#PgDn::

; Arrows ======================================================== ;

#Up:: Run iTunes\PlayPause.vbs,,UseErrorLevel
#Down:: Run iTunes\DeleteTrack.js,,UseErrorLevel
#+Down:: Run iTunes\FindDeadTracks.js,,UseErrorLevel
#^Down:: Run iTunes\RemoveDeadTracks.js,,UseErrorLevel
#Left:: Run iTunes\BackTrack.vbs,,UseErrorLevel
#Right:: Run iTunes\Next.vbs,,UseErrorLevel

; Numbers ======================================================= ;

#1:: RunAndFocusInMode("C:\Cityworks\Cityworks.WebApp", 3)
#+1:: RunAndFocusInMode("C:\Cityworks", 3)

^1::
     if (KMD_KommandMode == true)
          Send, #1
     else
          Send, ^1
return

#2:: RunAndFocusInMode("C:\Azteca", 3)

^2::
     if (KMD_KommandMode == true)
          Send, #2
     else
          Send, ^2
return

#3:: RunAndFocusInMode("C:\Vast", 3)

^3::
     if (KMD_KommandMode == true)
          Send, #3
     else
          Send, ^3
return

#4:: RunAndFocusInMode("C:\Downloads", 3)
#+4:: RunAndFocusInMode("C:\Files\Public", 3)

^4::
     if (KMD_KommandMode == true)
          Send, #4
     else
          Send, ^4
return

#5:: RunAndFocusInMode("C:\Kylir", 3)

#+5:: 
     EnvGet, UserProfile, USERPROFILE
     RunAndFocusInMode(UserProfile, 3)
return

^5::
     if (KMD_KommandMode == true)
          Send, #5
     else
          Send, ^5
return

#6:: RunAndFocusInMode("C:\Mindy", 3)

^6::
     if (KMD_KommandMode == true)
          Send, #6
     else
          Send, ^6
return

#7:: RunAndFocusInMode("C:\Resources", 3)

^7::
     if (KMD_KommandMode == true)
          Send, #7
     else
          Send, ^7
return

#8:: RunAndFocusInMode("C:\Application", 3)

^8::
     if (KMD_KommandMode == true)
          Send, #8
     else
          Send, ^8
return

#9:: RunAndFocusInMode("C:\Program Files (x86)", 3)
#+9:: RunAndFocusInMode("C:\Program Files", 3)

^9::
     if (KMD_KommandMode == true)
          Send, #9
     else
          Send, ^9
return

#0:: RunAndFocusInMode("Control", 3)
#+0:: RunAndFocusInMode("C:\Windows", 3)

^0::
     if (KMD_KommandMode == true)
          Send, #0
     else
          Send, ^0
return

; Letters ======================================================= ;

#a:: RunAndFocusInMode("C:\Files", 3)
;#b:: Run Highlight System Tray
#c:: RunAndFocus("C:\Program Files (x86)\Adobe\Photoshop CS4\PhotoshopPortable.exe")
;#d:: Run Reveal Desktop
;#e:: Run Computer
#+e:: RunAndFocusInMode("C:\", 3)
;#f:: Run Search
#g:: RunAndFocus("C:\Program Files (x86)\iTunes\iTunes.exe")
#h:: RunAndFocus("C:\Program Files\Windows Media Player\wmplayer.exe /prefetch:1")
#+h:: Run %SystemRoot%\system32\drivers\etc\,,UseErrorLevel ;TODO - Fix this so it uses RunAndFocus.
#i:: RunAndFocus("C:\Program Files (x86)\Pidgin\pidgin.exe")
#+i:: RunAndFocus("C:\Windows\system32\inetsrv\iis.msc")
#j:: RunAndFocusInMode("C:\Junk", 3)
#+j:: RunAndFocusInMode("C:\Junk\Projects", 3)

#k:: KMD_StartKommandMode(false)
#l::
     sleep 1000
     SendMessage, 0x112, 0xF170, 2,, Program Manager
     ;Run rundll32.exe user32.dll LockWorkStation, C:\Windows\System32,,UseErrorLevel ; Not needed because #l already locks the machine.
return

#m:: Run C:\Program Files (x86)\BasiliskII\BasiliskII.exe, C:\Program Files (x86)\BasiliskII,,UseErrorLevel
#+m:: Run C:\Program Files (x86)\BasiliskII\BasiliskIIGUI.exe, C:\Program Files (x86)\BasiliskII,,UseErrorLevel
#!m:: RunAndFocus("C:\Program Files (x86)\DOSBox-0.72\dosbox.exe -conf C:\Application\Games\dosbox.conf")
#!^m:: Run, Utilities\nomousy.exe /hide

#n::
     if WinExist("ahk_class Vim")
     {
          WinActivate
          KMD_StartInsertMode(false)
     }
     else
          RunAndFocusInMode("C:\Vim\vim72\gvim.exe", 1)
return

#+n:: RunAndFocusInMode("C:\Junk\Notes", 3)
#!n:: RunAndFocusInMode("C:\Program Files (x86)\Notepad++\notepad++.exe", 1)
#o:: RunAndFocusInMode("C:\Videos", 3)
#p:: RunAndFocusInMode("C:\Pictures", 3)

#q::
     if WinExist("ahk_class CalcFrame")
          WinActivate
     else
          RunAndFocus("C:\Windows\system32\calc.exe")
return

;#r:: Run "Open Run" dialog
#+r:: RunAndFocus("regedit")
#s:: RunAndFocusInMode("explorer.exe ftp://www.kylirhorton.com", 3)
#+s:: RunAndFocus("C:\Program Files (x86)\Allway Sync\Bin\syncappw.exe")
#t:: RunAndFocus("C:\Windows\system32\mstsc.exe")


#^t:: RunAndFocusInMode("https://secure.logmein.com/computers.asp", 1)
#u:: RunAndFocus("C:\Program Files (x86)\uTorrent\uTorrent.exe")

#v::
     if WinExist("ahk_class wndclass_desked_gsk")
     {
          WinActivate
          KMD_StartInsertMode(false)
     }
     else
          RunAndFocusInMode("C:\Program Files (x86)\Microsoft Visual Studio 9.0\Common7\IDE\devenv.exe", 1)
return

#+v::
     if WinExist("ahk_class SWT_Window0")
     {
          WinActivate
          KMD_StartInsertMode(false)
     }
     else
          RunAndFocusInMode("C:\Program Files (x86)\Eclipse\eclipse.exe", 1)
return

#!v:: RunAndFocusInMode("C:\Program Files (x86)\Adobe\Dreamweaver CS4\DreamweaverPortable.exe", 1)
;#w:: EMPTY!!!

#x::
     EnvGet, UserProfile, USERPROFILE
     RunAndFocusInMode("""C:\Program Files (x86)\Prism\prism.exe"" -override """ UserProfile "\AppData\Roaming\WebApps\k.mail@prism.app\override.ini"" -webapp k.mail@prism.app", 1)
return


#+x:: RunAndFocus("C:\Program Files (x86)\Microsoft Office\Office12\OUTLOOK.EXE /recycle")
#y:: RunAndFocus("C:\Program Files (x86)\Yahoo!\Widgets\YahooWidgets.exe")

#z::
     if WinExist("K.FOX")
     {
          WinActivate
          KMD_StartInsertMode(false)
     }
     else if WinExist("Vimperator")
     {
          WinActivate
          KMD_StartInsertMode(false)
     }
     else
          RunAndFocusInMode("C:\Program Files (x86)\Mozilla Firefox\firefox.exe", 1)
return

#+z::
     if WinExist("K.FOX")
     {
          WinActivate
          KMD_StartInsertMode(false)
     }
     else if WinExist("Vimperator")
     {
          WinActivate
          KMD_StartInsertMode(false)
     }
     else
          RunAndFocusInMode("C:\Program Files (x86)\Mozilla Firefox\firefox.exe --profilemanager", 1)
return

#!z:: RunAndFocusInMode("C:\Program Files (x86)\Mozilla Firefox\newInstance.bat", 1)

; Function Keys ================================================= ;

#F1:: Run %USERPROFILE%\AppData\Local\Google\Chrome\Application\chrome.exe,,UseErrorLevel ;TODO - Fix this so it uses RunAndFocus.
#F2:: RunAndFocusInMode("C:\Program Files (x86)\Internet Explorer\iexplore.exe", 1)
#F3:: RunAndFocusInMode("C:\Program Files (x86)\Safari\Safari.exe", 1)
#F4:: RunAndFocusInMode("C:\Program Files (x86)\Opera\Opera.exe", 1)
#F5:: RunAndFocusInMode("C:\Program Files (x86)\Microsoft Office\Office12\WINWORD.EXE", 1)
#F6:: RunAndFocusInMode("C:\Program Files (x86)\Microsoft Office\Office12\EXCEL.EXE", 1)
#F7:: RunAndFocusInMode("C:\Program Files (x86)\Microsoft Office\Office12\POWERPNT.EXE", 1)
#F8:: RunAndFocusInMode("C:\Program Files (x86)\Microsoft Office\Office12\ONENOTE.EXE", 1)
#F9:: RunAndFocus("C:\Program Files (x86)\Adobe\Illustrator CS3\Illustrator.exe")
#F10:: RunAndFocus("C:\Program Files (x86)\Adobe\Adobe InDesign CS2\InDesign.exe")
#F11:: RunAndFocus("C:\Program Files (x86)\NexusFont\NexusFont.exe")
#F12:: Reload
