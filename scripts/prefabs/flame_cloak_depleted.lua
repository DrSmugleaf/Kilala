local assets=
{
	Asset("ANIM", "anim/flame_cloak_depleted.zip"),
}


local function fn()

    local inst = CreateEntity()
    
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("flame_cloak")
    inst.AnimState:SetBuild("flame_cloak")
    inst.AnimState:PlayAnimation("anim")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()
    
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

	inst:AddComponent("cookable")
	inst.components.cookable.product = "flame_cloak"

	return inst

end

STRINGS.NAMES.FLAMECLOAKDEPLETED = "Depleted Flame Cloak"
STRINGS.CHARACTERS.KILALA.DESCRIBE.FLAMECLOAKDEPLETED = "I want to wear it forever."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FLAMECLOAKDEPLETED = "This will keep me warm, but doesn't provide much protection."

return Prefab("common/inventory/flame_cloak_depleted", fn, assets)