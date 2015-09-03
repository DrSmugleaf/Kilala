local assets = {
	Asset("ANIM", "anim/core_fedora.zip"),
}

local prefabs = {
    "orb_fedora",
}

local function fn()

	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("core_fedora")
    inst.AnimState:SetBuild("core_fedora")
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

STRINGS.NAMES.CORE_FEDORA = "Core of Fedora"
STRINGS.CHARACTERS.KILALA.DESCRIBE.CORE_FEDORA = "Why do I play this game so much?"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CORE_FEDORA = "U wot m8?"

return Prefab("common/inventory/core_fedora", fn, assets)