local assets =
{
	Asset("ANIM", "anim/soul_life.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("soul_life")
    inst.AnimState:SetBuild("soul_life")
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

STRINGS.NAMES.SOUL_LIFE = "Soul of Life"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SOUL_LIFE = "A warm gentle soul, like a soft bed."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOUL_LIFE = "I feel kinda bad."

return Prefab("common/inventory/soul_life", fn, assets)