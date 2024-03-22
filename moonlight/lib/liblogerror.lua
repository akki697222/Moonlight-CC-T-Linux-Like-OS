local errors = {}
local log = require("/moonlight/lib/liblogging")
local slog = require("/moonlight/lib/libsyslog")

function errors.logError(expection, vendor, level) -- level 1: normal error level 2: fatal error
    if level == 2 then
        log.write("Fatal Error: "..vendor.."."..expection, 4)
        slog.write("Error: "..vendor.."."..expection, vendor)
    elseif level == 1 then
        log.write("Error: "..vendor.."."..expection, 3)
    else
        error("Error: lib.liblogerror.EXPECTION_OVERFLOW_LEVEL", 0)
    end
end

return errors