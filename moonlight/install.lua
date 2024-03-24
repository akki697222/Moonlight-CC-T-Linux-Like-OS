local function createDirectories(maindir, subdir)
    for _, dir in ipairs(maindir) do
        fs.makeDir(dir)
        print("Created directory: "..dir)
    end
    
    for main, subdirs in pairs(subdir) do
        for _, subdir in ipairs(subdirs) do
            local path = fs.combine(main, subdir)
            fs.makeDir(path)
            print("Created directory: "..path)
        end
    end
end

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
    wget("https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/boot/mlbtl/loader")
    cd("/moonlight")
    cd("shell")
    cd("cash")
    for _, wget in ipairs(shells) do
        shell.run("wget https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/"..wget..".lua")
    end
    cd("/moonlight/shell")
    cd("moonshell")
    wget("https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/moonshell/shell")
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
    wget("https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/proc/vinfo")
end

local mdir = {
    "bin",
    "boot",
    "data",
    "etc",
    "home",
    "lib",
    "proc",
    "shell",
    "sys",
    "tmp",
    "var",
}
local sdir = {
    boot = {"mlbtl"},
    shell = {"cash", "moonshell"},
    sys = {"firmware", "kernel"},
    var = {"logs"},
}

wget("https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/startup")
createDirectories(mdir, sdir)
gettingpackage()