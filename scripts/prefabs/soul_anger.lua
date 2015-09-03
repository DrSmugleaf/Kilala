local assets =
{
	Asset("ANIM", "anim/soul_anger.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("soul_anger")
    inst.AnimState:SetBuild("soul_anger")
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

STRINGS.NAMES.SOUL_ANGER = "Soul of Anger"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SOUL_ANGER = "So much infernal rage."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOUL_ANGER = "It wants to bite me."

return Prefab("common/inventory/soul_anger", fn, assets)