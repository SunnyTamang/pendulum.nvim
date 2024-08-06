# pendulum.nvim

```pendulum``` is a simple timer plugin for Neovim designed to assist competitive programmers or coders in general who wants to practice coding for interviews.

This becomes crucial for increasing the coding speed and efficiency while enhancing the quality of the code.

```pendulum``` helps you to get zoned in your coding session and have a productive session out of it.

![](~/nvim_plugin_dev/"Screen Recording 2024-08-06 at 12.23.28 PM.mov")


## Features

- Set timer for a specified duration
- Pause and resume the timer
- Stop the timer permanently
- Restart the timer

## Status

```pendulum``` is a very minimialistic timer plugin to create a productive session using the timer.
Currently it only uses timer input values in seconds only. But more improvements is on its way

## Requirements

NVIM >= v0.9.0


## Installation

Install the plugin with your preferred package manager:

**Lazy**

```
-- lazy.nvim

{
    "SunnyTamang/pendulum.nvim",
    config = function()
        require"pendulum".setup()
    end

}

```

**Plug**
```
-- vim-plug
call plug#begin()
    Plug 'SunnyTamang/pendulum.nvim'
call plug#end()

lua require("pendulum").setup()

```

## Usage

- ```:TimerStart <some number>``` starts the timer
- ```:TimerPause``` pause the timer
- ```:TimerResume``` resumes the timer from where it was paused
- ```:TimerStop``` stops the timer
- ```:TimerRestart``` restarts the timer with the last used start time 

Alternatively, you can also use Lua equivalents.

```
vim.keymap.set('n', 'timer' , ':TimerStart<CR>', { desc = 'Start the timer', callback = start_timer_with_prompt, noremap = true, silent = true })
vim.keymap.set('n', '<leader>ts', ':TimerStop<CR>', { desc = 'Stop the timer' })
vim.keymap.set('n', '<leader>tp', ':TimerPause<CR>', { desc = 'Pause the timer' })
vim.keymap.set('n', '<leader>tr', ':TimerResume<CR>', { desc = 'Resume the timer' })
vim.keymap.set('n', '<leader>tre', ':TimerRestart<CR>', { desc = 'Restart  the timer' })
```

