local args = { ... }
local slog = require("/moonlight/lib/libsyslog")
local log = require("/moonlight/lib/liblogging")

if args[1] == "out" then
    log.init()
    log.write("this is an infomation", 1)
    log.write("this is an warning", 2)
    log.write("this is an error", 3)
    log.write("this is an fatal error", 4)
    log.write("this is an nil level")
    return
end

if args[1] == "sys" then
    slog.init()
    slog.write("Moonlight Linux version 106501657.1645865488.262642777.19194545114514", "kernel")
    slog.write("akki was eaten.", "akki")
    return
end

if args[1] == "clear" then
    log.clear()
    slog.clear()
    return
end

if args[1] == "help" or args[1] == nil then
    print("logtestutil - [out|sys|clear]")
end