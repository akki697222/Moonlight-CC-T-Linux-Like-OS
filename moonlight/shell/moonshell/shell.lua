local uCfg = require("/moonlight/lib/libuserhandler")
local root = require("/moonlight/lib/libroothandler")
local log = require("/moonlight/lib/liblogging")
local slog = require("/moonlight/lib/libsyslog")
local dev = require("/moonlight/lib/libdevmodehandler")
local kernel = require("/moonlight/sys/kernel/kernel")
local defaultDir = "moonlight/home"
local exit = false
local kp = {
    "[Shell] Shell Exited an unexpected error."
}
if uCfg.getComputerLabel() == "" then
    uCfg.setComputerLabel("Undefined")
end
uCfg.setDefaultUser("Default")

local function drawShell()
    if root.getRootStatus() == true then
        term.setTextColor(colors.white)
        io.write(uCfg.getCurrentUser() .. "@" .. uCfg.getComputerLabel())
        if shell.dir() == defaultDir then
        else
            io.write("/" .. shell.dir())
        end
        term.setTextColor(colors.white)
        io.write(":")
        if shell.dir() == defaultDir then
            io.write("~ ")
        else
            io.write("# ")
        end
    elseif root.getRootStatus() == false then
        term.setTextColor(colors.lime)
        io.write(uCfg.getCurrentUser() .. "@" .. uCfg.getComputerLabel())
        term.setTextColor(colors.white)
        io.write(":")
        term.setTextColor(colors.lightBlue)
        if shell.dir() == defaultDir then
        else
            io.write("/" .. shell.dir())
        end
        term.setTextColor(colors.white)
        if shell.dir() == defaultDir then
            io.write("~ ")
        else
            io.write("$ ")
        end
    end
end

local function waitShellInput()
    drawShell()
    while true do
        local input = read()
        if input == "exit" then
            if root.getRootStatus() == false then
                log.write("Exiting Shell...", 1)
                if dev.getMode() == "true" then
                    exit = true
                    return
                else
                    os.shutdown()
                end
            elseif root.getRootStatus() == true then
                uCfg.setCurrentUser(uCfg.getDefaultUser())
                log.write("Exiting Root...", 1)
                root.setRootStatus(false)
            end
        elseif input == nil or input == "" then
        else
            log.write("Run Command: "..input, 1)
            shell.run(input)
        end
        drawShell()
    end
end

if not exit == true then
    shell.setDir("/"..defaultDir)
    local sc, r = pcall(waitShellInput)
    if sc then
    else
        kernel.p("Shell Exited on unexpected error.", "moonshell", kp, r)
    end
elseif exit == true then
    if dev.getMode() == true then
        error("devmode")
    else
        os.shutdown()
    end
end
