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
local plugin_check = require("pendulum.pendulum")

-- Function to update lualine configuration
local function update_lualine(timer_status)
    local lualine_installed, lualine = plugin_check.is_plugin_loaded('lualine')
    if lualine_installed then
        local timer_section = {
            timer = {
                function()
                    -- Function to get the timer display value
                    local timer_value = timer_status:thes() -- You need to define this function based on your timer
                    return timer_value
                end,
                color = { gui = "bold" },
            },
        }

        -- Update lualine configuration
        lualine.setup({
            sections = {
                lualine_x = { timer_section.timer }
            },
        })
    else
        print("Lualine is not installed. Timer will not be displayed in lualine.")
    end
end


local Timer = {}
Timer.__index = Timer

Timer.config = {
    lualine = false  -- Default value
    -- other config options
}

function Timer:new(user_config)
  local obj = setmetatable({}, Timer)
  --print('well this is from local timer:new')
  user_config = user_config or {}

    -- Ensure self.config is not nil
  local default_config = self.config or {}

    -- Merge user config with default config
  obj.config = vim.tbl_extend("force", default_config, user_config)
  obj.timer = vim.loop.new_timer()
  obj.remaining = 0
  obj.is_running = false
  obj.is_paused = false
  obj.start_time = 0
  obj.pause_time = 0
  obj.duration = 0
  obj.custom_timer_value = 0
  obj.ok, obj.result = plugin_check.is_plugin_loaded('lualine')

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
  --print("Timer started for " .. duration .. " seconds")
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
  --self.timGer:stop()
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
    if self.is_running then
      --self:stop()
      self.is_running = false
      self.is_paused = false
      self.remaining = 0

    end

    self:start(self.duration)
    print("Timer restarted!")
end

function Timer:display_remaining_time()
  if self.config.lualine then
        require('lualine').setup {
            sections = {
                lualine_x = {
                'encoding', 'fileformat', 'filetype',
                    {
                        function()
                        return self:get_time_for_lualine()
                        end
                    }
                }
            }
        }
  else
  local minutes = math.floor(self.remaining / 60)
  local seconds = math.floor(self.remaining % 60)
  print(string.format("Time remaining: %02d:%02d", minutes, seconds))
  end
end

function Timer:get_time_for_lualine()
    if not self.is_running then
        return ""
    end
    local minutes = math.floor(self.remaining / 60)
    local seconds = math.floor(self.remaining % 60)
    return string.format("Timer: %02d:%02d", minutes, seconds)
end

--Template function goes here
--
--This is for custom timer part
--
local custom_timer_file = vim.fn.stdpath("config") .. "/custom_timer.txt"
local function file_exists(path)
  local file = io.open(path, 'r')
  if file then
    file:close()
    return true
  else 
    return false
  end
end

local function ensure_file_exists(path)
  if not file_exists(path) then
    local file = io.open(path, "w")
    if file then
      file:close()
    else 
      print("Error creating custom timer file")
    end
  end
end

function Timer:write_custom_timer_value(value)
  ensure_file_exists(custom_timer_file)
  local file = io.open(custom_timer_file, "w")
  if file then
    file:write(value)
    file:close()
  else
    print("Error writing to custom timer file")
    return
  end
end

function Timer:read_custom_timer_value()
    if not file_exists(custom_timer_file) then
        return nil
    end

    local file = io.open(custom_timer_file, "r")
    if file then
        local value = tonumber(file:read("*a"))
        file:close()
        return value
    else
        noice.notify("Error reading from custom timer file", "error")
        return nil
    end
end

function Timer:start_custom_timer()
    local custom_value = self:read_custom_timer_value()
    --print(custom_value)
    if not custom_value then
        print("No custom timer value set")
        return
    end

    --local timer = Timer:new()
    self:start(custom_value)
end
 

function Timer:set_custom_timer_value()
  local time_input = vim.fn.input("Enter custom time (format: mm:ss or ss): ")
  local minutes, seconds

  if time_input:find(":") then
        -- Input format is mm:ss
    minutes, seconds = time_input:match("^(%d+):(%d+)$")
    if not minutes or not seconds then
      print("Invalid time format")
      return
    end
    minutes, seconds = tonumber(minutes), tonumber(seconds)
  else
        -- Input format is ss
    seconds = tonumber(time_input)
    if not seconds then
      print("Invalid time format")
      return
    end
    minutes = 0
  end

    -- Calculate the total time in seconds
  local total_time = (minutes * 60) + seconds

    -- Write the custom timer value to the file
  self:write_custom_timer_value(total_time)
  self:start_custom_timer()
  --print("custom timer set to " .. time_input)    
end

   

function Timer:load_custom_timer_value()
  print('custom_timer_value')
  if not file_exists(custom_timer_file) then
    return nil
  end
  local file = io.open(custom_timer_file, "r")
  --print(file:read("*a"))
  if file then
    local value = tonumber(file:read("*a"))
    file:close()
    return value
  else 
    print("Error reading from custom timer file")
    return nil
  end
end



--function Timer:start_custom_timer()
--  local custom_value
--end

function Timer:show_template_menu()
  local choices = {
    "1 minute",
    "2 minutes",
    "5 minutes",
    "20 minutes",
    "25 minutes",
    "Custom"

  }
  local durations = {
    ["1 minute"] = 60,
    ["2 minutes"] = 120,
    ["5 minutes"] = 300,
    ["20 minutes"] = 1200,
    ["25 minutes"] = 1500
  }
  vim.ui.select(choices, { prompt = "Select timer template:" }, function(choice)
    if choice then
      --self.start_timer_template(durations[choice])
      if choice == "Custom" then 
        --self:set_custom_timer_value()
        --print('custom clicked')
        self:set_custom_timer_value()
      else
        self:start(durations[choice])
      end
    else
      print("no template selected")
      return
    end
      
  end)
end
 

--

M.setup = function(user_config)

local timer = Timer:new(user_config)
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

vim.api.nvim_create_user_command("TimerTemplate", function()
    timer:show_template_menu()
end, {})

vim.api.nvim_create_user_command("StartYourCustomTimer", function()
    timer:start_custom_timer()
end, {})

end
return M
