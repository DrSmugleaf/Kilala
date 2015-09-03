local assets=
{
	Asset("ANIM", "anim/liquid_fire.zip"),
}


local function fn()

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("liquid_fire")
    inst.AnimState:SetBuild("liquid_fire")
    inst.AnimState:PlayAnimation("anim")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()
    
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

	return inst

end

STRINGS.NAMES.LIQUIDFIRE = "Liquid Fire"
STRINGS.CHARACTERS.KILALA.DESCRIBE.LIQUIDFIRE = ""
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIQUIDFIRE = ""

return Prefab("common/inventory/liquid_fire", fn, assets)