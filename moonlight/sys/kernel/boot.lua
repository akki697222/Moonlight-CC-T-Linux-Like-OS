local kernel = require("kernel")
local dev = require("/moonlight/lib/libdevmodehandler")
local devmode = dev.getMode()
local shellstat = require("/moonlight/lib/libshellstat")
local stat = shellstat.getStat()
local kp = {
    "[boot] shell exited on unexpected error."
}
local kp1 = {
    "[boot] Boot Failed on failed to get shell running status."
}
local kp2 = {
    "[boot] Boot Failed on failed to initilizing kernel.",
    "[kernel] kernel.err.init"
}
term.clear()
term.setCursorPos(1,1)

local sc, r = pcall(kernel.init)
    if sc then
    else
        kernel.p("Boot Failed.", "boot", kp2, r)
    end

if devmode == "true" then
    kernel.kprint("boot with devmode.", "INFO", "lime")
end
kernel.kprint("Starting moonshell...", "BOOT", "lblue")
print("")
if stat == "true" then
    error("Shell already running.", 0)
    return
elseif stat == "false" then
    shellstat.setStat("true")
    shell.run("/moonlight/shell/moonshell/shell")
    shellstat.setStat("false")
    return
else
    kernel.p("Boot Failed.", "boot", kp1, "expection.BOOT_FAILED_GET_SHELLRUNNING")
    return
end
--kernel.p("Shell Exited on unexpected error.", "boot", kp, "expection.BOOT_SHELL_EXITED")