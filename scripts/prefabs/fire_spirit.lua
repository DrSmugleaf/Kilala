local brain = require "brains/koalefantbrain"

local assets =
{
	Asset("ANIM", "anim/fire_spirit_basic.zip"),
    Asset("ANIM", "anim/fire_spirit_actions.zip"),
    Asset("ANIM", "anim/fire_spirit.zip"),
	Asset("SOUND", "sound/fire_spirit.fsb"),
}

local prefabs =
{
    "ignis_soul",
    "charcoal",
}

local loot = {"ignis_soul","charcoal","charcoal","charcoal"}


local WAKE_TO_RUN_DISTANCE = 10
local SLEEP_NEAR_ENEMY_DISTANCE = 14

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or inst:IsNear(ThePlayer, WAKE_TO_RUN_DISTANCE)
end

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and not inst:IsNear(ThePlayer, SLEEP_NEAR_ENEMY_DISTANCE)
end

local function Retarget(inst)

end

local function KeepTarget(inst, target)
    return distsq(Vector3(target.Transform:GetWorldPosition()), Vector3(inst.Transform:GetWorldPosition())) < TUNING.KOALEFANT_CHASE_DIST * TUNING.KOALEFANT_CHASE_DIST
end

local function OnNewTarget(inst, data)

end

local function GetStatus(inst)

end

local function ShareTargetFn(dude)
    return dude:HasTag("koalefant") and not dude:HasTag("player") and not dude.components.health:IsDead()
end

local function OnAttacked(inst, data)
    inst.components.combat:SetTarget(data.attacker)
    inst.components.combat:ShareTarget(data.attacker, 30, ShareTargetFn, 5)
end

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 100, .75)
    
    inst.DynamicShadow:SetSize(4.5, 2)
    inst.Transform:SetFourFaced()

    inst:AddTag("koalefant")
    inst:AddTag("animal")
    inst:AddTag("largecreature")

    inst.AnimState:SetBank("koalefant")
    inst.AnimState:SetBuild("koalefant_summer_build")
    inst.AnimState:PlayAnimation("idle_loop", true)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("eater")
    inst.components.eater:SetDiet({ FOODTYPE.VEGGIE }, { FOODTYPE.VEGGIE })

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "beefalo_body"
    inst.components.combat:SetDefaultDamage(20)
    inst.components.combat:SetRetargetFunction(1, Retarget)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst:ListenForEvent("newcombattarget", OnNewTarget)
    inst:ListenForEvent("attacked", OnAttacked)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(400)
    inst.components.health.fire_damage_scale = 0

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(loot)

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus

    inst:AddComponent("knownlocations")

    inst:AddComponent("periodicspawner")
    inst.components.periodicspawner:SetPrefab("charcoal")
    inst.components.periodicspawner:SetRandomTimes(40, 60)
    inst.components.periodicspawner:SetDensityInRange(20, 2)
    inst.components.periodicspawner:SetMinimumSpacing(8)
    inst.components.periodicspawner:Start()

    MakeLargeBurnableCharacter(inst, "beefalo_body")
    MakeLargeFreezableCharacter(inst, "beefalo_body")

    MakeHauntablePanic(inst)

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = 1.5
    inst.components.locomotor.runspeed = 7

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

    inst:SetBrain(brain)
    inst:SetStateGraph("SGkoalefant")

    return inst
end

return Prefab("forest/animals/fire_spirit", fn, assets, prefabs)