local uCfg = require("/moonlight/lib/libuserhandler")
local root = require("/moonlight/lib/libroothandler")
local log = require("/moonlight/lib/liblogging")
local slog = require("/moonlight/lib/libsyslog")
local dev = require("/moonlight/lib/libdevmodehandler")
local defaultDir = "moonlight/home"
uCfg.setDefaultUser("Default")

local function drawShell()
    if root.getRootStatus() == true then
        term.setTextColor(colors.white)
        io.write(uCfg.getCurrentUser() .. "@" .. os.getComputerID())
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
        io.write(uCfg.getCurrentUser() .. "@" .. os.getComputerID())
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

shell.setDir("/"..defaultDir)
waitShellInput()
