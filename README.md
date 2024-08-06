# pendulum.nvim

```pendulum``` is a simple timer plugin for Neovim designed to assist competitive programmers or coders in general who wants to practice coding for interviews.

This becomes crucial for increasing the coding speed and efficiency while enhancing the quality of the code.

```pendulum``` helps you to get zoned in your coding session and have a productive session out of it.

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

```
-- lazy.nvim

{
    "SunnyTamang/pendulum.nvim",
    config = function()
        require"pendulum".setup()
    end

}

```
