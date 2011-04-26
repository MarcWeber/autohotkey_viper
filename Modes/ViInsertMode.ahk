start_vi_insert_mode(){
  global vi_insert_mode
  vi_insert_mode["repeat_count"] := 0
}

end_vi_insert_mode(){

}

vi_insert_mode_handle_keys(key){
  ; MsgBox, %key%
  global vi_insert_mode

  if (vi_insert_mode["simple_commands"].HasKey(key)) {
    KMD_ViperDoRepeat(vi_insert_mode["simple_commands"][key])
    return
  }

  ; drop repeat count
  vi_insert_mode["repeat_count"] := 0
  vi_insert_mode["last_chars"] := ""
  KMD_Send(key)
}

vi_insert_mode := {}
vi_insert_mode["start"] := "start_vi_insert_mode"
vi_insert_mode["end"] := "end_vi_insert_mode"
vi_insert_mode["shortcut"] := "v"
vi_insert_mode["repeat_count"] := 0
vi_insert_mode["handle_keys"] := "vi_insert_mode_handle_keys"

vi_insert_mode["simple_commands"] := {}
; vi_insert_mode["simple_commands"]["^w"] := ""
