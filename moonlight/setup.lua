local function cd(path)
    shell.run("cd " .. path)
end

local function setComputerLabel(str)
    local handle = fs.open("/moonlight/proc/clabel", "w")
    handle.write(str)
    handle.close()
end

local function setDefaultUser(str)
    local handle = fs.open("/moonlight/proc/defaultuser", "w")
    handle.write(str)
    handle.close()
end

local function setPass(str)
    local handle = fs.open("/moonlight/proc/pass", "w")
    handle.write(str)
    handle.close()
end

local function gettingpackage()
    local lib = {"libdevmodehandler", "liblogerror", "liblogging", "libsyslog", "libshellstat", "libroothandler", "libpasswordhandler", "libuserhandler", "properprint"}
    local shells = {"cash/cash", "cash/env"}
    local sys = {"kernel/boot", "kernel/kernel"}
    local proc = {"clabel","currentuser","defaultuser","devmode","pass","root","shellrunning"}
    local cmds = {"ls", "cd", "log", "version", "su", "ccpt", "brainpower", "help"}
    cd("/moonlight/lib")
    for _, wget in ipairs(lib) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/lib/"..wget..".lua")
    end
    cd("/moonlight/boot/mlbtl")
    shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/boot/mlbtl/loader.lua")
    cd("/moonlight/shell/cash")
    for _, wget in ipairs(shells) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/shell/"..wget..".lua")
    end
    cd("/moonlight/shell/moonshell")
    shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/shell/moonshell/shell.lua")
    cd("/moonlight/sys/kernel")
    for _, wget in ipairs(sys) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/sys/"..wget..".lua")
    end
    cd("/moonlight/proc")
    for _, v in ipairs(proc) do
        local handle = fs.open("/moonlight/proc/"..v, "w")
        handle.close()
    end
    shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/proc/vinfo")
    cd("/moonlight/bin")
    for _, wget in ipairs(cmds) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/bin/"..wget..".lua")
    end
    cd("/")
end
cd("/")
shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/startup")
fs.makeDir("/moonlight/bin")
fs.makeDir("/moonlight/boot")
fs.makeDir("/moonlight/data")
fs.makeDir("/moonlight/etc")
fs.makeDir("/moonlight/home")
fs.makeDir("/moonlight/lib")
fs.makeDir("/moonlight/proc")
fs.makeDir("/moonlight/shell")
fs.makeDir("/moonlight/sys")
fs.makeDir("/moonlight/tmp")
fs.makeDir("/moonlight/var")
fs.makeDir("/moonlight/shell/cash")
fs.makeDir("/moonlight/shell/moonshell")
fs.makeDir("/moonlight/sys/firmware")
fs.makeDir("/moonlight/sys/kernel")
fs.makeDir("/moonlight/var/logs")
fs.makeDir("/moonlight/boot/mlbtl")
cd("/")
gettingpackage()
term.clear()
term.setCursorPos(1,1)
print("Please type your computer name.")
local input = read()
if not input == nil or "" then
    setComputerLabel(input)
end
term.clear()
term.setCursorPos(1,1)
print("Please type your user name.")
local input = read()
if not input == nil or "" then
    setDefaultUser(input)
end
term.clear()
term.setCursorPos(1,1)
print("Please set user password.")
local input = read()
setPass(input)
print("Setup complete! the computer will restart after 5 seconds...")
sleep(5)
os.reboot()