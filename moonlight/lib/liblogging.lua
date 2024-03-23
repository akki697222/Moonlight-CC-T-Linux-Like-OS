local currentDate = os.date("%Y-%m-%d")
local currentTime = os.date("%H:%M:%S")
local currentDateandTime = os.date("%b %d %H:%M:%S")
local logFileName = currentDate .. ".log"
local logFilePath = "/moonlight/var/logs/" .. logFileName
local logLevel = {
    "INFO",
    "WARN",
    "ERROR",
    "FATAL"
}

local log = {}

function log.init()
    if not fs.exists(logFilePath) then
        local file = fs.open(logFilePath, "w")
        file.close()
    end
    print("["..currentDateandTime.."] liblogging: liblogging successfully initilized.")
end

function log.write(message, level) -- level, 1: info 2: warn 3: error 4: fatal
    if level == nil then
        log.write("An Error Occurred on Writing log - EXCEPTION_LOGLEVEL_NIL", 3)
        return
    end
    local file = fs.open(logFilePath, "a")
    file.writeLine("["..currentDate.." "..currentTime.."] ["..logLevel[level].."] ".. message)
    file.close()
end

function log.clear()
    if fs.exists(logFilePath) then
        fs.delete(logFilePath)
        log.init()
    end
end

return log