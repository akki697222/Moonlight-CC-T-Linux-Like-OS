local args = { ... }

local function listDirectory(directory, showHidden)
    local function addToTable(tbl, name, isDir)
        table.insert(tbl, { name = name, isDir = isDir })
    end

    local folders = {}
    local files = {}

    local success, fileListOrError = pcall(fs.list, directory)
    if not success then
        print(args[1]..": No such file or directory")
        return
    end

    for _, name in ipairs(fileListOrError) do
        if not showHidden and string.sub(name, 1, 1) == "." then
            goto continue
        end

        local isDir = fs.isDir(fs.combine(directory, name))
        addToTable(isDir and folders or files, name, isDir)

        ::continue::
    end


    for _, entry in ipairs(folders) do
        term.setTextColor(colors.blue)
        print(entry.name)
    end

    for _, entry in ipairs(files) do
        term.setTextColor(colors.white)
        print(entry.name)
    end
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
