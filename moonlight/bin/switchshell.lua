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
        term.clear()
        term.setCursorPos(1,1)
        shell.run("/moonlight/shell/cash/cash")
        shell.exit()        
        return
    end
    print("switchshell: Access Denied.")
elseif args[1] == "moonshell" then
    term.clear()
    term.setCursorPos(1,1)
    shell.run("/moonlight/shell/moonshell/shell")
    shell.exit()
    return
else
    print(args[1].."is not valid shell.")
    return
end