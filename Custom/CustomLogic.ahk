;
; CustomLogic.ahk
;
; This file contains logic. Do not put keybindings in this file as they will break stuff.
;

ShowMessage("KOMMAND", "Welcome to Kommand", "Kommand.png") ; Show a custom Snarl message.
KMD_Silent = true ; Turn off Snarl messages.

; Disable Kommand's window keybindings on wife's machine.
if (A_ComputerName = "JENIVICE")
     KMD_Disable(true)
