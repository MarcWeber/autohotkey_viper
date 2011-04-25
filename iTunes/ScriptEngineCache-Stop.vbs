rem Another script (ScriptEngineCache-Start.vbs) runs continuously in order to keep the script engine loaded.
rem Run -this- script (ScriptEngineCache-Stop.vbs) in order to make the other script exit.

rem Modifying this script:
rem You can change the MILLISECONDS_TO_SLEEP value to specify a different number of milliseconds
rem to sleep.  (1000 milliseconds equals 1 second.)  The value doesn't matter much, as the overhead
rem incurred when this script runs is minimal.  You can even drop the value to 1000 or lower and
rem you won't be able to see any performance impact on your system.  The initial value of 5000
rem (ie, 5 seconds) was chosen because it seems more 'polite' but in fact a much lower value
rem would have the same (minimal) impact on your system.

rem Copyright 2004 Maximized Software, Inc.  All rights reserved.
rem More info is available at:  http://www.maximized.com/freeware/ScriptsForiTunes/
rem Version 2004-12-09-1


' Constants
const REG_KEY = "HKCU\Software\Microsoft\Windows Script Host\Settings\ScriptEngineCache-VbScript"


' Variables
dim Shell


' Init
set Shell = WScript.CreateObject("WScript.Shell")


' Clear the "stay active" flag
Shell.RegWrite REG_KEY, "", "REG_SZ"


' Done; clean up
set Shell = nothing


rem End of script.
