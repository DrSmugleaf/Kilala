local assets = {
	Asset("ANIM", "anim/core_darkness.zip"),
}

prefabs = {
	"orb_darkness",
}

local function useDarknessOrb(inst, darkBorn)
	if darkBorn.orb_darkness ~= nil and not lightBorn.lightOrb ~= nil and not lightBorn.lightOrb >= 0 then
		local orb_darknessAmount = darkBorn.orb_darknessAmount
		local orb_darknessMAX = 3

		if orb_darknessAmount < orb_darknessMAX then
			darkBorn.orb_darkness = darkBorn.orb_darkness+1

			local orb_darknessMAXM = 4
			local orb_darknessFound = darkBorn.orb_darkness

			if darkBorn.orb_darkness < orb_darknessMAXM then
				if orb_darknessFound == 1 then
					darkBorn.components.talker:Say(GetString(darkBorn, "ANNOUNCE_CORE_DARKNESS_1"))
				elseif orb_darknessFound == 2 then
					darkBorn.components.talker:Say(GetString(darkBorn, "ANNOUNCE_CORE_DARKNESS_2"))
				elseif orb_darknessFound == 3 then
					darkBorn.components.talker:Say(GetString(darkBorn, "ANNOUNCE_CORE_DARKNESS_3"))
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

	anim:SetBank("core_darkness")
	anim:SetBuild("core_darkness")
	anim:PlayAnimation("idle")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/core_darkness.xml"
	inst.components.inventoryitem.imagename = "core_darkness"

	inst:AddComponent("inspectable")

	inst:AddComponent("book")
	inst.components.book.onread = useDarknessOrb

	MakeHauntableLaunch(inst)

	return inst
end

STRINGS.NAME.CORE_DARKNESS = "Core of Darkness"
STRINGS.CHARACTERS.KILALA.DESCRIBE.CORE_DARKNESS = "This leads me down the path of the dark flame."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CORE_DARKNESS = "I think Kilala would like one of these."

return Prefab("common/inventory/core_darkness", fn, assets, prefabs)