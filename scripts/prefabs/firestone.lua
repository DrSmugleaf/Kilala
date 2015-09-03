local assets =
{
	Asset("ANIM", "anim/firestone.zip"),
}

local function OnSave(inst, data)
    data.reachedHighTemp = inst.reachedHighTemp
end

local function OnLoad(inst, data)
    if data then
    	inst.reachedHighTemp = data.reachedHighTemp
    end
end

local function OnRemove(inst)
    inst._light:Remove()
end

-- These represent the boundaries between the ranges (relative to ambient, so ambient is always "0")
local relative_temperature_thresholds = { -30, -10, 10, 30 }

local function GetRangeForTemperature(temp, ambient)
    local range = 1
    for i,v in ipairs(relative_temperature_thresholds) do
        if temp > ambient + v then
            range = range + 1
        end
    end
    return range
end

-- Heatrock emits constant temperatures depending on the temperature range it's in
local emitted_temperatures = { -10, 10, 25, 40, 60 }

local function HeatFn(inst, observer)
    local range = GetRangeForTemperature(inst.components.temperature:GetCurrent(), TheWorld.state.temperature)
    if range <= 2 then
        inst.components.heater:SetThermics(false, true)
    elseif range >= 4 then
        inst.components.heater:SetThermics(true, false)
    else
        inst.components.heater:SetThermics(false, false)
    end
    return emitted_temperatures[range]
end

 local function GetStatus(inst)
    if inst.currentTempRange == 1 then
        return "COLD"
    elseif inst.currentTempRange == 2 then
        return "COLD"
    elseif inst.currentTempRange == 4 then
        return "WARM"
    elseif inst.currentTempRange == 5 then
        return "HOT"
	end
end

local function UpdateImages(inst, range)
	inst.currentTempRange = range

	inst.AnimState:PlayAnimation(tostring(range), true)
	inst.components.inventoryitem:ChangeImageName("firestone"..tostring(range))
	if range == 5 then
		inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
        inst._light.Light:Enable(true)
	else
		inst.AnimState:ClearBloomEffectHandle()
        inst._light.Light:Enable(false)
	end
end

local function AdjustLighting(inst, range)
    if range == 5 then
        local relativetemp = inst.components.temperature:GetCurrent() - TheWorld.state.temperature
        local baseline = relativetemp - relative_temperature_thresholds[4]
        local brightline = relative_temperature_thresholds[4] + 20
        inst._light.Light:SetIntensity( math.clamp(0.5 * baseline/brightline, 0, 0.5 ) )
    else
        inst._light.Light:SetIntensity(0)
    end
end

local function TemperatureChange(inst, data)
	local range = GetRangeForTemperature(inst.components.temperature:GetCurrent(), TheWorld.state.temperature)
    AdjustLighting(inst, range)
	if range ~= inst.currentTempRange then

        UpdateImages(inst, range)

        if range == 5 or range == 1 then
            inst.reachedHighTemp = true
        end

		if range == 3 and inst.reachedHighTemp then
            --local percent = inst.components.fueled:GetPercent()
			--percent = percent - 1 / TUNING.HEATROCK_NUMUSES
			inst.reachedHighTemp = false
            --inst.components.fueled:SetPercent(percent)
		end

	end
end

local function OnOwnerChange(inst)
    local newowners = {}
    local owner = inst
    while owner.components.inventoryitem ~= nil do
        newowners[owner] = true

        if inst._owners[owner] then
            inst._owners[owner] = nil
        else
            inst:ListenForEvent("onputininventory", inst._onownerchange, owner)
            inst:ListenForEvent("ondropped", inst._onownerchange, owner)
        end

        local nextowner = owner.components.inventoryitem.owner
        if nextowner == nil then
            break
        end

        owner = nextowner
    end

    inst._light.entity:SetParent(owner.entity)

    for k, v in pairs(inst._owners) do
        if k:IsValid() then
            inst:RemoveEventCallback("onputininventory", inst._onownerchange, k)
            inst:RemoveEventCallback("ondropped", inst._onownerchange, k)
        end
    end

    inst._owners = newowners
end


local function OnIgniteFn(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_fuse_LP", "hiss")
end

local function OnExplodeFn(inst)
    inst.SoundEmitter:KillSound("hiss")
    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")

    SpawnPrefab("explode_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
end


local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("firestone")
    inst.AnimState:SetBuild("firestone")

    inst:AddTag("heatrock")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()
    
    inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = GetStatus
    
    inst:AddComponent("inventoryitem")

	inst:AddComponent("temperature")
	inst.components.temperature.current = TheWorld.state.temperature
	inst.components.temperature.inherentinsulation = TUNING.INSULATION_MED
    inst.components.temperature.inherentsummerinsulation = TUNING.INSULATION_MED
    inst.components.temperature.ignoreheatertags = {"heatrock"}

	inst:AddComponent("heater")
	inst.components.heater.heatfn = HeatFn
	inst.components.heater.carriedheatfn = HeatFn
    inst.components.heater.carriedheatmultiplier = TUNING.HEAT_ROCK_CARRIED_BONUS_HEAT_FACTOR
    inst.components.heater:SetThermics(false, false)

    
    inst.components.burnable:SetOnBurntFn(nil)

    inst:AddComponen("explosive")
    inst.components.explosive:SetOnExplodeFn(OnExplodeFn)
    inst.components.explosive:SetOnIgniteFn(OnIgniteFn)
    inst.components.explosive.explosivedamage = 0
    

	inst:ListenForEvent("temperaturedelta", TemperatureChange)
	inst.currentTempRange = 0

    --Create light
    inst._light = SpawnPrefab("heatrocklight")
    inst._owners = {}
    inst._onownerchange = function() OnOwnerChange(inst) end
    --

    UpdateImages(inst, 1)
    OnOwnerChange(inst)

	MakeHauntableLaunchAndSmash(inst)

	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
    inst.OnRemoveEntity = OnRemove

	return inst
end

local function lightfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetRadius(.6)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(235 / 255, 165 / 255, 12 / 255)
    inst.Light:Enable(false)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst.persists = false

    return inst
end

STRINGS.NAMES.FIRESTONE = "Firestone"
STRINGS.CHARACTERS.KILALA.DESCRIBE.FIRESTONE = "This would be an useful core. I should burn it."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FIRESTONE = "An upgraded thermal stone!"

return  Prefab("common/inventory/firestone", fn, assets),
        Prefab("common/inventory/heatrocklight", lightfn)