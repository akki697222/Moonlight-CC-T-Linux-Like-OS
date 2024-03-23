local kernel = require("kernel")
local dev = require("/moonlight/lib/libdevmodehandler")
local devmode = dev.getMode()
local kp = {
    "[boot] shell exited on unexpected error."
}
term.clear()
term.setCursorPos(1,1)

kernel.init()

if devmode == "true" then
    kernel.kprint("boot with devmode.", "INFO", "lime")
end
kernel.kprint("Starting moonshell...", "BOOT", "lblue")
print("")
shell.run("/moonlight/shell/moonshell/shell")
--kernel.p("Shell Exited on unexpected error.", "boot", kp, "expection.BOOT_SHELL_EXITED")