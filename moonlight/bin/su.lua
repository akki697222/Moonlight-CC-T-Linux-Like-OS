local root = require("/moonlight/lib/libroothandler")
local pass = require("/moonlight/lib/libpasswordhandler")
local user = require("/moonlight/lib/libuserhandler")
local password = pass.getPass()
io.write("Password: ")
local input = read("*")
if input == password then
    user.setCurrentUser("root")
    root.setRootStatus(true)
else
    print("su: Access Denied.")
end