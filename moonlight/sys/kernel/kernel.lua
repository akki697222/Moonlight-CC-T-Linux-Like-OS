local log = require("/moonlight/lib/liblogging")
local slog = require("/moonlight/lib/libsyslog")
local dev = require("/moonlight/lib/libdevmodehandler")
local currentDateandTime = os.date("%b %d %H:%M:%S")
local errort = {
    "[kernel] error in function: kernel.p error: error code argument is not table value"
}
local aliasCommands = {
    "ls", "cd", "cat", "grep", "log", "version", "switchshell", "su", "echo", "ccpt", "sudo"
}

local kernel = {}

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

function kernel.init()
    slog.init()
    log.init()
    slog.write("Starting System...", "Kernel")
    print("[" .. currentDateandTime .. "] Kernel: Starting System...")
    kernel.kprint("Initilizing Kernel...", "WAIT", "orange")
    log.write("Initilizing Kernel...", 1)
    slog.write("Initilizing Kernel...", "Kernel")

    shell.setAlias("list", "/moonlight/bin/ls")
    shell.setAlias("dir", "/moonlight/bin/ls")
    for index, value in ipairs(aliasCommands) do
        shell.setAlias(value, "/moonlight/bin/" .. value)
        slog.write("Set Alias: " .. value, "Kernel")
    end
    kernel.kprint("Kernel Initilized.", " OK ", "lime")
    return
end

function kernel.a()

end

function kernel.shellStandAlone()
    kernel.init()
    shell.run("/moonlight/shell/moonshell/shell")
    return
end

function kernel.p(reason, vendor, code, expection)
    term.clear()
    term.setCursorPos(1,1)
    print("Kernel panic - " .. vendor .. ": " .. reason)
    print(expection)
    if type(code) == "table" then
        for _, errorInfo in ipairs(code) do
            print(errorInfo)
        end
    else
        kernel.p("kernel.p code is not table value.", "kernel", errort, "expection.KERNEL_PANICFUNCTION_EXPECTION_NOT_TABLE_VALUE")
    end
    print("It will restart after 5 seconds...")
    sleep(5)
    shell.run("reboot")
end

return kernel
