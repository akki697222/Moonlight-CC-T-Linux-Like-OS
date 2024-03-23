local args = {...}
local cfgv = require("/moonlight/proc/vinfo")
local basalt = require("/moonlight/sys/firmware/basalt")

term.setTextColor(colors.lightBlue)
io.write("Moonlight Linux ")
term.setTextColor(colors.white)
io.write("Version: "..cfgv.getSysVer())
print("")
print("by akki_kayo and OpenAI ChatGPT-3.5")