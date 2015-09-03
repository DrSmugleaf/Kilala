local assets =
{
	Asset("ANIM", "anim/soul_ice.zip"),
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("soul_ice")
    inst.AnimState:SetBuild("soul_ice")
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

STRINGS.NAMES.SOUL_ICE = "Soul of Ice"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SOUL_ICE = "This is an ice cold spirit."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SOUL_ICE = "It can still see me."

return Prefab("common/inventory/soul_ice", fn, assets)