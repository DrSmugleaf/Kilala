local assets = {
	Asset("ANIM", "anim/core_fire.zip"),
}

prefabs = {
	"orb_fire",
}

local function useFireOrb(inst, fireBorn)
	if fireBorn.orb_fire ~= nil then
		local orb_fireAmount = fireBorn.orb_fireAmount
		local orb_fireMAX = 3

		if orb_fireAmount < orb_fireMAX then
			fireBorn.orb_fire = fireBorn.orb_fire+1

			local orb_fireMAXM = 4
			local orb_fireFound = fireBorn.orb_fire

			if fireBorn.orb_fire < orb_fireMAXM then
				if orb_fireFound == 1 then
					fireBorn.components.talker:Say(GetString(fireBorn, "ANNOUNCE_CORE_FIRE_1"))
				elseif orb_fireFound == 2 then
					fireBorn.components.talker:Say(GetString(fireBorn, "ANNOUNCE_CORE_FIRE_2"))
				elseif orb_fireFound == 3 then
					fireBorn.components.talker:Say(GetString(fireBorn, "ANNOUNCE_CORE_FIRE_3"))
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

	anim:SetBank("core_fire")
	anim:SetBuild("core_fire")
	anim:PlayAnimation("idle")

	if not TheWorld.ismastersim then
		return inst
	end

	inst.entity:SetPristine()

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/core_fire.xml"
	inst.components.inventoryitem.imagename = "core_fire"

	inst:AddComponent("inspectable")

	inst:AddComponent("book")
	inst.components.book.onread = useFireOrb

	MakeHauntableLaunch(inst)

	return inst
end

STRINGS.NAME.CORE_FIRE = "Core of Fire"
STRINGS.CHARACTERS.KILALA.DESCRIBE.CORE_FIRE = "A wondrously warm orb of fire."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CORE_FIRE = "I think Kilala would like one of these."

return Prefab("common/inventory/core_fire", fn, assets, prefabs)