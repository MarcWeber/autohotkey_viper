rem This script runs continuously in order to keep the script engine loaded.
rem Run the script "ScriptEngineCache-Stop.vbs" in order to make -this- script exit.

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
const REG_VALUE_FLAG = "1"
const MILLISECONDS_TO_SLEEP = 5000


' Variables
dim Shell, RegValue


' Init
set Shell = WScript.CreateObject("WScript.Shell")


' Write "stay active" flag
Shell.RegWrite REG_KEY , REG_VALUE_FLAG, "REG_SZ"


' Loop
do
	Wscript.Sleep MILLISECONDS_TO_SLEEP
	RegValue = Shell.RegRead(REG_KEY)
loop while RegValue = REG_VALUE_FLAG


' Done; clean up
Shell.RegDelete REG_KEY
set Shell = nothing


rem End of script.
