local assets =
{
	Asset("ANIM", "anim/flame_hardened_rope.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("flame_hardened_rope")
    inst.AnimState:SetBuild("flame_hardened_rope")
    inst.AnimState:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inventoryitem")
    inst:AddComponent("inspectable")
    inst:AddComponent("stackable")

    MakeHauntableLaunchinst)
    
    return inst

end

STRINGS.NAMES.FLAME_HARDENED_ROPE = "Flame Hardened Rope"
STRINGS.CHARACTERS.KILALA.DESCRIBE.FLAME_HARDENED_ROPE = "A more useful material than regular rope."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FLAME_HARDENED_ROPE = "How is this not burning?"

return Prefab("common/inventory/flame_hardened_rope", fn, assets)