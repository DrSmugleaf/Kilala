local assets =
{
	Asset("ANIM", "anim/soul_combustion.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("soul_combustion")
    inst.AnimState:SetBuild("soul_combustion")
    inst.AnimState:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inventoryitem")
    inst:AddComponent("inspectable")
    inst:AddComponent("stackable")

    MakeHauntableLaunch(inst)
    
    return inst

end

STRINGS.NAMES.SOUL_COMBUSTION = "Soul of Combustion"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SOUL_COMBUSTION = "I wonder if I could eat it."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOUL_COMBUSTION = "This leaves a slight burning sensation in my hands."

return Prefab("common/inventory/soul_combustion", fn, assets)