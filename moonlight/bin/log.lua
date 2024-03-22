local args = { ... }
local log = require("/moonlight/lib/liblogging")
local slog = require("/moonlight/lib/libsyslog")
if args[1] == nil or args == "" then
    print("Usage: log [logtype, sys|normal] [process, write|init] [message] [level|vendor]")
elseif args[1] == "sys" then
    if args[2] == "init" then
        slog.init()
    elseif args[2] == "write" then
        if args[3] == nil or args[4] == nil then
            print("Usage: log [logtype, sys|normal] [process, write|init] [message] [level|vendor]")
            return
        else
            slog.write(args[3], args[4])
        end
    end
elseif args[1] == "normal" then
    if args[2] == "init" then
        log.init()
    elseif args[2] == "write" then
        if args[3] == nil or args[4] == nil then
            print("Usage: log [logtype, sys|normal] [process, write|init] [message] [level|vendor]")
            return
        else
            log.write(args[3], args[4])
        end
    end
end