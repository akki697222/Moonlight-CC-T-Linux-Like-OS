local log = require("/moonlight/lib/liblogging")
local slog = require("/moonlight/lib/libsyslog")
local aliasCommands = {
    "ls", "cd", "cat", "grep", "log", "version", "switchshell", "su", "echo", "ccpt"
}

local kernel = {}

function kernel.init()
    log.write("Initilizing Kernel...", 1)
    slog.write("Initilizing Kernel...", "Kernel")
    slog.init()
    shell.setAlias("list", "/moonlight/bin/ls")
    shell.setAlias("dir", "/moonlight/bin/ls")
    for index, value in ipairs(aliasCommands) do
        shell.setAlias(value, "/moonlight/bin/"..value)
        slog.write("Set Alias: "..value, "Kernel")
    end
end

function kernel.a()
    
end

function kernel.shellStandAlone()   
    kernel.init()
    term.clear()
    term.setCursorPos(1,1)
    shell.run("/moonlight/shell/moonshell/shell")
end

kernel.shellStandAlone()

return kernel
