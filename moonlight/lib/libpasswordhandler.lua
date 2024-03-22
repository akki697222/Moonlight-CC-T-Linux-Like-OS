local root = {}

function root.getPass()
    local handle = fs.open("/moonlight/proc/pass", "r")
    local content = handle.readAll()
    return content
end

function root.setPass(str)
    local handle = fs.open("/moonlight/proc/pass", "w")
    handle.write(str)
    handle.close()
end

return root
