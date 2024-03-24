local version = "1.00"
local mltext = "MoonLight Linux version " .. version
local tx, ty = term.getSize()
local s = 1
local bootpath = {
    "/moonlight/install.lua",
    "shell",
    "shutdown"
}
local options = {
    "Install Moonlight Linux",
    "CraftOS",
    "Exit"
}

local function centerText(text)
    local textLength = string.len(text)
    local centerX = math.floor((tx - textLength) / 2)
    return centerX
end

local function mkdir(n)
    shell.run("mkdir " .. n)
end

local function wget(url)
    shell.run("wget " .. url)
end

local function cd(path)
    shell.run("cd " .. path)
end

local function drawBoxEvent()
    term.clear()
    term.setTextColor(colors.lightBlue)
    term.setCursorPos(centerText(mltext), 2)
    io.write(mltext)
    term.setTextColor(colors.white)
    term.setCursorPos(3, ty - ty + 5)
    for i = 1, #options do
        if i == s then
            term.clearLine()
            io.write("> ")
            io.write(options[i])
            term.setCursorPos(3, ty - ty + 5 + i)
        else
            term.clearLine()
            io.write("  ")
            io.write(options[i])
            term.setCursorPos(3, ty - ty + 5 + i)
        end
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
    end
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    while true do
        local event, key = os.pullEvent("key")
        if key == keys.up and s > 1 then
            s = s - 1
            drawBoxEvent()
        elseif key == keys.down and s < #options then
            s = s + 1
            drawBoxEvent()
        elseif key == keys.enter then
            term.clear()
            term.setCursorPos(1, 1)
            shell.run(bootpath[s])
            shell.exit()
            return
        end
    end
end

local function install()
    mkdir("moonlight")
    cd("moonlight")
    wget("https://raw.githubusercontent.com/akki697222/Moonlight-CC-T-Linux-Like-OS/main/moonlight/install.lua")
    term.clear()
    drawBoxEvent()
end

install()
