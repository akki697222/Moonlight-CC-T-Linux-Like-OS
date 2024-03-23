local args = { ... }

if args[1] == nil then
    print("Usage: cd [directory]")
    return
end

local cd = shell.resolve(args[1])
if fs.isDir(cd) then
    shell.setDir(cd)
else
    print(args[1]..": No such file or directory.")
    return
end
