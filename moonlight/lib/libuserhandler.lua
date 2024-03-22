local root = {}

function root.getCurrentUser()
    local handle = fs.open("/moonlight/proc/currentuser", "r")
    local content = handle.readAll()
    return content
end

function root.setCurrentUser(str)
    local handle = fs.open("/moonlight/proc/currentuser", "w")
    handle.write(str)
    handle.close()
end

return root
