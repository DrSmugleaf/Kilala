local assets =
{
	Asset("ANIM", "anim/soul_fear.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("soul_fear")
    inst.AnimState:SetBuild("soul_fear")
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

STRINGS.NAMES.SOUL_FEAR = "Soul of Fear"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SOUL_FEAR = "Where would such a creature find a home?"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOUL_FEAR = "It gives off an itchy feeling of dread."

return Prefab("common/inventory/soul_fear", fn, assets)