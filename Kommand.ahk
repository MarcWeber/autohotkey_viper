;||=================================||;
;||                                 ||;
;||          -= KOMMAND =-          ||;
;||                                 ||;
;||=================================||;

;
; Kommand.ahk
; Version: 0.3
; Last Updated: 11/5/2009
; Author: Kylir Horton <kylirh@gmail.com>
; Website: http://www.kylirhorton.com/kommand
;
; This is the main executable file for Kommand. All other files are loaded from
; this one and some basic functions and global variables are defined.
;
; Mon Apr 25 05:23:15 CEST 2011
; heavily modified by Marc Weber:
; Vi: support running actions n times
; refactor modes to make code more scalable and more maintainable


#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, Force ; Make sure there is only one instance of Kommand running at a time.
#WinActivateForce ; Forces windows to appear when they're called.


; include modes
#Include Modes\Disabled.ahk
#Include Modes\Vi.ahk

; Initialize Kommand and load custom logic and supporting functions.
KMD_Init()
; #Include Custom\CustomLogic.ahk
; #Include Scripts\WindowPad.ahk

; Initialize the script and load hotkeys.
; KMD_ComponentInit(false)
; #Include Scripts\CoreHotkeys.ahk
; #Include Custom\CustomHotkeys.ahk


return

KMD_Init()
{
     global
     DetectHiddenWindows, on ; Be able to find hidden windows.
     SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
     SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
     SetBatchlines, -1 ; Make the script run as fast as possible.
     SetKeyDelay, -1 ; Make sure it is fast!

     KMD_SENDING := 0

     KMD_Modes := Object()

     KMD_Modes["vi_normal_mode"] := vi_normal_mode
     KMD_Modes["disabled"] := disabled_mode

     KMD_Mode := "disabled"
     start_disabled_mode()
}

KMD_Send(keys)
{
  global KMD_SENDING
  KMD_SENDING :=1
  Send, %keys%
  KMD_SENDING :=0
}

KMD_SetMode(mode){
  global KMD_Mode

  if KMD_Mode != ""
    KMD_Modes[KMD_Mode]["end"]()

  ; set early so that "start" can switch mode again
  KMD_Mode := mode
  KMD_Modes[mode]["start"]()
  Menu, Tray, Icon, %A_ScriptDir%\Images\%mode%.ico, 0, 1
}
    
ShowMessage(title, message, icon)
{
  Run Utilities\SnarlCMD.exe snShowMessage 5 "%title%" "%message%" "%A_ScriptDir%\Images\%icon%",,UseErrorLevel
}


Capslock::
  if (KMD_Mode != "disabled") {
    KMD_SetMode("disabled")
  } else {
    ; set / toggle mode depending on Window?
    KMD_SetMode("vi_normal_mode")
  }
return

; Boy this is insane!
; But its the onlsy modular way which came to my mind!

#if (KMD_SENDING == 0)

0::
  KMD_Modes[KMD_Mode]["handle_keys"]("0")
return
1::
  KMD_Modes[KMD_Mode]["handle_keys"]("1")
return
2::
  KMD_Modes[KMD_Mode]["handle_keys"]("2")
return
3::
  KMD_Modes[KMD_Mode]["handle_keys"]("3")
return
4::
  KMD_Modes[KMD_Mode]["handle_keys"]("4")
return
5::
  KMD_Modes[KMD_Mode]["handle_keys"]("5")
return
6::
  KMD_Modes[KMD_Mode]["handle_keys"]("6")
return
7::
  KMD_Modes[KMD_Mode]["handle_keys"]("7")
return
8::
  KMD_Modes[KMD_Mode]["handle_keys"]("8")
return
9::
  KMD_Modes[KMD_Mode]["handle_keys"]("9")
return

$::
  KMD_Modes[KMD_Mode]["handle_keys"]("$")
return

a::
  KMD_Modes[KMD_Mode]["handle_keys"]("a")
return
b::
  KMD_Modes[KMD_Mode]["handle_keys"]("b")
return
c::
  KMD_Modes[KMD_Mode]["handle_keys"]("c")
return
d::
  KMD_Modes[KMD_Mode]["handle_keys"]("d")
return
e::
  KMD_Modes[KMD_Mode]["handle_keys"]("e")
return
f::
  KMD_Modes[KMD_Mode]["handle_keys"]("f")
return
g::
  KMD_Modes[KMD_Mode]["handle_keys"]("g")
return
h::
  KMD_Modes[KMD_Mode]["handle_keys"]("h")
return
i::
  KMD_Modes[KMD_Mode]["handle_keys"]("i")
return
j::
  KMD_Modes[KMD_Mode]["handle_keys"]("j")
return
k::
  KMD_Modes[KMD_Mode]["handle_keys"]("k")
return
l::
  KMD_Modes[KMD_Mode]["handle_keys"]("l")
return
m::
  KMD_Modes[KMD_Mode]["handle_keys"]("m")
return
n::
  KMD_Modes[KMD_Mode]["handle_keys"]("n")
return
o::
  KMD_Modes[KMD_Mode]["handle_keys"]("o")
return
p::
  KMD_Modes[KMD_Mode]["handle_keys"]("p")
return
q::
  KMD_Modes[KMD_Mode]["handle_keys"]("q")
return
r::
  KMD_Modes[KMD_Mode]["handle_keys"]("r")
return
s::
  KMD_Modes[KMD_Mode]["handle_keys"]("s")
return
t::
  KMD_Modes[KMD_Mode]["handle_keys"]("t")
return
u::
  KMD_Modes[KMD_Mode]["handle_keys"]("u")
return
v::
  KMD_Modes[KMD_Mode]["handle_keys"]("v")
return
w::
  KMD_Modes[KMD_Mode]["handle_keys"]("w")
return
x::
  KMD_Modes[KMD_Mode]["handle_keys"]("x")
return
y::
  KMD_Modes[KMD_Mode]["handle_keys"]("y")
return
z::
  KMD_Modes[KMD_Mode]["handle_keys"]("z")
return

+a::
  KMD_Modes[KMD_Mode]["handle_keys"]("+a")
return
+b::
  KMD_Modes[KMD_Mode]["handle_keys"]("+b")
return
+c::
  KMD_Modes[KMD_Mode]["handle_keys"]("+c")
return
+d::
  KMD_Modes[KMD_Mode]["handle_keys"]("+d")
return
+e::
  KMD_Modes[KMD_Mode]["handle_keys"]("+e")
return
+f::
  KMD_Modes[KMD_Mode]["handle_keys"]("+f")
return
+g::
  KMD_Modes[KMD_Mode]["handle_keys"]("+g")
return
+h::
  KMD_Modes[KMD_Mode]["handle_keys"]("+h")
return
+i::
  KMD_Modes[KMD_Mode]["handle_keys"]("+i")
return
+j::
  KMD_Modes[KMD_Mode]["handle_keys"]("+j")
return
+k::
  KMD_Modes[KMD_Mode]["handle_keys"]("+k")
return
+l::
  KMD_Modes[KMD_Mode]["handle_keys"]("+l")
return
+m::
  KMD_Modes[KMD_Mode]["handle_keys"]("+m")
return
+n::
  KMD_Modes[KMD_Mode]["handle_keys"]("+n")
return
+o::
  KMD_Modes[KMD_Mode]["handle_keys"]("+o")
return
+p::
  KMD_Modes[KMD_Mode]["handle_keys"]("+p")
return
+q::
  KMD_Modes[KMD_Mode]["handle_keys"]("+q")
return
+r::
  KMD_Modes[KMD_Mode]["handle_keys"]("+r")
return
+s::
  KMD_Modes[KMD_Mode]["handle_keys"]("+s")
return
+t::
  KMD_Modes[KMD_Mode]["handle_keys"]("+t")
return
+u::
  KMD_Modes[KMD_Mode]["handle_keys"]("+u")
return
+v::
  KMD_Modes[KMD_Mode]["handle_keys"]("+v")
return
+w::
  KMD_Modes[KMD_Mode]["handle_keys"]("+w")
return
+x::
  KMD_Modes[KMD_Mode]["handle_keys"]("+x")
return
+y::
  KMD_Modes[KMD_Mode]["handle_keys"]("+y")
return
+z::
  KMD_Modes[KMD_Mode]["handle_keys"]("+z")
return

; Does not work :-( try alt-d in notepad!
; !a::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!a")
; return
; !b::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!b")
; return
; !c::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!c")
; return
; !d::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!d")
; return
; !e::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!e")
; return
; !f::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!f")
; return
; !g::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!g")
; return
; !h::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!h")
; return
; !i::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!i")
; return
; !j::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!j")
; return
; !k::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!k")
; return
; !l::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!l")
; return
; !m::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!m")
; return
; !n::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!n")
; return
; !o::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!o")
; return
; !p::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!p")
; return
; !q::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!q")
; return
; !r::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!r")
; return
; !s::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!s")
; return
; !t::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!t")
; return
; !u::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!u")
; return
; !v::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!v")
; return
; !w::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!w")
; return
; !x::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!x")
; return
; !y::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!y")
; return
; !z::
;   KMD_Modes[KMD_Mode]["handle_keys"]("!z")
; return

^a::
  KMD_Modes[KMD_Mode]["handle_keys"]("^a")
return
^b::
  KMD_Modes[KMD_Mode]["handle_keys"]("^b")
return
^c::
  KMD_Modes[KMD_Mode]["handle_keys"]("^c")
return
^d::
  KMD_Modes[KMD_Mode]["handle_keys"]("^d")
return
^e::
  KMD_Modes[KMD_Mode]["handle_keys"]("^e")
return
^f::
  KMD_Modes[KMD_Mode]["handle_keys"]("^f")
return
^g::
  KMD_Modes[KMD_Mode]["handle_keys"]("^g")
return
^h::
  KMD_Modes[KMD_Mode]["handle_keys"]("^h")
return
^i::
  KMD_Modes[KMD_Mode]["handle_keys"]("^i")
return
^j::
  KMD_Modes[KMD_Mode]["handle_keys"]("^j")
return
^k::
  KMD_Modes[KMD_Mode]["handle_keys"]("^k")
return
^l::
  KMD_Modes[KMD_Mode]["handle_keys"]("^l")
return
^m::
  KMD_Modes[KMD_Mode]["handle_keys"]("^m")
return
^n::
  KMD_Modes[KMD_Mode]["handle_keys"]("^n")
return
^o::
  KMD_Modes[KMD_Mode]["handle_keys"]("^o")
return
^p::
  KMD_Modes[KMD_Mode]["handle_keys"]("^p")
return
^q::
  KMD_Modes[KMD_Mode]["handle_keys"]("^q")
return
^r::
  KMD_Modes[KMD_Mode]["handle_keys"]("^r")
return
^s::
  KMD_Modes[KMD_Mode]["handle_keys"]("^s")
return
^t::
  KMD_Modes[KMD_Mode]["handle_keys"]("^t")
return
^u::		
  KMD_Modes[KMD_Mode]["handle_keys"]("^u")
return
^v::
  KMD_Modes[KMD_Mode]["handle_keys"]("^v")
return
^w::
  KMD_Modes[KMD_Mode]["handle_keys"]("^w")
return
^x::
  KMD_Modes[KMD_Mode]["handle_keys"]("^x")
return
^y::
  KMD_Modes[KMD_Mode]["handle_keys"]("^y")
return
^z::
  KMD_Modes[KMD_Mode]["handle_keys"]("^z")
return
