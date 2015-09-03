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

PrefabFiles = {
	-- Character
	"kilala",

	-- Level up items
	--"core_of_darkness", "core_of_light", "fire_orb", "fucking_endgame_item", "inferno_charm",
	"orbs",

	-- Equipment
	"flame_cloak", "flame_cloak_depleted", "spirit_sword", "spirit_armor",

	-- Usables
	"basaltic_shielding", "fire_stone",

	-- Materials
	"flame_hardened_rope", "glass_mixture", "liquid_fire", "magmatic_lens", "sintered_core",

	-- World Gen
	"fire_spirit_track",

	-- Mobs
	"fire_spirit",

	-- Mob Drops
	"ignis_soul", "soul_of_anger", "soul_of_animation", "soul_of_combustion", "soul_of_fear", 
	"soul_of_ice", "soul_of_life", "soul_of_nature",
}

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


local recipes = 
{
	AddRecipe("basaltic_shielding", {Ingredient("marble", 2), Ingredient("redgem", 1)}, RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("core_of_darkness", {Ingredient("flower_evil", 2), Ingredient("glass_mixture", 1), Ingredient("nightmarefuel", 1), Ingredient("rabbit", 1), Ingredient("soul_of_combustion", 1)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("core_of_light", {Ingredient("dragonfruit", 2), Ingredient("glass_mixture", 1), Ingredient("honey", 4), Ingredient("soul_of_life", 1)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("fire_orb", {Ingredient("basaltic_shielding", 1), Ingredient("magmatic_lens", 1), Ingredient("sintered_core", 1)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("fire_stone", {Ingredient("charcoal", 1), Ingredient("heatrock", 1), Ingredient("ignis_soul", 1)}, RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("flame_cloak", {Ingredient("charcoal", 1), Ingredient("flame_hardened_rope", 3), Ingredient("ignis_soul", 4)}, RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("flame_hardened_rope", {Ingredient("ash", 1), Ingredient("rope", 1)}, RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("fucking_endgame_item", {Ingredient("soul_of_anger", 1), Ingredient("soul_of_animation", 1), Ingredient("soul_of_combustion", 1), Ingredient("soul_of_fear", 1), Ingredient("soul_of_ice", 1), Ingredient("soul_of_life", 1), Ingredient("soul_of_nature", 1)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("glass_mixture", {Ingredient("ash", 1), Ingredient("flint", 1), Ingredient("nitre", 1)}, RECIPETABS.REFINE, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("inferno_charm", {Ingredient("core_of_darkness", 1), Ingredient("core_of_light", 1), Ingredient("dragon_essence", 3), Ingredient("liquid_fire", 2), Ingredient("orangegem", 1), Ingredient("nightmare_timepiece", 1)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("liquid_fire", {Ingredient("glass_mixture", 1), Ingredient("gold", 1), Ingredient("torch", 1)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("spirit_armor", {Ingredient("flame_cloak", 1), Ingredient("flame_hardened_rope", 1), Ingredient("glass_mixture", 2)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "fireborn"),
	AddRecipe("spirit_sword", {Ingredient("flame_hardened_rope", 1), Ingredient("glass_mixture", 1), Ingredient("ignis_soul", 1), Ingredient("twigs", 1)}, RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "fireborn"),
}

local sortkey = -349635
for k,v in pairs(recipes) do
    sortkey = sortkey - 1
    v.sortkey = sortkey
    --v.builder_tag = v.name.."_builder"
	v.atlas = "images/inventoryimages/" .. v.name .. ".xml"
end


local function ModeFn(inst)

	if inst:HasTag("playerghost") then return end
		if inst.transformed then -- If offensive mode
		--inst.AnimState:SetBuild("kilala_defensive")
		inst.mode = "defensive"
		else
		--inst.AnimState:SetBuild("kilala_offensive")
		inst.mode = "offensive"
		end
	
	inst.transformed = not inst.transformed

	return true

end

AddModRPCHandler("Kilala", "MODE", ModeFn)


AddComponentPostInit("combat", function(Combat)
	local OldCalcDamage = Combat.CalcDamage
	Combat.CalcDamage = function(self, target, weapon, ...)
		local old_damage = nil
		if self.inst.prefab == "kilala" and self.inst.mode == "offensive" and target then
			old_damage = weapon.components.weapon.damage
			if self.inst.orbTiers == 2 then
				weapon.components.weapon.damage = old_damage + 5
        	elseif self.inst.orbTiers >= 3 then
        		weapon.components.weapon.damage = old_Damage + 20
        	end
        end
        local ret = OldCalcDamage(self, target, weapon, ...)
        if old_damage and weapon then
            weapon.components.weapon.damage = old_damage
        end
        return ret
    end
end)


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
