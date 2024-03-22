local basalt = require("basalt")
local cfgv = require("/moonlight/proc/vinfo")
local version = cfgv.getBiosVer()
local termx, termy = term.getSize()
local main = basalt.createFrame():setBackground(colors.blue)
local cid = os.getComputerID()
local cfgdev = require("/moonlight/proc/devmode")
local log = require("/moonlight/lib/liblogging")
local devmode = cfgdev.getDevMode()
function centerText(text)
    local textLength = string.len(text)
    local centerX = math.floor((termx - textLength) / 2)
    return centerX
end
function bootloader()
    shell.run("/moonlight/boot/mlbtl/loader.lua")
    os.exit()
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
--infomation text
local infotext = main:addLabel():setForeground(colors.white)
local infotextlabel = "CC BIOS"
local infotextcenter = centerText(infotextlabel)
infotext:setText(infotextlabel)
infotext:setPosition(infotextcenter, 2)
--exit button(for debugging)
if devmode == true then
    local exitButton = main:addButton()
    exitButton:setText("X")
    exitButton:setSize(3, 1)
    exitButton:setPosition(1, 1)
    exitButton:setBackground(colors.red)
    exitButton:onClick(function()
        log.write("exiting bios", 2)
        os.exit()
end)
end
--infomations
main:addLabel():setForeground(colors.white):setText("Computer ID: "):setPosition(2, 5)
main:addLabel():setForeground(colors.white):setText(cid):setPosition(15, 5)
main:addLabel():setForeground(colors.white):setText("Lua Version: "):setPosition(2, 6)
main:addLabel():setForeground(colors.white):setText(_VERSION):setPosition(15, 6)
main:addLabel():setForeground(colors.white):setText("BIOS Version: "):setPosition(2, 7)
main:addLabel():setForeground(colors.white):setText(version):setPosition(16, 7)
--start bootloader
main:addButton():setBackground(colors.red):setText("Reboot to Bootloader"):setSize(22, 1):setPosition(2, termy - 4):setForeground(colors.white):onClick(function()bootloader() log.write("BIOS: Reboot to Bootloader...", 1)end)

log.write("BIOS: Loaded.", 1)
basalt.autoUpdate()
