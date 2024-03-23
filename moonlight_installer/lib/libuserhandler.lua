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

function root.setDefaultUser(str)
    local handle = fs.open("/moonlight/proc/defaultuser", "w")
    handle.write(str)
    handle.close()
end

function root.getDefaultUser() 
    local handle = fs.open("/moonlight/proc/defaultuser", "r")
    local content = handle.readAll()
    return content
end

return root
