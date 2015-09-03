local assets =
{
	Asset("ANIM", "anim/soul_animation.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("soul_animation")
    inst.AnimState:SetBuild("soul_animation")
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

STRINGS.NAMES.SOUL_ANIMATION = "Soul of Animation"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SOUL_ANIMATION = "It has a mind of its own."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOUL_ANIMATION = "Will this walk off on me?"

return Prefab("common/inventory/soul_animation", fn, assets)