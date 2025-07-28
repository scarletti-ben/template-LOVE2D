# Overview
This project aims to be a template for a basic `LÖVE2D` game, as well as a teaching tool, primarily for myself. It contains most of the information I picked up along the way when trying to set up a clean environment for developing `LÖVE2D` games.

# What is LÖVE2D?
[LÖVE2D](https://en.wikipedia.org/wiki/L%C3%B6ve_(game_framework)), also known as `LÖVE` or simply `LÖVE`, is a game framework for `Lua`. It provides a simple layer / API wrapper for interacting with the user's system, giving access to graphics, audio and input.

Because `LÖVE2D` is a framework and not a game engine, you take on a lot of the heavy lifting yourself.  This is compounded by the fact that the standard library is much smaller than similar languages, such as `Python`

- ## Reasons to Love LÖVE
    - A language with a syntax that is human-readable
    - Applications that are fast
    - Applications that are incredibly small and easily packaged
    - Applications that are compatible with many different platforms

> [!Note]
> - For many people the lack of hand-holding is seen as a bonus!

# Installing LÖVE2D
- Navigate to the [LÖVE2D](https://love2d.org/) site
- Follow installer instructions, or extract `.zip`
- Download either `64-bit installer` or `64-bit zipped`
- Run the installer or extract zip archive
- Add `love.exe` directory to `PATH` via `System Environment Variables`
    - Default is `C:\Program Files\LOVE\love.exe`
    - Allows you to use `love .` in your terminal to run `love.exe` in current directory

# Installing this Repository
You can install this repository via one of the methods below, the easiest for new users is probably via the [ZIP](#download-zip-file) method

- ## Download ZIP File
    - Click the green "<> Code" button to the right of the repository
    - Click "Download ZIP"
    - Find the `.zip` file and extract it
    - Inside the extracted files, navigate to `template-LOVE2D/game`
    - Open your terminal and run `love .`

- ## With Git Installed
    - In your terminal, navigate to the workspace you want to use
    - Run `git clone https://github.com/scarletti-ben/template-LOVE2D`
    - Navigate to `template-LOVE2D/game`
    - Run `love .`

- ## Create a Copy of this Template (Advanced)
    - Click the green "Use this template" button in the top right of the repository
    - Select "Create a new repository"

> [!IMPORTANT]
> - The "Create a Copy" method assumes that you have a `GitHub` account and that you know what to do with a repository once you copy it!

# Project Structure of a Basic LÖVE2D Game
The project structure of a basic `LÖVE2D` game can be seen below, and should be almost identical to the one in this project
```text
workspace/
├── game/
│   └── assets/
│       ├── loading.wav
│       └── player_80x80.png
|
├── conf.lua
└── main.lua
```

There are two special files in a `LÖVE` project, `conf.lua` and `main.lua`

> [!NOTE]
> - Beyond `main.lua` and `conf.lua`, which need to be in the root of the project, you can set up the project structure in any way you wish. The `assets/` directory in the example project is not a special directory, but is a convention, and helpful for storing and accessing game assets

## The `conf.lua` File
- Used for setting up the window and configuration of globals
- Overwrites / defines specific `LÖVE` methods
    - `function love.conf(t)`

An example `conf.lua` file can be found below. It should be mostly self explanatory from the function docstrings. Because `conf.lua` runs before `main.lua` the global variables it defines should be usable when `main.lua` is executed

```lua
-- < ------------------------------------------------------
-- < Global Variables
-- < ------------------------------------------------------

W = 800
H = 600
CX = W / 2
CY = H / 2
PATHS = {
    image = "assets/player_80x80.png",
    music = "assets/loading.wav"
}

-- < ------------------------------------------------------
-- < Core Love Functions
-- < ------------------------------------------------------

--- Configure window properties
--- - Called once by Love at the beginning of the game
--- @param t table Configuration table provided by Love
function love.conf(t)
   t.window.title = "Game Title"
   t.window.width = W
   t.window.height = H
   t.window.resizable = false
   t.window.vsync = true
end
```

> [!NOTE]
> - Due to the way `Lua` works, variables defined at the module scope that do not use the `local` keyword are global across the entire project / workspace. Those that use the `local` keyword are 'global', in a sense, but only to the module itself

## The `main.lua` File
- Used for the main game loop and defining `LÖVE` methods
- Overwrites / defines specific `LÖVE` methods
    - `function love.load()`
    - `function love.update(dt)`
    - `function love.draw()`

An example `main.lua` file for this simple project can be found below. It should be mostly self explanatory from the function docstrings. Because `conf.lua` runs before `main.lua` the global variables it defines should be usable when `main.lua` is executed
```lua
-- < ------------------------------------------------------
-- < Local Variables
-- < ------------------------------------------------------

local image
local music
local x
local y
local speed = 400

-- < ------------------------------------------------------
-- < Core Love Functions
-- < ------------------------------------------------------

--- Initialise game resources and starting state
--- - Called once by Love at the beginning of the game
function love.load()
   image = love.graphics.newImage(PATHS.image)
   music = love.audio.newSource(PATHS.music, "stream")
   x = CX - image:getWidth() / 2
   y = CY - image:getHeight() / 2
   music:setLooping(true)
   music:play()
end

--- Update game logic
--- - Called each frame
--- - Handles image movement using arrow keys
--- @param dt number Time elapsed since last frame in seconds
function love.update(dt)
   if love.keyboard.isDown("up") then y = y - speed * dt end
   if love.keyboard.isDown("down") then y = y + speed * dt end
   if love.keyboard.isDown("left") then x = x - speed * dt end
   if love.keyboard.isDown("right") then x = x + speed * dt end
end

--- Update display
--- - Called each frame
--- - Render all visual elements to the display
function love.draw()
   love.graphics.draw(image, x, y)
   love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end
```

> [!NOTE]
> - One quirk of `Lua` is that instance methods accessed via `instance.method()` do not pass the instance as the first argument, whereas `instance:method` does pass it and can be thought of as `instance.method(instance)`

# Testing a LÖVE2D Game
In your project root, where `main.lua` resides, you can run `love .` in your terminal. This should run `LÖVE` in the current directory using its embedded [`LuaJIT`](#lua-vs-luajit) compiler

> [!NOTE]
> - You don't need `Lua` installed on your system for `LÖVE` to run. `LÖVE` comes pre-bundled with an embedded `LuaJIT` (just-in-time) runtime which parses and compiles `.lua` files to machine code at runtime, without you needing to think about the compilation process

# Lua vs LuaJIT
Whilst it wouldn't be useful for `LÖVE` games, you can install either `Lua`  or `LuaJIT` directly for windows and run `lua main.lua` or `luajit main.lua`. The difference between `Lua` and `LuaJIT` is that `Lua` interprets bytecode, whereas `LuaJIT` translates to machine code. `LuaJIT` should be considerably faster than `Lua`, but the actual `.lua` scripts you write should be compatible with both

# Setting Up VSCode for Lua and LÖVE2D
You don't *need* to set up `VSCode` specifically for `LÖVE`, but to get type hints it's best to follow some of the suggestions below. The most important extension is the `Lua` extension by `sumneko`

## Extensions for VSCode
- `Lua` => The `Lua` language server for type hints
    - [sumneko.lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)
- `Lua Debug` => Debugger for `.lua` scripts, allows breakpoints and the `Debug` option in the top right of a `.lua` file, works with `Lua` and `LuaJIT`
    - [actboy168.lua-debug](https://marketplace.visualstudio.com/items?itemName=actboy168.lua-debug)
- `vscode-lua` => Adds autocompletion, error checking, linting, and formatting for `.lua` files
    - [trixnz.vscode-lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua)
- `vscode-lua-format` => Adds a formatter for `.lua` files
    - [Koihik.vscode-lua-format](https://marketplace.visualstudio.com/items?itemName=Koihik.vscode-lua-format)
- `Image preview` => Shows image previews in any file where an image file path is detected, eg. `./assets/image.png`, shows the preview on hover and a small icon in the `VSCode` gutter on the left
    - [kisstkondoros.vscode-gutter-preview](https://marketplace.visualstudio.com/items?itemName=kisstkondoros.vscode-gutter-preview)
- `Love2d Snippets` => Adds snippets specific to `Love2D`
    - [pixelwar.love2dsnippets](https://marketplace.visualstudio.com/items?itemName=pixelwar.love2dsnippets)
- `Love2D Support` => Allows you to run `Love2D` projects directly from `VSCode`, adds intellisense for the `Love2D` API, adds an option to debug, in the status bar, to open a terminal alongside the game 
    - [pixelbyte-studios.pixelbyte-love2d](https://marketplace.visualstudio.com/items?itemName=pixelbyte-studios.pixelbyte-love2d)
- `Path Autocomplete` => Autocompletes paths, for instance those written in strings  eg. `./thin` will recommend `./things` if it exists locally
    - [ionutvmi.path-autocomplete](https://marketplace.visualstudio.com/items?itemName=ionutvmi.path-autocomplete)

> [!TIP]
> - With the above setup you may have multiple formatters installed, `VSCode` will allow you to pick a default when you hit `Alt + Shift + F`

A version of the above for the workspace's `.vscode/extensions.json` can be found below
```json
{
	// Extension Recommendations for Love2D
	// Find all recommended extensions in the store via @recommended
	"recommendations": [
		"sumneko.lua",
		"actboy168.lua-debug",
		"trixnz.vscode-lua",
		"Koihik.vscode-lua-format",
		"kisstkondoros.vscode-gutter-preview",
		"pixelwar.love2dsnippets",
		"pixelbyte-studios.pixelbyte-love2d",
		"ionutvmi.path-autocomplete"
	]
}
```

### Adding the LÖVE2D Addon to the Lua Language Server
- Ensure you have `Lua` (`sumneko.lua`) installed in `VSCode`
- `Ctrl + Shift + P` to open the `VSCode` command palette
- Find and open `Lua: Open Addon Manager` (`lua.addon_manager.open`)
- Search for and install `LÖVE`
- Add the snippet below to the workspace's `.vscode/settings.json`
```json
{
    "Lua.workspace.library": [
        "${addons}/love2d/module/library"
    ],
    "Lua.runtime.version": "LuaJIT",
    "Lua.runtime.special": {
        "love.filesystem.load": "loadfile"
    },
    "Lua.workspace.checkThirdParty": false,
    "Lua.workspace.ignoreDir": [
        "_testing"
    ]
}
```

> [!NOTE]
> - The `_testing` directory added to the ignore list is not essential, but can be useful for files you don't want recognised by the workspace

> [!NOTE]
> - In the unlikely event that the `LÖVE` addon is not installable, you can download a type hinted version of `LÖVE` [here](https://github.com/LuaCATS/love2d/tree/98f7684525a6e866ffa6df449b7aef406a807dae). If you add this anywhere in your workspace it will be picked up by the `Lua` language server

# Packaging Your Game
To package your game to a single file, simply add it to a `.zip` archive, through whatever means you have, and change the extension to `.love`. You can open `.love` files in `love.exe`. The main purpose of this is to make your game easily distributable, and to make it executable as a single file

# Miscellaneous
- Beyond the information above there is a huge amount to learn about `LÖVE2D`
    - Whilst these notes will likely never be read by anyone else, they should be useful to me to come back to

# Project Metadata
```yaml
---
title: "LÖVE2D and Lua"
date: "2025-07-28"
# last_modified_at: ""
description: "Learning the basics of LÖVE2D and the Lua language"
categories: [
  miscellaneous
]
tags: [
  coding, dev, gamedev, game development, lua, luajit, love, love2d, LÖVE2D, just in time compiler, jit, compilation, machine code, bytecode
]
---
```