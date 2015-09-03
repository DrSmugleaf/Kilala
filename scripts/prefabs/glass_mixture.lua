local assets=
{
	Asset("ANIM", "anim/glass_mixture.zip"),
}


local function fn()

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("glass_mixture")
    inst.AnimState:SetBuild("glass_mixture")
    inst.AnimState:PlayAnimation("anim")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()
    
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

	return inst

end

STRINGS.NAMES.GLASSMIXTURE = "Glass Mixture"
STRINGS.CHARACTERS.KILALA.DESCRIBE.GLASSMIXTURE = ""
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GLASSMIXTURE = ""

return Prefab("common/inventory/glass_mixture", fn, assets)