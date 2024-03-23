local args = { ... }

local function listDirectory(directory, showHidden)
    local function addToTable(tbl, name, isDir)
        table.insert(tbl, { name = name, isDir = isDir })
    end

    local files = {}

    local success, fileListOrError = pcall(fs.list, directory)
    if not success then
        print(args[1] .. ": No such file or directory")
        return
    end

    for _, name in ipairs(fileListOrError) do
        if not showHidden and string.sub(name, 1, 1) == "." then
            goto continue
        end

        local isDir = fs.isDir(fs.combine(directory, name))
        addToTable(files, name, isDir)

        ::continue::
    end

    local maxNameLength = 0
    for _, entry in ipairs(files) do
        if #entry.name > maxNameLength then
            maxNameLength = #entry.name
        end
    end

    local maxPerLine = 6 
    if #files > maxPerLine then
        local halfCount = math.ceil(#files / 2)
        for i, entry in ipairs(files) do
            term.setTextColor(entry.isDir and colors.blue or colors.lightBlue)
            io.write(entry.name .. string.rep(" ", maxNameLength - #entry.name + 2))

            if i == halfCount then
                print("")
            end
        end
    else
        for _, entry in ipairs(files) do
            term.setTextColor(entry.isDir and colors.blue or colors.lightBlue)
            io.write(entry.name .. string.rep(" ", maxNameLength - #entry.name + 2))
        end
    end

    term.setTextColor(colors.white)
    print("")
end

local function execute(directory)
    if not directory or directory == "" then
        directory = shell.dir()
    end

    local showHidden = false
    if args[1] == "--a" then
        showHidden = true
    end
    listDirectory(directory, showHidden)
end

if shell then
    if args[1] == "--a" then
        execute(args[2])
    else
        execute(args[1])
    end
end

return execute
