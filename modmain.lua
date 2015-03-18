-- This library function allows us to use a file in a specified location.
modimport("libs/use.lua")

-- Allows use to call global environment variables without initializing them in our files.
use "libs/mod_env"(env)

-- These lines of code prevent keystrokes from happening during critical moments.
use "data/widgets/controls"
use "data/screens/chatinputscreen"
use "data/screens/consolescreen"
-- End prevention of keystrokes.

-- Scripts Initialization.
use "data/scripts/init"

local MOD_NAME = "Kilala, the Fire Fox"
local MOD_PREFIX = "KILALA"
--local MOD_ID = ""
local MOD_VERSION = "1.0.0"