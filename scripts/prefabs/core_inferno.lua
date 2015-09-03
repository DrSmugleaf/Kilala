local assets = {
	Asset("ANIM", "anim/core_inferno.zip"),
}

prefabs = {
	"orb_inferno",
}

local function useInfernoOrb(inst, infernoBorn)
	if infernoBorn.orb_inferno ~= nil then
		local orb_infernoAmount = infernoBorn.orb_infernoAmount
		local orb_infernoMAX = 3

		if orb_infernoAmount < orb_infernoMAX then
			infernoBorn.orb_inferno = infernoBorn.orb_inferno+1

			local orb_infernoMAXM = 4
			local orb_infernoFound = infernoBorn.orb_inferno

			if infernoBorn.orb_inferno < orb_infernoMAXM then
				if orb_infernoFound == 1 then
					infernoBorn.components.talker:Say(GetString(infernoBorn, "ANNOUNCE_CORE_INFERNO_1"))
				elseif orb_infernoFound == 2 then
					infernoBorn.components.talker:Say(GetString(infernoBorn, "ANNOUNCE_CORE_INFERNO_2"))
				elseif orb_infernoFound == 3 then
					infernoBorn.components.talker:Say(GetString(infernoBorn, "ANNOUNCE_CORE_INFERNO_3"))
				end
				inst.components.inventoryitem:RemoveFromOwner(true)
				return true
			end
		end
	end
	return false
end

local function fn()

	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	local sound = inst.entity:AddSoundEmitter()

	MakeInventoryPhysics(inst)

	anim:SetBank("core_inferno")
	anim:SetBuild("core_inferno")
	anim:PlayAnimation("idle")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/core_inferno.xml"
	inst.components.inventoryitem.imagename = "core_inferno"

	inst:AddComponent("inspectable")

	inst:AddComponent("book")
	inst.components.book.onread = useInfernoOrb

	MakeHauntableLaunch(inst)

	return inst
end

STRINGS.NAME.CORE_INFERNO = "Core of Inferno"
STRINGS.CHARACTERS.KILALA.DESCRIBE.CORE_INFERNO = "I can feel the heat of the internal fire in here."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CORE_INFERNO = "HOT!!!"

return Prefab("common/inventory/core_inferno", fn, assets, prefabs)