print("Hello")

local function start_timer_with_prompt()
  local time_input = vim.fn.input("Enter the time seconds: ")
  if time_input and tonumber(time_input) then
    vim.cmd("TimerStart " .. time_input)
  else
    print("Invalid time input")
  end
end
    
--vim.keymap.set('n',"asdf", ":echo 'hello'")
vim.keymap.set({ 'n', 'i' }, 'timer' , ':TimerStart<CR>', { desc = 'Start the timer', callback = start_timer_with_prompt, noremap = true, silent = true })
vim.keymap.set({ 'n', 'i' }, '<leader>ts', ':TimerStop<CR>', { desc = 'Stop the timer' })
vim.keymap.set({ 'n', 'i' }, '<leader>tp', ':TimerPause<CR>', { desc = 'Pause the timer' })
vim.keymap.set({ 'n', 'i' }, '<leader>tr', ':TimerResume<CR>', { desc = 'Resume the timer' })
vim.keymap.set({ 'n', 'i' }, '<leader>tre', ':TimerRestart<CR>', { desc = 'Restart  the timer' })






