start_disabled_mode(){
   Menu, Tray, Icon, %A_ScriptDir%\Images\Disabled.ico, 0, 1
}

end_disabled_mode(){
}

disabled_mode_handle_keys(key){
  KMD_Send(key)
}

disabled_mode := {}
disabled_mode["start"] := "start_disabled_mode"
disabled_mode["end"] := "end_disabled_mode"
disabled_mode["shortcut"] := "d"
disabled_mode["handle_keys"] := "disabled_mode_handle_keys"
