local args = { ... }
local root = require("/moonlight/lib/libroothandler")

if args[1] == nil then
    print("Usage: switchshell [moonshell | cash]")
elseif args[1] == "cash" then
    if root.getRootStatus() == true then
        shell.run("/moonlight/shell/cash/cash")
        os.exit()
    end
    print("switchshell: Access Denied.")
elseif args[1] == "moonshell" then
    shell.run("/moonlight/shell/moonshell/shell")
    os.exit()
else
    print(args[1].."is not valid shell.")
end