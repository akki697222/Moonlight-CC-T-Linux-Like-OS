local function cat(filename)
    local file = fs.open(shell.dir().."/"..filename, "r")
    if not file then
        return
    end
    local content = file.readAll()
    file.close()
    print(content)
end

local args = {...}
local filename = args[1]

if not filename then
    print("Usage: cat <filename>")
    return
end

cat(filename)
