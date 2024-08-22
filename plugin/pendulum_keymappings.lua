--print("Hello")

local function start_timer_with_prompt()
  local time_input = vim.fn.input("Enter time (format: mm:ss or ss): ")
  local minutes, seconds
  if time_input:find(":") then 
    minutes, seconds = time_input:match("^(%d+):(%d+)$")
    --print(minutes)
    --print(seconds)
    if not minutes or not seconds then 
      print("Invalid time format")
      return
    end
    minutes, seconds = tonumber(minutes), tonumber(seconds)
  else
      seconds = tonumber(time_input)
      if not seconds then
        print("Invalid time format")
        return
      end
      minutes = 0
  end
  local total_seconds = (minutes * 60) + seconds
  vim.cmd("TimerStart " .. total_seconds)

  --if time_input and tonumber(time_input) then
  --  vim.cmd("TimerStart " .. time_input)
  --else
  --  print("Invalid time input")
  --end
end
--local Timer = require("pendulum.init")
   
--vim.keymap.set('n',"asdf", ":echo 'hello'")
vim.keymap.set('n', '<leader>tt', ':TimerTemplate<CR>', { desc = 'select timer template', })
vim.keymap.set('n', 'timer' , '', { desc = 'Start the timer', callback = start_timer_with_prompt, noremap = true, silent = true })
vim.keymap.set('n', '<leader>ts', ':TimerStop<CR>', { desc = 'Stop the timer' })
vim.keymap.set('n', '<leader>tp', ':TimerPause<CR>', { desc = 'Pause the timer' })
vim.keymap.set('n', '<leader>tr', ':TimerResume<CR>', { desc = 'Resume the timer' })
vim.keymap.set('n', '<leader>tre', ':TimerRestart<CR>', { desc = 'Restart  the timer' })
vim.keymap.set('n', '<leader>sct', ':StartYourCustomTimer<CR>', { desc = 'Start your custom timer' })






