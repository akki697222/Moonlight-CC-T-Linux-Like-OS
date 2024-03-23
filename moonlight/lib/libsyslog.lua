local currentDate = os.date("%Y-%m-%d")
local currentDateandTime = os.date("%b %d %H:%M:%S")
local logFileName = currentDate.."_sys.log"
local logFilePath = "/moonlight/var/logs/"..logFileName
local log = {}

function log.init()
    if not fs.exists(logFilePath) then
        local file = fs.open(logFilePath, "w")
        file.close()
    end
    print("["..currentDateandTime.."] libsyslog: libsyslog successfully initilized.")
end

function log.write(message, vendor) -- level, 1: info 2: warn 3: error 4: fatal
    local file = fs.open(logFilePath, "a")
    file.writeLine("["..currentDateandTime.."] "..vendor.." : "..message)
    file.close()
end

function log.clear()
    if fs.exists(logFilePath) then
        fs.delete(logFilePath)
        log.init()
    end
end

return log