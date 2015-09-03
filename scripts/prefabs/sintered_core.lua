local assets=
{
	Asset("ANIM", "anim/sintered_core.zip"),
}


local function fn()

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sintered_core")
    inst.AnimState:SetBuild("sintered_core")
    inst.AnimState:PlayAnimation("anim")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()
    
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

	return inst

end

STRINGS.NAMES.SINTEREDCORE = "Sintered Core"
STRINGS.CHARACTERS.KILALA.DESCRIBE.SINTEREDCORE = ""
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SINTEREDCORE = ""

return Prefab("common/inventory/sintered_core", fn, assets)