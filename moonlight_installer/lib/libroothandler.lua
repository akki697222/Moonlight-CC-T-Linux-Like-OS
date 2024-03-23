local root = {}

function root.getRootStatus()
    local handle = fs.open("/moonlight/proc/root", "r")
    local content = handle.readAll()
    if content == "true" then
        return true
    else
        return false
    end
end

function root.setRootStatus(bool)
    local handle = fs.open("/moonlight/proc/root", "w")
    handle.write(tostring(bool))
    handle.close()
end

return root
