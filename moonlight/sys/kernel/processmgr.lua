local kernel = require("/moonlight/sys/kernel/kernel")
local log = require("/moonlight/lib/liblogging")
local taskQueues = {}

local function runTasks()
    while true do
        local highestPriority = math.huge
        local selectedTask = nil

        for priority, queue in ipairs(taskQueues) do
            if #queue > 0 and priority < highestPriority then
                highestPriority = priority
                selectedTask = table.remove(queue, 1)
            end
        end

        if selectedTask then
            local success, errorMessage = coroutine.resume(selectedTask)
            if not success then
                
            end
        else

        end
    end
end

local function createTask(priority, func)
    if not taskQueues[priority] then
        taskQueues[priority] = {}
    end
    table.insert(taskQueues[priority], coroutine.create(func))
end

createTask(1, function()
    print("Task 1 (priority 1) started")
    os.sleep(1)
    print("Task 1 finished")
end)

createTask(2, function()
    print("Task 2 (priority 2) started")
    os.sleep(1)
    print("Task 2 finished")
end)

runTasks()
