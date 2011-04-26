start_vi_normal_mode(){
  global vi_normal_mode
  vi_normal_mode["repeat_count"] := 0
}

end_vi_normal_mode(){

}

KMD_ViperDoRepeat(tosend)
{

  global vi_normal_mode
    c := vi_normal_mode["repeat_count"]
    if (c == 0)
      c := 1
    
    Loop %c%
    {
        S := S . tosend
    }
    KMD_Send(S)
    vi_normal_mode["repeat_count"] := 0
}

vi_normal_mode_handle_keys(key){
  ; MsgBox, %key%
  global vi_normal_mode

  ;; gg
  if (key == "g"){
    if (vi_normal_mode["last_chars"] == "g"){
      vi_normal_mode["last_chars"] :=  ""
      KMD_Send("^{Home}")
      return
    } else
      vi_normal_mode["last_chars"] := vi_normal_mode["last_chars"] . key
      return
  }

  if (key == "0" && vi_normal_mode["repeat_count"] == 0)
  {
    KMD_Send("{Home}")
    return
  } else if (key == 0 || key == 1 || key == 2 || key == 3 || key == 4 || key == 5 || key == 6 || key == 7 || key == 8 || key == 9)
  {
    vi_normal_mode["repeat_count"] := vi_normal_mode["repeat_count"] * 10 + key
    return
  } else if (vi_normal_mode["simple_commands"].HasKey(key)) {
    KMD_ViperDoRepeat(vi_normal_mode["simple_commands"][key])
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
vi_normal_mode["simple_commands"]["h" ] := "{Left}"
vi_normal_mode["simple_commands"]["j" ] := "{Down}"
vi_normal_mode["simple_commands"]["k" ] := "{Up}"
vi_normal_mode["simple_commands"]["l" ] := "{Right}"

vi_normal_mode["simple_commands"]["w" ] := "^{Right}"
vi_normal_mode["simple_commands"]["e" ] := "^{Right}{Left}"
vi_normal_mode["simple_commands"]["b" ] := "^{Left}"

vi_normal_mode["simple_commands"]["$" ]  := "{END}"
vi_normal_mode["simple_commands"]["^u" ] := "{PgUp}"
vi_normal_mode["simple_commands"]["^d" ] := "{PgDn}"
vi_normal_mode["simple_commands"]["+g" ] := "^{End}"
vi_normal_mode["simple_commands"]["u" ]  := "^z"


; vi_normal_mode["app_depending_commands"] := {}
; vi_normal_mode["app_depending_commands"]["CodeGear"] := {}
; vi_normal_mode["app_depending_commands"]["CodeGear"]["/"] := {}
; vi_normal_mode["app_depending_commands"]["CodeGear"]["?"] := {}

KMD_ViperRepeatCount := 0
