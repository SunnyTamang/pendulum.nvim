# pendulum.nvim

```pendulum``` is a simple timer plugin for Neovim designed to assist competitive programmers or coders in general who wants to practice coding for interviews.

This becomes crucial for increasing the coding speed and efficiency while enhancing the quality of the code.

```pendulum``` helps you to get zoned in your coding session and have a productive session out of it.



https://github.com/user-attachments/assets/1c9c6452-87aa-47f5-a8c8-5c3f016ce20f


![select template](https://github.com/user-attachments/assets/2fa51ee7-d036-43de-a031-1f7e8dd84eef)

## Features 🔥

- Set timer for a specified duration
- Pause and resume the timer
- Stop the timer permanently
- Restart the timer
- Select from predefined timer templates to kick start timer
- Create your own custom timer and with one kepmap start it right away
  

## Status 👷‍♂️

```pendulum``` is a very minimialistic timer plugin to create a productive session using the timer.
More improvements is on its way.

Future implementations

- [x] ~~Added support for minutes and seconds~~
- [x] ~~Templates selection~~
- [x] ~~Custom timer~~
- [ ] Anything if comes in mind



## Requirements 📰

NVIM >= v0.9.0



## Installation 🤾‍♂️

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
- ```:TimerTemplate``` select any predefined timer templates to kick start
- ```:StartYourCustomTimer``` start the timer with the already set value in custom options from templates options

Alternatively, you can also use Lua equivalents.

```
vim.keymap.set('n', 'timer' , ':TimerStart<CR>', { desc = 'Start the timer', callback = start_timer_with_prompt, noremap = true, silent = true })
vim.keymap.set('n', '<leader>ts', ':TimerStop<CR>', { desc = 'Stop the timer' })
vim.keymap.set('n', '<leader>tp', ':TimerPause<CR>', { desc = 'Pause the timer' })
vim.keymap.set('n', '<leader>tr', ':TimerResume<CR>', { desc = 'Resume the timer' })
vim.keymap.set('n', '<leader>tre', ':TimerRestart<CR>', { desc = 'Restart  the timer' })
vim.keymap.set('n', '<leader>tt', ':TimerTemplate<CR>', { desc = 'select timer template' })
vim.keymap.set('n', '<leader>sct', ':StartYourCustomTimer<CR>', { desc = 'start your custom timer'})
```

