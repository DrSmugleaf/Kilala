local assets=
{
	Asset("ANIM", "anim/magmatic_lens.zip"),
}


local function fn()

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("magmatic_lens")
    inst.AnimState:SetBuild("magmatic_lens")
    inst.AnimState:PlayAnimation("anim")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()
    
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

	return inst

end

STRINGS.NAMES.MAGMATICLENS = "Magmatic Lens"
STRINGS.CHARACTERS.KILALA.DESCRIBE.MAGMATICLENS = ""
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MAGMATICLENS = ""

return Prefab("common/inventory/magmatic_lens", fn, assets)