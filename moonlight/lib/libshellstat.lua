local stat = {}

function stat.getStat()
    local handle = fs.open("/moonlight/proc/shellrunning", "r")
    local content = handle.readAll()
    return content
end

function stat.setStat(str)
    local handle = fs.open("/moonlight/proc/shellrunning", "w")
    handle.write(str)
    handle.close()
end

return stat