local log = require("/moonlight/lib/liblogging")
local slog = require("/moonlight/lib/libsyslog")
local dev = require("/moonlight/lib/libdevmodehandler")
local currentDateandTime = os.date("%b %d %H:%M:%S")
local user = require("/moonlight/lib/libuserhandler")
local errort = {
    "[kernel] error in function: kernel.p error: error code argument is not table value"
}
local aliasCommands = {
    "ls", "cd", "cat", "grep", "log", "version", "su", "echo", "ccpt", "sudo", "brainpower", "help"
}

local aliasRootCommands = {
    "switchshell"
}

local kernel = {}

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

function kernel.initbin()
    for index, value in ipairs(aliasCommands) do
        shell.setAlias(value, "/moonlight/bin/" .. value)
        slog.write("Set command alias: " .. value, "Kernel")
    end
end

function kernel.initsbin()
    for index, value in ipairs(aliasRootCommands) do
        shell.setAlias(value, "/moonlight/sbin/" .. value)
        slog.write("Set root command alias: " .. value, "Kernel")
    end
end

function kernel.init()
    slog.init()
    log.init()
    slog.write("Starting System...", "Kernel")
    kernel.lprint("Starting System...", "Kernel")
    kernel.lprint("Running on Computer " .. os.getComputerID() .. ", " .. user.getComputerLabel(), "Kernel")
    kernel.kprint("Initilizing Kernel...", "WAIT", "orange")
    log.write("Initilizing Kernel...", 1)
    slog.write("Initilizing Kernel...", "Kernel")
    kernel.initbin()
    kernel.initsbin()
    kernel.kprint("Kernel Initilized.", " OK ", "lime")
end

function kernel.p(reason, vendor, code, expection)
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
        kernel.p("kernel.p code is not table value.", "kernel", errort,
            "expection.KERNEL_PANICFUNCTION_EXPECTION_NOT_TABLE_VALUE")
    end
    print("It will restart after 5 seconds...")
    sleep(5)
    shell.run("reboot")
end

return kernel
