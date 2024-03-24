local log = require("/moonlight/lib/liblogging")
local slog = require("/moonlight/lib/libsyslog")
local ver = require("/moonlight/proc/vinfo")
local dev = require("/moonlight/lib/libdevmodehandler")
local currentDateandTime = os.date("%b %d %H:%M:%S")
local user = require("/moonlight/lib/libuserhandler")

--[[
    You can add the name of the command you want to add here.
    If you add a command, it must have the same name as the additional command in `/bin` (`.lua` is not needed as the kernel will complete it for you!)
]]
local aliasCommands = {
    "ls", "cd", "cat", "grep", "log", "version", "su", "echo", "ccpt", "sudo", "brainpower", "help"
}

local aliasRootCommands = {
    "switchshell"
}

local kernel = {}

function kernel.panic(reason, vendor, code, expection)
    term.clear()
    term.setCursorPos(1, 1)
    term.setTextColor(colors.white)
    print("Kernel panic - " .. vendor .. ": " .. reason)
    print(expection)
    if type(code) == "table" then
        for _, errorInfo in ipairs(code) do
            print(errorInfo)
        end
    else
        kernel.p("kernel.p code is not table value.", "kernel", {"[kernel] error in function: `kernel.panic()` error: code argument is not table value."},"expection.KERNEL_PANICFUNC_NOT_TABLE_VALUE")
    end
    print("It will restart after 5 seconds...")
    sleep(5)
    shell.run("reboot")
end

function kernel.p(reason, vendor, code, expection) -- Don't using!! It will be deleted in the future.
    kernel.panic(reason, vendor, code, expection)
end

function kernel.lprint(message, vendor)
    print("[" .. currentDateandTime .. "] " .. vendor .. ": " .. message)
end

function kernel.kprint(message, stat, tcolor)
    io.write("[  ")
    if tcolor == "lime" then
        term.setTextColor(colors.lime)
    elseif tcolor == "orange" then
        term.setTextColor(colors.orange)
    elseif tcolor == "lblue" then
        term.setTextColor(colors.lightBlue)
    else
        term.setTextColor(colors.red)
        print("tcolor arg expected")
        term.setTextColor(colors.white)
    end
    io.write(stat)
    term.setTextColor(colors.white)
    io.write("  ] ")
    io.write(message)
    print("")
end

function kernel.setaliasbin()
    for index, value in ipairs(aliasCommands) do
        shell.setAlias(value, "/moonlight/bin/" .. value)
        slog.write("Set command alias: " .. value, "Kernel")
    end
end

function kernel.setaliassbin()
    for index, value in ipairs(aliasRootCommands) do
        shell.setAlias(value, "/moonlight/sbin/" .. value)
        slog.write("Set root command alias: " .. value, "Kernel")
    end
end

function kernel.setcustomalias(name, path)-- `/` is required at the beginning of the path. Example: /moonlight/bin
    local s, r = pcall(shell.setAlias(name, path .."/".. name))
    if s then
        kernel.panic("Error setting custom alias.", "Kernel", {"[Kernel] Expection: error setting custom alias."}, r)
    else
    end
end

function kernel.init()
    slog.write("Moonlight version Linux"..ver.getSysVer(), "System")
    print("Moonlight version Linux"..ver.getSysVer())
    slog.init()
    log.init()
    slog.write("Starting System...", "Kernel")
    kernel.lprint("Starting System...", "Kernel")
    kernel.lprint("Running on Computer " .. os.getComputerID() .. ", " .. user.getComputerLabel(), "Kernel")
    kernel.kprint("Initilizing Kernel...", "WAIT", "orange")
    log.write("Initilizing Kernel...", 1)
    slog.write("Initilizing Kernel...", "Kernel")
    kernel.setaliasbin()
    kernel.setaliassbin()
    kernel.kprint("Kernel Initilized.", " OK ", "lime")
end

return kernel
