
local MakePlayerCharacter = require "prefabs/player_common"

local assets = {

		Asset( "ANIM", "anim/player_basic.zip" ),
		Asset( "ANIM", "anim/player_idles_shiver.zip" ),
		Asset( "ANIM", "anim/player_actions.zip" ),
		Asset( "ANIM", "anim/player_actions_axe.zip" ),
		Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
		Asset( "ANIM", "anim/player_actions_shovel.zip" ),
		Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
		Asset( "ANIM", "anim/player_actions_eat.zip" ),
		Asset( "ANIM", "anim/player_actions_item.zip" ),
		Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
		Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
		Asset( "ANIM", "anim/player_actions_fishing.zip" ),
		Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
		Asset( "ANIM", "anim/player_bush_hat.zip" ),
		Asset( "ANIM", "anim/player_attacks.zip" ),
		Asset( "ANIM", "anim/player_idles.zip" ),
		Asset( "ANIM", "anim/player_rebirth.zip" ),
		Asset( "ANIM", "anim/player_jump.zip" ),
		Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
		Asset( "ANIM", "anim/player_teleport.zip" ),
		Asset( "ANIM", "anim/wilson_fx.zip" ),
		Asset( "ANIM", "anim/player_one_man_band.zip" ),
		Asset( "ANIM", "anim/shadow_hands.zip" ),
		Asset( "SOUND", "sound/sfx.fsb" ),
		Asset( "SOUND", "sound/wilson.fsb" ),
		Asset( "ANIM", "anim/beard.zip" ),

		--Asset( "ANIM", "anim/kilala.zip" ),
}
local prefabs = {}
local start_inv = {}

local function onIsRaining(inst, israining)

	if israining then raining = true
	else raining = false end

end


local function readOrbs(inst)

	if inst.orbs > 3 then inst.orbs = 3 end
	if 
end


local function orbFlare(inst)
end


local function orbLavaAura(inst)
end


local function orbFoxDiety(inst, stats)
end


local function updateStats(inst)

	if raining then
		inst.components.health:StartRegen(1, 10, false)
		inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.6)
		inst.components.sanity.dapperness = -0.1
	elseif not raining then
		inst.components.health:StopRegen()
		inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.0)
		inst.components.sanity.dapperness = 0
	end

end


local function onBecameHuman(inst)

	inst:WatchWorldState("israining", onisraining)
	onisraining(inst, TheWorld.state.israining)

end

local function onBecameGhost(inst)

	inst:StopWatchingWorldState("israining", onisraining)

end

local function onpreload(inst, data)

	if data then
		if data.orbs then
			inst.orbs = data.orbs
			updateStats(inst)
		end
	end

end

local function onsave(inst,data)

	data.orbs = inst.orbs

end

local common_postinit = function(inst)
	
	inst.MiniMapEntity:SetIcon( "kilala.tex" )

end

local master_postinit = function(inst)

	inst.orbs = 0
	
	inst.soundsname = "wendy"


	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(125)
	inst.components.sanity:SetMax(150)

	inst.components.health.fire_damage_scale = TUNING.WILLOW_FIRE_DAMAGE

	inst:ListenForEvent("ms_respawnedfromghost", onBecameHuman)
	inst:ListenForEvent("ms_becameghost", onBecameGhost)
	inst:ListenForEvent("death", onDeath)

	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

	onBecameHuman(inst)
	updateStats(inst)

end


return MakePlayerCharacter("kilala", prefabs, assets, common_postinit, master_postinit, start_inv)