local function readFromFile(filename)
    local file = fs.open(shell.dir().."/"..filename, "r")
    if not file then
        print("Error: File not found.")
        return nil
    end
    local text = file.readAll() 
    file.close()
    return text
end

local function searchPattern(pattern, text)
    local lines = {}
    for line in text:gmatch("[^\n]+") do
        table.insert(lines, line)
    end

    for _, line in ipairs(lines) do
        local start, finish = line:find(pattern)
        if start then
            local before = line:sub(1, start - 1)
            local match = line:sub(start, finish)
            local after = line:sub(finish + 1)
            term.setTextColor(colors.white)
            io.write(before)
            term.setTextColor(colors.red)
            io.write(match)
            term.setTextColor(colors.white)
            print(after)
        end
    end
end

local args = {...}
local pattern = args[1]
local filename
local text

if args[2] == "--files" then
    filename = args[3]
    if not filename then
        print("Error: Filename not specified.")
        return
    end
    text = readFromFile(filename)
    searchPattern(pattern, text)
else
    text = table.concat(args, " ", 2)
    searchPattern(pattern, text)
end
