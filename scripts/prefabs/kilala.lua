
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

		Asset( "ANIM", "anim/kilala.zip" ),
}
local prefabs = {}
local start_inv = {}

local function defensiveMode(inst)

	if orbStates == "active" or orbTiers == 4 then
		if inst.mode == "defensive" and orbTiers >= 1 and orbStates == "active" or orbTiers == 4 then
			hurtByRain = false -- HP and Hunger damage
		end

		if inst.mode == "defensive" and orbTiers >= 2 and orbStates == "active" or orbTiers == 4 then
			if TheWorld.state.phase == "dusk" or TheWorld.state.phase == "night" then
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.5)
				inst.components.sanity.night_drain_mult = 0
			else
				inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
				inst.components.sanity.night_drain_mult = 1
			end
		end

		if inst.mode == "defensive" and orbTiers >= 3 and orbStates == "active" or orbTiers == 4 then
			inst.components.sanity.night_drain_mult = 0
			inst.components.moisture:ForceDry(true)
		end
	else
		hurtByRain = true
		inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1)
		inst.components.sanity.night_drain_mult = 1
		inst.components.moisture:ForceDry(false)
	end

	if TheWorld.state.israining then
		if hurtByRain then
			inst.components.health:StartRegen(-1, 10, false)
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.6)
			inst.components.sanity.dapperness = -0.1
		else
			inst.components.health:StopRegen()
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.0)
			inst.components.sanity.dapperness = 0
		end
	else
		inst.components.health:StopRegen()
		inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * 1.0)
		inst.components.sanity.dapperness = 0
	end

end

local function OffensiveMode(inst)

	if orbStates == "active" or orbTiers == 4 then
		if inst.mode == "offensive" and orbTiers >= 1 and orbStates == "active" or orbTiers == 4 then
			inst.Light:SetRadius(0.5)
			inst.Light:SetFalloff(0.5)
			inst.Light:SetIntensity(0.5)
			inst.Light:SetColour(70/255,255/255,12/255)
			inst.Light:Enable(true)
		end

		if inst.mode == "offensive" and orbTiers >= 2 and orbStates == "active" or orbTiers == 4 then
			inst.Light:SetRadius(1)
			inst.Light:SetFalloff(0.5)
			inst.Light:SetIntensity(0.5)
			inst.Light:SetColour(70/255,255/255,12/255)
			inst.Light:Enable(true)
		end

		if inst.mode == "offensive" and orbTiers >= 3 and orbStates == "active" or orbTiers == 4 then
			inst.Light:SetRadius(1)
			inst.Light:SetFalloff(0.5)
			inst.Light:SetIntensity(0.5)
			inst.Light:SetColour(70/255,255/255,12/255)
			inst.Light:Enable(true)
		end
	else
		inst.Light:Enable(false)
	end

end


local function readOrbs(inst)

	local orbTier1 = stats.orbTier1
	local orbTier2 = stats.orbTier2
	local orbTier3 = stats.orbTier3
	local orbState1 = stats.orbState1
	local orbState2 = stats.orbState2
	local orbState3 = stats.orbState3

	local orbs = nil
	if orbs > 3 then
		orbs = 3
	end

	local orbStates = nil
	if orbState1 == "active" and orbState2 == "active" and orbState3 == "active" then
		orbStates = "active"
	end

	return orbTier1, orbTier2, orbTier3, orbState1, orbState2, orbState3, orbStates

end


local function orbFlare(inst, attacker, target, skipsanity)

	if inst.flaremode then

		local function onattack_flare(inst, attacker, target, skipsanity)

			if target.components.burnable and not target.components.burnable:IsBurning() then
		        if target.components.freezable and target.components.freezable:IsFrozen() then           
		            target.components.freezable:Unfreeze()            
		        else            
		              if target.components.fueled and target:HasTag("campfire") and target:HasTag("structure") then
		                local fuel = SpawnPrefab("cutgrass")
		                if fuel then target.components.fueled:TakeFuelItem(fuel) end
		            else
		                target.components.burnable:Ignite(true)
		            end
		        end   
		    end

		    if target.components.freezable then
		        target.components.freezable:AddColdness(-1)
		        if target.components.freezable:IsFrozen() then
		            target.components.freezable:Unfreeze()            
		        end
		    end

		    if target.components.sleeper and target.components.sleeper:IsAsleep() then
		        target.components.sleeper:WakeUp()
		    end

			if target.components.combat then
				target.components.combat:SuggestTarget(attacker)
				if target.sg and target.sg.sg.states.hit and not target:HasTag("player") then
					target.sg:GoToState("hit")
				end
			end

			if attacker and attacker.components.sanity and not skipsanity then
		        attacker.components.sanity:DoDelta(-TUNING.SANITY_SUPERTINY)
		    end

			attacker.SoundEmitter:PlaySound("dontstarve/wilson/fireball_explo")
			target:PushEvent("attacked", {attacker = attacker, damage = 0})

		end

		inst.components.weapon:SetOnAttack(onattack_flare)

	else
	end

end


local function orbLavaAura(inst)
end

local function foxDiety(inst)

	if orbTier1 == 1 then duration1 = 0 
		elseif orbTier1 == 2 then duration1 = 5 
		elseif orbTier1 == 3 then duration1 = 10 
		elseif orbTier1 == 4 then duration1 = 10 end
	if orbTier2 == 1 then duration2 = 0 
		elseif orbTier2 == 2 then duration2 = 5 
		elseif orbTier2 == 3 then duration2 = 10 
		elseif orbTier2 == 4 then duration2 = 10 end
	if orbTier3 == 1 then duration3 = 0 
		elseif orbTier3 == 2 then duration3 = 5 
		elseif orbTier3 == 3 then duration3 = 10 
		elseif orbTier3 == 4 then duration3 = 10 end

	local durationTotal = nil
	if orbTier1 >= 3 and orbTier2 >= 3 and orbTier3 >= 3 then
		durationTotal = 60
	else
		durationTotal = duration1 + duration2 + duration3
	end

	if orbState1 == "active" and orbState2 == "active" and orbState3 == "active" then
		inst.components.hunger:DoDelta(-50)
		inst.components.sanity:DoDelta(-50)
		
		inst.components.combat.damagemultiplier = 1.5
		inst.components.locomotor.walkspeed = 1.5
		inst.components.locomotor.runspeed = 1.5
		owner.components.health:SetInvincible(true)

		inst:DoTaskInTime(math.ceil(durationTotal+1), function(inst)
			inst.components.combat.damagemultiplier = 1.0
			inst.components.locomotor.walkspeed = 1.0
			inst.components.locomotor.runspeed = 1.0
			owner.components.health:SetInvincible(false)
		end)
	end

end


local function onBecameHuman(inst)

	inst:WatchWorldState("israining", defensiveMode)
	defensiveMode(inst, TheWorld.state.israining)

end

local function onBecameGhost(inst)

	inst:StopWatchingWorldState("israining", defensiveMode)

end

local function onpreload(inst, data)

	if data then
		if data.orbs then
			orbs = data.orbs
			updateStats(inst)
		end
	end

end

local function onsave(inst,data)

	data.orbs = orbs
	owner.components.health:SetInvincible(false)

end

local common_postinit = function(inst)
	
	-- Character voice
	inst.soundsname = "wendy"

	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "kilala.tex" )

	inst.transformed = false
	inst.mode = "defensive"
	inst:AddComponent("keyhandler")
    inst.components.keyhandler:AddActionListener("Kilala", KEY_X, "MODE")

end

local master_postinit = function(inst)

	inst:AddComponent("fireborn")

	inst.fireOrb = 0
	inst.lightOrb = 0
	inst.darkOrb = 0
	inst.infernoOrb = 0

	local fireOrbMAX = 3
	local lightOrbMAX = 3
	local darkOrbMAX = 3
	local infernoOrbMAX = 3

	-- Offensive Mode light
	local light = inst.entity:AddLight()
	inst.Light:Enable(false)
	inst.Light:SetRadius(0.5)
	inst.Light:SetFalloff(0.5)
	inst.Light:SetIntensity(0.5)
	inst.Light:SetColour(70/255,255/255,12/255)


	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(125)
	inst.components.sanity:SetMax(150)

	inst.components.health.fire_damage_scale = TUNING.WILLOW_FIRE_DAMAGE

	inst:ListenForEvent("ms_respawnedfromghost", onBecameHuman)
	inst:ListenForEvent("ms_becameghost", onBecameGhost)
	inst:ListenForEvent("death", onDeath)

	inst:WatchWorldState("israining", defensiveMode)
	inst:WatchWorldState("isday", defensiveMode)
	inst:WatchWorldState("isdusk", defensiveMode)
	inst:WatchWorldState("isnight", defensiveMode)

	inst.OnSave = onsave
	inst.OnPreLoad = onpreload

	onBecameHuman(inst)
	updateStats(inst)

end


return MakePlayerCharacter("kilala", prefabs, assets, common_postinit, master_postinit, start_inv)