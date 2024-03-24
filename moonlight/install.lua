local function cd(path)
    shell.run("cd " .. path)
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
    shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/boot/mlbtl/loader/")
    cd("/moonlight/shell/cash")
    for _, wget in ipairs(shells) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/shell/cash/"..wget..".lua")
    end
    cd("/moonlight/shell/moonshell")
    shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/moonshell/shell/")
    cd("/moonlight/sys/kernel")
    for _, wget in ipairs(sys) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/sys/kernel/"..wget..".lua")
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

cd("/moonlight/shell")
fs.makeDir("cash")
fs.makeDir("moonshell")
cd("/")
shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/startup")
cd("/moonlight")
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
fs.makeDir("/moonlight/shellcash")
fs.makeDir("/moonlight/shellmoonshell")
fs.makeDir("/moonlight/sys/firmware")
fs.makeDir("/moonlight/sys/kernel")
fs.makeDir("/moonlight/var")
fs.makeDir("/moonlight/boot/mlbtl")
cd("/")
gettingpackage()