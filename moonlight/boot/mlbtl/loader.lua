term.clear()
local version = "1.00"
local mltext = "MoonLoader GRUB version " .. version
local tx, ty = term.getSize()
local s = 1
local bootpath = {
    "/moonlight/sys/kernel/boot.lua",
    "shell",
    "shutdown"
}
local options = {
    "Moonlight Linux",
    "CraftOS",
    "Exit"
}

local function centerText(text)
    local textLength = string.len(text)
    local centerX = math.floor((tx - textLength) / 2)
    return centerX
end

local function drawBoxEvent()
    term.clear()
    term.setTextColor(colors.lightGray)
    term.setCursorPos(centerText(mltext), 2)
    io.write(mltext)
    term.setTextColor(colors.white)
    term.setCursorPos(3, 4)
    io.write("\x9C")
    for i = 0, tx - 7 do
        io.write("\x8C")
    end
    term.blit("\x93", "f", "0")
    for i = 5, ty - 7 do
        term.setCursorPos(3, i)
        term.blit("\x95", "0", "f")
        term.setCursorPos(tx - 2, i)
        term.blit("\x95", "f", "0")
    end
    term.setCursorPos(3, ty - 6)
    io.write("\x8D")
    for i = 0, tx - 7 do
        io.write("\x8C")
    end
    io.write("\x8E")
    term.setCursorPos(1, 1)
    term.setCursorPos(4, 5)
    term.setTextColor(colors.white)
    for i = 1, #options do
        if i == s then
            term.setBackgroundColor(colors.lightGray)
            term.setTextColor(colors.black)
            io.write(" "..options[i])
            for b = 1, tx - string.len(options[i]) - 7 do
                io.write(" ")
            end
            term.setCursorPos(4, ty - ty + 5 + i)
        else
            term.setBackgroundColor(colors.black)
            term.setTextColor(colors.white)
            io.write(" "..options[i])
            term.setCursorPos(4, ty - ty + 5 + i)
        end
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
    end
    term.setTextColor(colors.lightGray)
    if tx == 51 then
        term.setCursorPos(4, ty - 4)
        io.write("Use the \30 and \31 keys to select witch entry is")
        term.setCursorPos(4, ty - 3)
        io.write("highlighted.")
        term.setCursorPos(4, ty - 2)
        print("Press enter to boot the selected OS.")
        term.setCursorPos(4, ty - 1)
        io.write("Before booting or `c` for a command-line.")
    else
        term.setCursorPos(4, ty - 4)
        io.write("Use the \30 and \31 keys to select witch entry is highlighted.")
        term.setCursorPos(4, ty - 3)
        print("Press enter to boot the selected OS.")
        term.setCursorPos(4, ty - 2)
        io.write("Before booting or `c` for a command-line.")
    end
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
            term.setCursorPos(1,1)
            shell.run(bootpath[s])
            shell.exit()
            return
        end
    end
end

drawBoxEvent()
