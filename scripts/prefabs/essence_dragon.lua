local assets =
{
    Asset("ANIM", "anim/essence_dragon.zip"),
}

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("essence_dragon")
    inst.AnimState:SetBuild("essence_dragon")
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

STRINGS.NAMES.ESSENCE_DRAGON = "Drop of Dragon Essence"
STRINGS.CHARACTERS.KILALA.DESCRIBE.ESSENCE_DRAGON = "I have a strong connection to this essence."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ESSENCE_DRAGON = "This looks... powerfully important."

return Prefab("common/inventory/essence_dragon", fn, assets)