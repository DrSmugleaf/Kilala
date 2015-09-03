local assets = {
	Asset("ANIM", "anim/soul_ignis.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("soul_ignis")
    inst.AnimState:SetBuild("soul_ignis")
    inst.AnimState:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = SMALL_FUEL * 32 * 3

    inst:AddComponent("inventoryitem")
    inst:AddComponent("inspectable")
    inst:AddComponent("stackable")

    MakeHauntableLaunch(inst)
    
    return inst

end

STRINGS.NAMES.SOUL_IGNIS = "Ignis Soul"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SOUL_IGNIS = "A sweet rhythmic pulse flows from this soul."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOUL_IGNIS = "This little guy looks like it would really help a fire."

return Prefab("common/inventory/soul_ignis", fn, assets)