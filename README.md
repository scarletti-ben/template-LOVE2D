# Löve2D
[Löve](https://en.wikipedia.org/wiki/L%C3%B6ve_(game_framework)) is a game framework for `Lua`. It provides a simple layer / API wrapper for interacting with the system, giving access to system graphics, audio and input. 

Because `Löve` is a framework and not a game engine, a lot of the heavy lifting has to be done by you, with the standard library being much smaller than similar languages, such as `Python`.

For many that lack of hand-holding is a bonus. At the very least the bonuses are applications that are fast and incredibly small, a syntax that is human-readable, and compatibility with many different platforms

# Installing Löve2D
- Navigate to the [Löve2D](https://love2d.org/) site
- Download either `64-bit installer` or `64-bit zipped`
- Follow installer instructions, or extract `.zip`
- Ensure `.love` files are set to open in `love.exe`
- [Optional] Open `love.exe` it should show a "no game" message
- [Optional] Add `love.exe` directory to `PATH` via `System Environment Variables`
    - Should be at `C:\Program Files\LOVE\love.exe`
    - Allows you to use `love .` in your terminal to run `love.exe` in current directory

# Project Structure of a Basic Löve2D Game
The project structure of the most basic `Löve2D` (aka `Love`) game can be seen below
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

There are two special files in a `Love` project, `main.lua` and `conf.lua`
- `conf.lua` is primarily for setting up the window and configuration of globals
    - Overwrites /defines specific `Love` methods
        - `function love.conf(t)`
- `main.lua` is used for the main game loop and defining `Love` methods
    - Overwrites / defines specific `Love` methods
        - `function love.load()`
        - `function love.update(dt)`
        - `function love.draw()`

Beyond `main.lua` and `conf.lua`, which need to be in the root of the project, you can set up the project structure in any way you wish. The `assets/` directory in the example project is not a special directory, but is a convention, and helpful for storing and accessing game assets

## The `conf.lua` File
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
> Due to the way `Lua` works, variables defined at the module scope that do not use the `local` keyword are global across the entire project / workspace. Those that use the `local` keyword are 'global', in a sense, but only to the module itself

## The `main.lua` File
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
> One quirk of `Lua` is that instance methods accessed via `instance.method()` do not pass the instance as the first argument, whereas `instance:method` does pass it and can be thought of as `instance.method(instance)`

# Testing a Löve2D Game
In your project root, where `main.lua` resides, you can run `love .` in your terminal. This should run `Love` in the current directory using its embedded [`LuaJIT`](#lua-vs-luajit) compiler

> [!NOTE]
> You don't need `Lua` installed on your system for `Love` to run. `Love` comes pre-bundled with an embedded `LuaJIT` (just-in-time) runtime which parses and compiles `.lua` files to machine code at runtime, without you needing to think about the compilation process

# Lua vs LuaJIT
Whilst it wouldn't be useful for `Love` games, you can install either `Lua`  or `LuaJIT` directly for windows and run `lua main.lua` or `luajit main.lua`. The difference between `Lua` and `LuaJIT` is that `Lua` interprets bytecode, whereas `LuaJIT` translates to machine code. `LuaJIT` should be considerably faster than `Lua`, but the actual `.lua` scripts you write should be compatible with both

# Setting Up VSCode for Lua and Löve2D
You don't *need* to set up `VSCode` specifically for `Love`, but to get type hints it's best to follow some of the processes below. The most important extension is the `Lua` extension by `sumneko`

## Extensions for VSCode
- `Lua` => The `Lua` Language Server for type hints
    - [sumneko.lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)
- `Lua Debug` => 
    - [actboy168.lua-debug](https://marketplace.visualstudio.com/items?itemName=actboy168.lua-debug)
- `vscode-lua` =>
    - [trixnz.vscode-lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua)
- `vscode-lua-format` =>
    - [Koihik.vscode-lua-format](https://marketplace.visualstudio.com/items?itemName=Koihik.vscode-lua-format)
- `Image preview` =>
    - [kisstkondoros.vscode-gutter-preview](https://marketplace.visualstudio.com/items?itemName=kisstkondoros.vscode-gutter-preview)
- `Love2d Snippets` =>
    - [pixelwar.love2dsnippets](https://marketplace.visualstudio.com/items?itemName=pixelwar.love2dsnippets)
- `Love2D Support` =>
    - [pixelbyte-studios.pixelbyte-love2d](pixelbyte-studios.pixelbyte-love2d)
- `Path Autocomplete` =>
    - [ionutvmi.path-autocomplete](https://marketplace.visualstudio.com/items?itemName=ionutvmi.path-autocomplete)

A version of the above for your workspace's `.vscode/extensions.json` can be found below
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

### Adding the Löve2D Addon to the Lua Language Server
- Ensure you have `Lua` (`sumneko.lua`) installed in `VSCode`
- `Ctrl + Shift + P` to open the `VSCode` command palette
- Find and open `Lua: Open Addon Manager` (`lua.addon_manager.open`)
- Search for and install `LÖVE`
- Add the snippet below to your workspace's `.vscode/settings.json`
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
> The `_testing` directory added to the ignore list is not essential, but can be useful for files you don't want recognised by the workspace

> [!NOTE]
> In the unlikely event that the `LÖVE` addon is not installable, you can download a type hinted version of `Love` [here](https://github.com/LuaCATS/love2d/tree/98f7684525a6e866ffa6df449b7aef406a807dae). If you add this anywhere in your workspace it will be picked up by the `Lua` language server

# Miscellaneous
- Beyond the information above there is a huge amount to learn about `Löve2D`
    - Whilst these notes will likely never be read by anyone else, they should be useful to me to come back to

# Project Metadata
```yaml
---
title: "Love2D and Lua"
date: "2025-07-28"
# last_modified_at: ""
description: "Learning the basics of Love2D and the Lua language"
categories: [
  miscellaneous
]
tags: [
  coding, dev, gamedev, game development, lua, luajit, love, love2d, just in time compiler, jit, compilation, machine code, bytecode
]
---
```