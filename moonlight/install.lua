local function cd(path)
    shell.run("cd " .. path)
end

local function gettingpackage()
    local bin = {"libdevmodehandler", "liblogerror", "liblogging", "libsyslog", "libshellstat", "libroothandler", "libpasswordhandler", "libuserhandler", "properprint"}
    local shells = {"cash/cash", "cash/env"}
    local sys = {"kernel/boot", "kernel/kernel"}
    local proc = {"clabel","currentuser","defaultuser","devmode","pass","root","shellrunning"}
    cd("bin")
    for _, wget in ipairs(bin) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/"..wget..".lua")
    end
    cd("/moonlight")
    cd("boot")
    cd("mlbtl")
    shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/boot/mlbtl/loader")
    cd("/moonlight")
    cd("shell")
    cd("cash")
    for _, wget in ipairs(shells) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/"..wget..".lua")
    end
    cd("/moonlight/shell")
    cd("moonshell")
    shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/moonshell/shell")
    cd("/moonlight")
    cd("sys")
    cd("kernel")
    for _, wget in ipairs(sys) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/"..wget..".lua")
    end
    cd("/moonlight")
    cd("/proc")
    for _, v in ipairs(proc) do
        local handle = fs.open("/moonlight/proc/"..v, "w")
        handle.close()
    end
    shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/proc/vinfo")
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
cd("/moonlight/shell")
fs.makeDir("cash")
fs.makeDir("moonshell")
cd("/moonlight/sys")
fs.makeDir("firmware")
fs.makeDir("kernel")
cd("/moonlight/var")
fs.makeDir("logs")
cd("/moonlight/boot")
fs.makeDir("mlbtl")
cd("/")
gettingpackage()