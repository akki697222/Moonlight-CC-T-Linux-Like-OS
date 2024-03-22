local root = require("/moonlight/lib/libroothandler")
if root.getRootStatus() == true then
    print("Executed on root.")
    return
end
if root.getRootStatus() == false then
    print("Executed on normal user.")
end