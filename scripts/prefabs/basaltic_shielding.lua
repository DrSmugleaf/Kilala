local assets=
{
	Asset("ANIM", "anim/basaltic_shielding.zip"),
}


local function fn()

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("basaltic_shielding")
    inst.AnimState:SetBuild("basaltic_shielding")
    inst.AnimState:PlayAnimation("anim")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()
    
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

	return inst

end

STRINGS.NAMES.BASALTICSHIELDING = "Basaltic Shielding"
STRINGS.CHARACTERS.KILALA.DESCRIBE.BASALTICSHIELDING = ""
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BASALTICSHIELDING = ""

return Prefab("common/inventory/basaltic_shielding", fn, assets)