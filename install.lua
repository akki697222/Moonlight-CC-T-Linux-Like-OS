local ml_dirs ={
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
    "var"
}

local function mkdir(n)
    shell.run("mkdir "..n)
end

local function wget(url)
    shell.run("wget "..url)
end

local function cd(path)
    shell.run("cd "..path)
end

local function install()
    mkdir("moonlight")
    cd("moonlight")
    for index, value in ipairs(ml_dirs) do
        mkdir(value)
    end
    cd("boot")
    mkdir("mlbtl")
    cd("mlbtl")
    wget("https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/boot/mlbtl/loader.lua")
end