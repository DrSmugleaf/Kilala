local assets = {
	Asset("ANIM", "anim/core_light.zip"),
}

prefabs = {
	"orb_light",
}

local function useLightOrb(inst, lightBorn)
	if lightBorn.orb_light ~= nil and not darkBorn.darkOrb ~= nil and not darkBorn.darkOrb >= 0 then then
		local orb_lightAmount = lightBorn.orb_lightAmount
		local orb_lightMAX = 3

		if orb_lightAmount < orb_lightMAX then
			lightBorn.orb_light = lightBorn.orb_light+1

			local orb_lightMAXM = 4
			local orb_lightFound = lightBorn.orb_light

			if lightBorn.orb_light < orb_lightMAXM then
				if orb_lightFound == 1 then
					lightBorn.components.talker:Say(GetString(lightBorn, "ANNOUNCE_CORE_LIGHT_1"))
				elseif orb_lightFound == 2 then
					lightBorn.components.talker:Say(GetString(lightBorn, "ANNOUNCE_CORE_LIGHT_2"))
				elseif orb_lightFound == 3 then
					lightBorn.components.talker:Say(GetString(lightBorn, "ANNOUNCE_CORE_LIGHT_3"))
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

	anim:SetBank("core_light")
	anim:SetBuild("core_light")
	anim:PlayAnimation("idle")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/core_light.xml"
	inst.components.inventoryitem.imagename = "core_light"

	inst:AddComponent("inspectable")

	inst:AddComponent("book")
	inst.components.book.onread = useLightOrb

	MakeHauntableLaunch(inst)

	return inst
end

STRINGS.NAME.CORE_LIGHT = "Core of Light"
STRINGS.CHARACTERS.KILALA.DESCRIBE.CORE_LIGHT = "This leads me down the path of the light flame."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CORE_LIGHT = "I think Kilala would like one of these."

return Prefab("common/inventory/core_light", fn, assets, prefabs)