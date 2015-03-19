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

MOD_NAME = "Kilala, the Fire Fox"
MOD_PREFIX = "KILALA"
--local MOD_ID = ""
MOD_VERSION = "1.0.0"

PrefabFiles = {}

Assets = {
	Asset( "IMAGE", "images/saveslot_portraits/kilala.tex" ),
	Asset( "ATLAS", "images/saveslot_portraits/kilala.xml" ),

	Asset( "IMAGE", "images/selectscreen_portraits/kilala.tex" ),
	Asset( "ATLAS", "images/selectscreen_portraits/kilala.xml" ),
	
	Asset( "IMAGE", "images/selectscreen_portraits/kilala_silho.tex" ),
	Asset( "ATLAS", "images/selectscreen_portraits/kilala_silho.xml" ),

	Asset( "IMAGE", "bigportraits/kilala.tex" ),
	Asset( "ATLAS", "bigportraits/kilala.xml" ),
	
	Asset( "IMAGE", "images/map_icons/kilala.tex" ),
	Asset( "ATLAS", "images/map_icons/kilala.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_kilala.tex" ),
	Asset( "ATLAS", "images/avatars/avatar_kilala.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_kilala.tex" ),
	Asset( "ATLAS", "images/avatars/avatar_ghost_kilala.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.kilala = "The Fire Fox"
STRINGS.CHARACTER_NAMES.kilala = "Kilala"
STRINGS.CHARACTER_DESCRIPTIONS.kilala = ""
STRINGS.CHARACTER_QUOTES.kilala = ""

-- Custom speech strings
STRINGS.CHARACTERS.KILALA = require "speech_kilala"

-- The character's name as appears in-game 
STRINGS.NAMES.KILALA = "Kilala"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KILALA = 
{
	GENERIC = "It's Kilala!",
	ATTACKER = "That Kilala looks shifty...",
	MURDERER = "Murderer!",
	REVIVER = "Kilala, friend of ghosts.",
	GHOST = "Kilala could use a heart.",
}

-- Let the game know character is male, female, or robot
table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "kilala")


AddMinimapAtlas("images/map_icons/kilala.xml")
AddModCharacter("kilala")
