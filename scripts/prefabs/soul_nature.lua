local assets =
{
	Asset("ANIM", "anim/soul_nature.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("soul_nature")
    inst.AnimState:SetBuild("soul_nature")
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

STRINGS.NAMES.SOUL_NATURE = "Soul of Nature"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SOUL_NATURE = "The very essence of nature flows from within."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOUL_NATURE = "Will it grow if I plant it?"

return Prefab("common/inventory/soul_nature", fn, assets)