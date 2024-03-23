local basalt = require("moonlight.sys.firmware.basalt")
local termx, termy = term.getSize()
local cfgdev = require("moonlight.proc.devmode")
local log = require("moonlight.lib.liblogging")
local slog = require("moonlight.lib.libsyslog")
log.init()
slog.init()



function centerText(text)
    local textLength = string.len(text)
    local centerX = math.floor((termx - textLength) / 2)
    return centerX
end

function bios()
    shell.run("/moonlight/sys/firmware/bios.lua")
    os.exit()
end

function bootloader()
    shell.run("/moonlight/boot/mlbtl/loader.lua")
    os.exit()
end

local main = basalt.createFrame():setBackground(colors.black)
--infomation text
local infotext = main:addLabel():setForeground(colors.white)
local infotextlabel = "BOOT OPTION"
local infotextcenter = centerText(infotextlabel)
infotext:setText(infotextlabel)
infotext:setPosition(infotextcenter, 2)
--exitButton
if cfgdev.getDevMode() == true then
    local exitButton = main:addButton()
    exitButton:setText("X")
    exitButton:setSize(3, 1)
    exitButton:setPosition(1, 1)
    exitButton:setBackground(colors.red)
    exitButton:onClick(function()
        log.write("exiting startup", 2)
        os.exit()
    end)
end
--text panels
local upsidepanetext = main:addPane()
upsidepanetext:setSize(termx, 1)
upsidepanetext:setPosition(1, 3)
upsidepanetext:setBackground(false, "=", colors.white)

local downsidepanetext = main:addPane()
downsidepanetext:setSize(termx, 1)
downsidepanetext:setPosition(1, termy - 2)
downsidepanetext:setBackground(false, "=", colors.white)
--options
main:addButton():setForeground(colors.white):setText("1 moonlight Bootloader"):setPosition(2, 5):setSize(22, 1):onClick(function()
    log.write("STARTUP: SELECTED BOOTLOADER.", 1)
    bootloader()
end)
main:addButton():setForeground(colors.white):setText("2 CC BIOS"):setPosition(2, 7):setSize(9, 1):onClick(function()
    log.write("STARTUP: SELECTED BIOS.", 1)
    bios()
end)

basalt.autoUpdate()
