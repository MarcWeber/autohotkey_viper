;
; CoreHotkeys.ahk
; Version: 0.4
; Last Updated: 11/5/2009
;
; This file contains all of the core keybindings for Kommand.
;

KMD_IS_VIPER(){
    global KMD_ViperMode
    WinGetTitle, Title, A
    FoundPos := RegExMatch(Title, "GVIM")
    return KMD_ViperMode == true && FoundPos != ""
}

KMD_ViperRepeat(digit)
{
    global KMD_ViperRepeatCount
    KMD_ViperRepeatCount := 10 * KMD_ViperRepeatCount + digit
}

KMD_ViperDoRepeat(tosend)
{
    global KMD_ViperRepeatCount
    if KMD_ViperRepeatCount = 0
      KMD_ViperRepeatCount:=1

    Loop %KMD_ViperRepeatCount%
    {
        Send, %tosend%
    }
    KMD_ViperRepeatCount:=0
}


; Modifiers Keys ================================================== ;

#UseHook on

CapsLock::
     if (KMD_Enabled == true)
          Send, {Esc}
     else
          SetCapsLockState, % GetKeyState( "CapsLock", "T" ) ? "OFF" : "ON"
return

#UseHook off

+Capslock:: SetCapsLockState, % GetKeyState( "CapsLock", "T" ) ? "OFF" : "ON"

r::
    if KMD_KommandMode == true
	reload
    else
	Send r
return

#CapsLock::
     if (KMD_Enabled == true)
          if (KMD_Enabled == true)
          {
               if (KMD_IS_VIPER())
                    KMD_StartKommandMode(false)
               else if (KMD_InsertMode == true)
                    KMD_StartViperMode(false)
          }
     else
          SetCapsLockState, % GetKeyState( "CapsLock", "T" ) ? "OFF" : "ON"
return

#Esc::
     if (KMD_Enabled == true)
          KMD_Disable(false)
     else
          KMD_Enable(false)
return

; Special Characters ============================================ ;

#UseHook on

$::
     if (KMD_IS_VIPER())
          Send, {End}
     else
          Send, $
return

Tab::
     if (KMD_KommandMode == true)
          Send, {Alt down}{Tab}{Alt up}
     else
          Send, {Tab}
return

; Numbers ======================================================= ;


0::
     if (KMD_IS_VIPER()){
	if (KMD_ViperRepeat > 0)
		KMD_ViperRepeat(0)
	else
          Send, {Home}
     } else
          Send, 0
return

1::
2::
3::
4::
5::
6::
7::
8::
9::
	if (KMD_IS_VIPER()){
		KMD_ViperRepeat(A_ThisHotkey)
	} else {
	    Send, %A_ThisHotkey%
	}
        
return

; Letters ======================================================= ;

a::
     if (KMD_IS_VIPER())
     {
          if (WinActive("ahk_class CabinetWClass"))
               Send, ^+n
          else
          {
               KMD_ViperDoRepeat("{Right}")
               KMD_StartInsertMode(true)
          }
     }
     else
          Send, a
return

+a::
     if (KMD_IS_VIPER())
     {
          Send, {End}
          KMD_StartInsertMode(true)
     }
     else
          Send, +a
return 

b::

     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("^{Left}")
     else
          Send, b
return

^b::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Page down}")
     else if (KMD_KommandMode == true)
     {
          WinSet, AlwaysOnTop, Off, A
          WinSet, Bottom,, A
     }
     else
          Send, ^b
return

+c::
     if (KMD_IS_VIPER())
     {
          KMD_ViperDoRepeat("{Shift down}{End}{Delete}")
          KMD_StartInsertMode(true)
     }
     else
          Send, +c
return

d::
     if ((KMD_IS_VIPER()) && (WinActive("ahk_class CabinetWClass")))
          KMD_ViperDoRepeat("{Delete}")
     else if (KMD_KommandMode == true)
          WinClose A
     else
          Send, d
return

+d::
     if (KMD_KommandMode == true)
          Run Utilities\CloseWindows.exe,,UseErrorLevel
     else
          Send, +d
return

^d::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Page down}")
     else
          Send ^d
return

^f::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Page down}")
     else if (KMD_KommandMode == true)
		WinSet, AlwaysOnTop, Toggle, A
     else
          Send, ^f
return

h::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Left}")
     else if (KMD_KommandMode == true)
          WindowPadMove("-1,  0,  0.5, 1.0")
     else
          Send, h
return

+h::
     if ((KMD_IS_VIPER()) && WinActive("ahk_class CabinetWClass"))
          Send, !{Left}
     else if (KMD_KommandMode == true)
          WinMaximize, A
     else
          Send, +h
return

i::
     if ((KMD_IS_VIPER()) OR (KMD_KommandMode == true))
          KMD_StartInsertMode(true)
     else
          Send, i
return

+i::
     if (KMD_IS_VIPER())
     {
          KMD_ViperDoRepeat("{Home}")
          KMD_StartInsertMode(true)
     }
     else
          Send, +i
return

j::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Down}")
     else if (KMD_KommandMode == true)
          WindowPadMove("0, +1,  1.0, 0.5")
     else
          Send, j
return

+j::
     if ((KMD_IS_VIPER()) && (WinActive("ahk_class CabinetWClass")))
          KMD_ViperDoRepeat("{Enter}")
     else
          Send, +j
return

k::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Up}")
     else if (KMD_KommandMode == true)
          WindowPadMove("0, -1,  1.0, 0.5")
     else
          Send, k
return

+k::
     if ((KMD_IS_VIPER()) && (WinActive("ahk_class CabinetWClass")))
          KMD_ViperDoRepeat("!{Up}")
     else
          Send, +k
return

^k::
     if (KMD_IS_VIPER())
          KMD_StartKommandMode(false)
     else
          Send, ^k
return

l::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Right}")
     else if (KMD_KommandMode == true)
          WindowPadMove("+1,  0,  0.5, 1.0")
     else
          Send, l
return

+l::
     if ((KMD_IS_VIPER()) && (WinActive("ahk_class CabinetWClass")))
          KMD_ViperDoRepeat("!{Right}")
     if (KMD_KommandMode == true)
          WinMinimize, A
     else
          Send, +l
return

^l::
     if (KMD_KommandMode == true)
     {
          if WinExist(GetLastMinimizedWindow())
               WinRestore
     }
     else
          Send, ^l
return

+m::
     if (KMD_KommandMode == true)
          MaximizeToggle(A)
     else
          Send, +m
return

^n::
     if (KMD_KommandMode == true)
          Send, #t
     else
          Send, ^n
return

o::
     if (KMD_IS_VIPER())
     {
          Send, {End}{Enter}
          KMD_StartInsertMode(true)
	  KMD_ViperRepeatCount := 0
     }
     else if (KMD_KommandMode == true)
          WindowScreenMove(Next)
     else
          Send, o
return

+o::
     if (KMD_IS_VIPER())
     {
          Send, {Home}{Enter}{Up}
          KMD_StartInsertMode(true)
	  KMD_ViperRepeatCount := 0
     }
     else if (KMD_KommandMode == true)
          WindowScreenMove(Next)
     else
          Send, +o
return

^p::
     if (KMD_KommandMode == true)
          Send, #+t
     else
          Send, ^p
return

s::
     if (KMD_IS_VIPER())
     {
          Send, {Delete}
          KMD_StartInsertMode(true)
	  KMD_ViperRepeatCount := 0
     }
     else
          Send, s
return

+s::
     if (KMD_IS_VIPER())
     {
          Send, {End}{Shift down}{Home}{Shift up}{Delete}
          KMD_StartInsertMode(true)
	  KMD_ViperRepeatCount := 0
     }
     else
          Send, +s
return

^t::
     if (KMD_KommandMode == true)
     {
          WinGet, Transparent, Transparent, A
          if (Transparent = 120)
               WinSet, Transparent, 255, A
          else
               WinSet, Transparent, 120, A
     }
     else
          Send, ^t
return

u::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("^z")
     else
          Send, u
return

^u::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Page up}")
     else
          Send, ^u
return

v::
     if (KMD_KommandMode == true)
          KMD_StartViperMode(false)
     else
          Send, v
return

^v::
     if (KMD_KommandMode == true)
          KMD_StartViperMode(false)
     else
          Send, ^v
return

w::
     if (KMD_IS_VIPER())
     {
          if (WinActive("ahk_class CabinetWClass"))
          {
               RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden

               if HiddenFiles_Status = 2
                    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
               else
                    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2

               WinGetClass, eh_Class, A
               if (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA")
                    SendInput, {F5}
               else
                    PostMessage, 0×111, 28931,,, A
          }
          else
               KMD_ViperDoRepeat("{Right}")
     }
     else
          KMD_ViperDoRepeat("w")
return

x::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Delete}")
     else
          Send, x
return

+x::
     if (KMD_IS_VIPER())
          KMD_ViperDoRepeat("{Backspace}")
     else
          Send, +x
return

#UseHook, off
