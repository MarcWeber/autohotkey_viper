start_vi_normal_mode(){
  global vi_normal_mode
  vi_normal_mode["repeat_count"] := 0
  vi_normal_mode["mode"] := ""
  vi_normal_mode["last_chars"] := ""
}

end_vi_normal_mode(){

}


KMD_ViperDoRepeat(tosend)
{

  global vi_normal_mode
    c := vi_normal_mode["repeat_count"]
    if (c == 0)
      c := 1

    ;; guard:
    ;; should use confirmation instead
    if (c > 2000)
      c := 2000
    
    Loop %c%
    {
        S := S . tosend
    }
    KMD_Send(S)
    vi_normal_mode["repeat_count"] := 0
}

; Beide wichtige Konstanten 
WM_HSCROLL := 0x114 
WM_VSCROLL := 0x115 

; Vertikal scrollen 
SB_BOTTOM := 7 
SB_ENDSCROLL := 8 
SB_LINEDOWN := 1 
SB_LINEUP := 0 
SB_PAGEDOWN := 3 
SB_PAGEUP := 2 
SB_THUMBPOSITION := 4 
SB_THUMBTRACK := 5 
SB_TOP := 6

KMD_Scroll(a, b, amount)
{
  ; a = WM_HSCROLL or WM_VSCROLL
  ; b = one of SB_ above
  ControlGetFocus, FocusedControl, A 
  Loop %amount%
  {
    SendMessage, %a%, %b%, 0, %FocusedControl%, A  ; 0x114 is WM_HSCROLL ; 1 vs. 0 causes SB_LINEDOWN vs. UP    }
  }
}

vi_search_not_implemented(direction, word)
{
  ; direction one of -1/1 -2/2 abs(direction) > 1 means repeat.
  ; if word is "" user should be able to type in the word to search for
  MsgBox, "not implemented!"
}

; delphi 2009 implementation {{{1
vi_delphi_2009_goto_line(nr)
{
  ; Delphi yells if number is too high!
  KMD_Send("!g")
  WinWaitActive, Zu Zeilennummer gehen
  KMD_Send("{Del}" . nr . "{Del}{Enter}")
}

vi_delphi_2009_search(direction, word)
{
  global
  local requested_direction
  
  if (direction * direction == 4){
    ; repeat search
    requested_direction := round(direction / 2) * vi_normal_mode["last_search_direction"]
    s := vi_normal_mode["delphi2009-last-search-direction"]

    if (requested_direction . "" == vi_normal_mode["delphi2009-last-search-direction"] . "")
    {
      KMD_Send("{F3}")
      return
    }
    else
    {
      vi_delphi_2009_search(requested_direction, vi_normal_mode["search_chars"])
      return
    }
  }
  vi_normal_mode["delphi2009-last-search-direction"] := direction
  KMD_Send("^f")
  WinWaitActive, Text suchen
  if (direction == 1)
  {
    KMD_Send("!v")
  } else if (direction == -1)
  {
    KMD_Send("!w")
  } else
  {
    MsgBox, error search dir is %direction%
  }
  ; !c: from cursor
  ; !s: focus search input field
  KMD_Send("!c!s{Del}"+word)
  if (word != "")
  {
    ; del to remove completion
    KMD_Send("{Del}{Enter}")
  } else 
  {
    KMD_SetMode("vi_insert_mode")
  }
}

EDITOR_API()
{
  ; this function get's called whenever the window id changes
  ; some code should be added here changing implementation depending on
  ; application / window name etc.

  api := {}
  api["goto_line"] := "vi_slow_goto_line"
  api["search"] := "vi_search_not_implemented"
  
  ; DELPHI 2009 specific - because that's the app I'm using right now:
  ; TODO only asign this if the target is Delphi 2009
  api["goto_line"] := "vi_delphi_2009_goto_line"
  api["search"] := "vi_delphi_2009_search"

  return api
}

vi_slow_goto_line(nr)
{
  ; goto line
    ; this implementation of G can be optimized. Most editiors support "goto line"
    vi_normal_mode["repeat_count"] := vi_normal_mode["repeat_count"] -1
    KMD_Send("^{Home}")
    KMD_ViperDoRepeat("{Down}")
}


vi_normal_mode_handle_keys(key)
{
  ; MsgBox, %key%
  global
  local t
  local c

  WinGet, win_id, ID, A

  if (win_id != vi_normal_mode["win_id"])
  {
    local api := EDITOR_API()
  }


  ;; / ? handling. You have to type blindly
  if (vi_normal_mode["mode"] == "gather-search-chars")
  {
    if (key == "{Enter}")
    {
      Menu, Tray, Icon, %A_ScriptDir%\Images\vi_normal_mode.ico, 0, 1
      vi_normal_mode["mode"] := ""
      api["search"](vi_normal_mode["last_search_direction"], vi_normal_mode["search_chars"])
    }else
    {
      ; TODO handle +A (shift)
      vi_normal_mode["search_chars"] := vi_normal_mode["search_chars"] . key
    }
    return
  }
  if (key == "/" || key == "?")
  {
    vi_normal_mode["mode"] := "gather-search-chars"
    if (key == "/")
      vi_normal_mode["last_search_direction"] := 1
    else
      vi_normal_mode["last_search_direction"] := -1
    vi_normal_mode["search_chars"] := ""
    Menu, Tray, Icon, %A_ScriptDir%\Images\gather.ico, 0, 1
    return
  }
  if (key == "n" || key == "+n")
  {
    if (key == "n")
      api["search"](2,"")
    else
      api["search"](-2,"")
    return
  }

  if (key == "+l"){
    ; test: print location:
    KMD_Send("+^{Home}")
    clipboard = ; Emppty
    KMD_Send("^c")
    ClipWait, 2

    StringSplit, output, clipboard, `n

    output.MaxIndex()
    c_col := StrLen(output%output0%)
    api["goto_line"](output0)
    KMD_Send("{Home}")
    vi_normal_mode["repeat_count"] := c_col
    KMD_ViperDoRepeat("{Right}")
    return
  }

  if (vi_normal_mode["last_chars"] == "g")
  {
    ;; gg gT gt
    if (key == "g")
    {
      KMD_ViperDoRepeat("^{Home}")
    } else if (key == "t")
    {
      KMD_ViperDoRepeat("^{Tab}")
    } else if (key == "+t")
    {
      KMD_ViperDoRepeat("^+{Tab}")
    }
    vi_normal_mode["last_chars"] :=  ""
    return
  }

  if (key == "+g")
  {
    if (vi_normal_mode["repeat_count"] == 0){
       KMD_Send("^{End}")
    } else 
    {
      api["goto_line"](vi_normal_mode["repeat_count"])
      vi_normal_mode["repeat_count"] := 0
    }
    return
  }

  if (key == "g")
  {
      vi_normal_mode["last_chars"] := vi_normal_mode["last_chars"] . key
    return
  }
  if (key == "^d" || key="^u")
  {
      ;; I'm not sure  whether PgUp/PgDn should be used
      ;; PgUp/Don moves cursor
      if (key == "^d") 
      {
        KMD_Scroll(WM_VSCROLL, SB_PAGEDOWN, 1)
      }else if (key == "^u") 
      {
        KMD_Scroll(WM_VSCROLL, SB_PAGEUP, 1) ; scroll up
      }
      return
  }

  if (key == "n")
  {
   WinGet, FocusedControl, ID, A
    MsgBox %FocusedControl%
  }
  if (key == "z")
  {
    c := vi_normal_mode["repeat_count"] ** 2
    if c > 100
      c := 100
    vi_normal_mode["repeat_count"] := c
    KMD_ViperDoRepeat("{Up}")
    vi_normal_mode["repeat_count"] := c
    KMD_ViperDoRepeat("{Down}")
    vi_normal_mode["repeat_count"] := c
    KMD_ViperDoRepeat("{Down}")
    vi_normal_mode["repeat_count"] := c
    KMD_ViperDoRepeat("{Up}")
    return
  }

  if (key == "0" && vi_normal_mode["repeat_count"] == 0)
  {
    KMD_Send("{Home}")
    return
  }
  if (key == 0 || key == 1 || key == 2 || key == 3 || key == 4 || key == 5 || key == 6 || key == 7 || key == 8 || key == 9)
  {
    vi_normal_mode["repeat_count"] := vi_normal_mode["repeat_count"] * 10 + key
    return
  }

  if (vi_normal_mode["last_chars"] == "d"){
    if (key == "d"){
      KMD_Send("{Home}+{Down}")
    }
    else if (key == "j"){
      KMD_Send("{Home}+{Down}")
      KMD_ViperDoRepeat("+{Down}")
    }
    else if (key == "k"){
      KMD_Send("{Home}{Down}+{Up}")
      KMD_ViperDoRepeat("+{Up}")
    }
    KMD_Send("{Del}")
    vi_normal_mode["last_chars"] := ""
    return
  }
  if (key == "d"){
    vi_normal_mode["last_chars"] := "d"
    return
  }


  if (vi_normal_mode["simple_commands"].HasKey(key)) 
  {
    KMD_ViperDoRepeat(vi_normal_mode["simple_commands"][key])
    return
  }
  if (vi_normal_mode["goto_insert_mode"].HasKey(key))
  {
    KMD_ViperDoRepeat(vi_normal_mode["goto_insert_mode"][key])
    KMD_SetMode("vi_insert_mode")
    return
  }

  ; drop repeat count
  vi_normal_mode["repeat_count"] := 0
  vi_normal_mode["last_chars"] := ""
  KMD_Send(key)
}


vi_normal_mode := {}
vi_normal_mode["start"] := "start_vi_normal_mode"
vi_normal_mode["end"] := "end_vi_normal_mode"
vi_normal_mode["shortcut"] := "v"
vi_normal_mode["repeat_count"] := 0
vi_normal_mode["handle_keys"] := "vi_normal_mode_handle_keys"

vi_normal_mode["simple_commands"] := {}
vi_normal_mode["simple_commands"]["h"] := "{Left}"
vi_normal_mode["simple_commands"]["j"] := "{Down}"
vi_normal_mode["simple_commands"]["k"] := "{Up}"
vi_normal_mode["simple_commands"]["l"] := "{Right}"

vi_normal_mode["simple_commands"]["w"] := "^{Right}"
vi_normal_mode["simple_commands"]["e"] := "^{Right}{Left}"
vi_normal_mode["simple_commands"]["b"] := "^{Left}"

vi_normal_mode["simple_commands"]["x"] := "{Del}"
vi_normal_mode["simple_commands"]["+x"] := "{BS}"
vi_normal_mode["simple_commands"]["+d"] := "+{END}{Del}"

vi_normal_mode["simple_commands"]["$"]  := "{END}"
; vi_normal_mode["simple_commands"]["^u"] := "{PgUp}"
; vi_normal_mode["simple_commands"]["^d"] := "{PgDn}"
vi_normal_mode["simple_commands"]["u"]  := "^z"
vi_normal_mode["simple_commands"]["{Enter}"]  := "{Home}{Down}"
vi_normal_mode["simple_commands"]["-"]  := "{Home}{Up}"

vi_normal_mode["goto_insert_mode"] := {}
vi_normal_mode["goto_insert_mode"]["o"] := "{End}{Enter}"
vi_normal_mode["goto_insert_mode"]["+o"] := "{Up}{End}{Enter}"
vi_normal_mode["goto_insert_mode"]["i"] := ""
vi_normal_mode["goto_insert_mode"]["+i"] := "{Home}"
vi_normal_mode["goto_insert_mode"]["a"] := "{Right}"
vi_normal_mode["goto_insert_mode"]["+a"] := "{End}"
vi_normal_mode["goto_insert_mode"]["+c"] := "+{End}{Del}"

; vi_normal_mode["app_depending_commands"] := {}
; vi_normal_mode["app_depending_commands"]["CodeGear"] := {}
; vi_normal_mode["app_depending_commands"]["CodeGear"]["/"] := {}
; vi_normal_mode["app_depending_commands"]["CodeGear"]["?"] := {}

KMD_ViperRepeatCount := 0
