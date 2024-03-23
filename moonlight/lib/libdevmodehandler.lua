local devmode = {}

function devmode.getMode()
    local handle = fs.open("/moonlight/proc/devmode", "r")
    local content = handle.readAll()
    return content
end

function devmode.setMode(bool)
    local handle = fs.open("/moonlight/proc/devmode", "w")
    handle.write(bool)
    handle.close()
end

return devmode
