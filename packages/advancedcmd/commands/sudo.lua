local args = { ... }
local root = require("/moonlight/lib/libroothandler")
local pass = require("/moonlight/lib/libpasswordhandler")
local password = pass.getPass()
if args[1] == nil then
    print("Usage: sudo [command]")
else
    io.write("[sudo] Password: ")
    local input = read("*")
    if input == password then
        root.setRootStatus(true)
        shell.run(table.concat(args, " "))
        root.setRootStatus(false)
    else
        print("sudo: Access Denied.")
    end
end
