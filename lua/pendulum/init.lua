--local Timer = require("pendulum.pendulum")
--local timer = Timer.new()
--
local M = {}
--print('this is init')

--M.setup = function(opts)
--  print("Options:", opts)
--end
--
--Function we need:
-- vim.keymap.set(...)
--
--

local Timer = {}
Timer.__index = Timer

function Timer:new()
  local obj = setmetatable({}, Timer)
  --print('well this is from local timer:new')
  obj.timer = vim.loop.new_timer()
  obj.remaining = 0
  obj.is_running = false
  obj.is_paused = false
  obj.start_time = 0
  obj.pause_time = 0
  obj.duration = 0
  return obj
end

function Timer:start(duration)
  if self.is_running then
    print("Timer is already running")
    return
  end
  self.duration = duration
  self.remaining = duration
  self.is_running = true
  self.is_paused = false
  self.start_time = vim.loop.now()
  self.timer:start(0,1000, vim.schedule_wrap(function() self:tick() end))
  print("Timer started for " .. duration .. " seconds")
end

function Timer:tick()
  if not self.is_paused then
    local elapsed = (vim.loop.now() - self.start_time) / 1000
    self.remaining = self.duration - elapsed

    if self.remaining <= 0 then
        self:stop()
        print("Time's up!")
    else
        self:display_remaining_time()
        --print(string.format("Time left: %d seconds", math.ceil(self.remaining)))
    end
  end
end

function Timer:stop()
    if not self.is_running then
        print("No timer is running to stop")
        return
    end

    --self.timer:stop()
    --self.is_running = false
    self.timer:stop()
    self.is_running = false
    self.is_paused = false
    self.remaining = 0
    print("Timer stopped")
end

function Timer:pause()
  --self.is_paused = true
  --self.is_running =true 
  if not self.is_running then
    print("No timer is running to pause")
    return 
  end
  self.timer:stop()
  self.is_paused = true
  --self.timer:stop()
  self.is_running = false
  --self.timer:stop()
  self.pause_time = vim.loop.now()
  --self.remaining = self.remaining - (self.pause_time - self.start_time) / 1000
  
  self.remaining = self.duration -((self.pause_time - self.start_time)/1000)
  local minutes = math.floor(self.remaining / 60)
  local seconds = math.floor(self.remaining % 60)

 -- print("Timer paused with " .. math.ceil(self.remaining) .. " seconds remaining")
  print("Timer paused with " .. minutes .. ":" .. seconds .. " remaining")
end
function Timer:resume()
    if self.is_running then
        print("Timer is already running")
        return
    end

    if self.remaining <= 0 then
        print("No timer to resume")
        return
    end

    self.is_running = true
    self.is_paused = false
    self.start_time = vim.loop.now() - ((self.duration - self.remaining)*1000)
    --self.start_time = self.pause_time - ((self.duration - self.remaining)*1000)
    self.timer:start(0, 1000, vim.schedule_wrap(function()
        self:tick()
    end))

    print("Timer resumed")
end

function Timer:restart()
    self:stop()
    self:start(self.duration)
    print("Timer restarted!")
end

function Timer:display_remaining_time()
  local minutes = math.floor(self.remaining / 60)
  local seconds = math.floor(self.remaining % 60)
  print(string.format("Time remaining: %02d:%02d", minutes, seconds))
end

M.setup = function()


local timer = Timer.new()
vim.api.nvim_create_user_command("TimerStart", function(args)
    timer:start(tonumber(args.args))
end, { nargs = 1 })
vim.api.nvim_create_user_command("TimerStop", function()
    timer:stop()
end, {})
vim.api.nvim_create_user_command("TimerPause", function()
    timer:pause()
end, {})

vim.api.nvim_create_user_command("TimerResume", function()
    timer:resume()
end, {})

vim.api.nvim_create_user_command("TimerRestart", function()
    timer:restart()
end, {})
end
return M
