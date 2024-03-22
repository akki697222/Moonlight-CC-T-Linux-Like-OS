local args = { ... }
local root = require("/moonlight/lib/libroothandler")

if args[1] == nil then
    if root.getRootStatus() == true then
        print("Usage: switchshell [moonshell | cash]")
        return
    end
    print("switchshell: Access Denied.")
elseif args[1] == "cash" then
    if root.getRootStatus() == true then
        print("Sorry, switchshell is disabled due to many bugs.")
        return
    end
    print("switchshell: Access Denied.")
elseif args[1] == "moonshell" then
    print("Sorry, switchshell is disabled due to many bugs.")
    return
else
    print(args[1].."is not valid shell.")
    return
end