local assets=
{
	Asset("ANIM", "anim/flame_cloak.zip"),
}

local function onunequip(inst, owner)

    owner.AnimState:ClearOverrideSymbol("swap_body")
    flameCloak_turnOff(inst)

    if inst.components.fueled then
        inst.components.fueled:StopConsuming()        
    end

end

local function flameCloak_turnOn(inst)

    owner.AnimState:OverrideSymbol("swap_body", "flame_cloak", "swap_body")
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    if not inst.components.fueled:IsEmpty() then
        if inst._light == nil or not inst._light:IsValid() then
        inst._light = SpawnPrefab("minerhatlight")
        end
        if owner ~= nil then
            onequip(inst, owner)
            inst._light.entity:SetParent(owner.entity)
        end
        inst.components.fueled:StartConsuming()
        inst.SoundEmitter:PlaySound("dontstarve/common/minerhatAddFuel")
    elseif owner ~= nil then
        onequip(inst, owner, "hat_miner_off")
    end

end

local function flameCloak_turnOff(inst)

    if inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
        local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
        if owner ~= nil then
            onequip(inst, owner, "hat_miner_off")
        end
    end
    inst.components.fueled:StopConsuming()
    inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")
    if inst._light ~= nil then
        if inst._light:IsValid() then
            inst._light:Remove()
        end
        inst._light = nil
    end

end

local function flameCloak_perish(inst)
    local equippable = inst.components.equippable
    if equippable ~= nil and equippable:IsEquipped() then
        local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
        if owner ~= nil then
            local data =
            {
                prefab = inst.prefab,
                equipslot = equippable.equipslot,
            }
            miner_turnoff(inst)
            owner:PushEvent("torchranout", data)
            return
        end
    end
    miner_turnoff(inst)
end

local function flameCloak_takeFuel(inst)

    if inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
        flameCloak_turnOn(inst)
    end

end

local function flameCloak_onRemove(inst)

    if inst._light ~= nil and inst._light:IsValid() then
        inst._light:Remove()
    end

end

local function fn()

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("flame_cloak")
    inst.AnimState:SetBuild("flame_cloak")
    inst.AnimState:PlayAnimation("anim")
    
    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    
    inst.components.inventoryitem:SetOnDroppedFn(flameCloak_turnOff)
    inst.components.equippable:SetOnEquip(flameCloak_turnOn)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(100)

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(TUNING.TRUNKVEST_PERISHTIME)
    inst.components.fueled:SetDepletedFn(flameCloak_perish)
    inst.components.fueled.ontakefuelfn = flameCloak_takeFuel
    inst.components.fueled.accepting = true

    inst._light = nil
    inst.OnRemoveEntity = flameCloak_onRemove

    MakeHauntableLaunch(inst)
    
    return inst

end

STRINGS.NAMES.FLAMECLOAK = "Flame Cloak"
STRINGS.CHARACTERS.KILALA.DESCRIBE.FLAMECLOAK = "I want to wear it forever."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FLAMECLOAK = "This will keep me warm, but doesn't provide much protection."

return Prefab("common/inventory/flame_cloak", fn, assets)