local assets = {
	Asset("ANIM", "anim/orbs.zip"),
}

local prefabs = {}


function fireorbfn(inst, fireborn)

	local function usefireorb(inst, fireborn)
		if fireborn.fireorb ~= nil then
			local fireorbAmount = fireborn.fireorbAmount
			local fireorbMAX = 3

			if fireorbAmount < fireorbMAX then
				fireborn.fireorb = fireborn.fireorb+1

				local fireorbMAXM = 4
				local fireorbFound = fireborn.fireorb

				if fireborn.fireorb < fireorbMAXM then
					if fireorbFound == 1 then
						fireborn.components.talker:Say(GetString(fireborn, "ANNOUNCE_FIRE_ORB_1"))
					elseif fireorbFound == 2 then
						fireborn.components.talker:Say(GetString(fireborn, "ANNOUNCE_FIRE_ORB_2"))
					elseif fireorbFound == 3 then
						fireborn.components.talker:Say(GetString(fireborn, "ANNOUNCE_FIRE_ORB_3"))
					end
					inst.components.inventoryitem:RemoveFromOwner(true)
					return true
				end
			end
		end
		return false
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/fire_orb.xml"
	inst.components.inventoryitem.imagename = "fire_orb"

	STRINGS.NAME.FIRE_ORB = "Fire Orb"
	STRINGS.CHARACTERS.KILALA.DESCRIBE.FIRE_ORB = "A wondrously warm orb of fire."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.FIRE_ORB = "I think Kilala would like one of these."

end

function lightorbfn(inst, lightborn)

	local function useLightOrb(inst, lightBorn)
		if lightBorn.lightOrb ~= nil and not darkBorn.darkOrb ~= nil and not darkBorn.darkOrb >= 0 then
			local lightOrbAmount = lightBorn.lightOrbAmount
			local lightOrbMAX = 3

			if lightOrbAmount < lightOrbMAX then
				lightBorn.lightOrb = lightBorn.lightOrb+1

				local lightOrbMAXM = 4
				local lightOrbFound = lightBorn.lightOrb

				if lightBorn.lightOrb < lightOrbMAXM then
					if lightOrbFound == 1 then
						lightBorn.components.talker:Say(GetString(lightBorn, "ANNOUNCE_LIGHT_ORB_1"))
					elseif lightOrbFound == 2 then
						lightBorn.components.talker:Say(GetString(lightBorn, "ANNOUNCE_LIGHT_ORB_2"))
					elseif lightOrbFound == 3 then
						lightBorn.components.talker:Say(GetString(lightBorn, "ANNOUNCE_LIGHT_ORB_3"))
					end
					inst.components.inventoryitem:RemoveFromOwner(true)
					return true
				end
			end
		end
		return false
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/core_of_light.xml"
	inst.components.inventoryitem.imagename = "core_of_light"

	STRINGS.NAME.CORE_OF_LIGHT = "Core of Light"
	STRINGS.CHARACTERS.KILALA.DESCRIBE.CORE_OF_LIGHT = "This leads me down the path of the light flame."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.CORE_OF_LIGHT = "I think Kilala would like one of these."

end

function darkorbfn(inst, darkborn)

	local function useDarkOrb(inst, darkBorn)
		if darkBorn.darkOrb ~= nil and not lightBorn.lightOrb ~= nil and not lightBorn.lightOrb >= 0 then
			local darkOrbAmount = darkBorn.darkOrbAmount
			local darkOrbMAX = 3

			if darkOrbAmount < darkOrbMAX then
				darkBorn.darkOrb = darkBorn.darkOrb+1

				local darkOrbMAXM = 4
				local darkOrbFound = darkBorn.darkOrb

				if darkBorn.darkOrb < darkOrbMAXM then
					if darkOrbFound == 1 then
						darkBorn.components.talker:Say(GetString(darkBorn, "ANNOUNCE_DARK_ORB_1"))
					elseif darkOrbFound == 2 then
						darkBorn.components.talker:Say(GetString(darkBorn, "ANNOUNCE_DARK_ORB_2"))
					elseif darkOrbFound == 3 then
						darkBorn.components.talker:Say(GetString(darkBorn, "ANNOUNCE_DARK_ORB_3"))
					end
					inst.components.inventoryitem:RemoveFromOwner(true)
					return true
				end
			end
		end
		return false
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/core_of_darkness.xml"
	inst.components.inventoryitem.imagename = "core_of_darkness"

	STRINGS.NAME.CORE_OF_DARKNESS = "Core of Darkness"
	STRINGS.CHARACTERS.KILALA.DESCRIBE.CORE_OF_DARKNESS = "This leads me down the path of the dark flame."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.CORE_OF_DARKNESS = "I think Kilala would like one of these."

end

function infernoorbfn(inst, infernoborn)

	local function useInfernoOrb(inst, infernoBorn)
		if infernoBorn.infernoOrb ~= nil then
			local infernoOrbAmount = infernoBorn.infernoOrbAmount
			local infernoOrbMAX = 3

			if infernoOrbAmount < infernoOrbMAX then
				infernoBorn.infernoOrb = infernoBorn.infernoOrb+1

				local infernoOrbMAXM = 4
				local infernoOrbFound = infernoBorn.infernoOrb

				if infernoBorn.infernoOrb < infernoOrbMAXM then
					if infernoOrbFound == 1 then
						infernoBorn.components.talker:Say(GetString(infernoBorn, "ANNOUNCE_INFERNO_ORB_1"))
					elseif infernoOrbFound == 2 then
						infernoBorn.components.talker:Say(GetString(infernoBorn, "ANNOUNCE_INFERNO_ORB_2"))
					elseif infernoOrbFound == 3 then
						infernoBorn.components.talker:Say(GetString(infernoBorn, "ANNOUNCE_INFERNO_ORB_3"))
					end
					inst.components.inventoryitem:RemoveFromOwner(true)
					return true
				end
			end
		end
		return false
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/inferno_charm.xml"
	inst.components.inventoryitem.imagename = "inferno_charm"

	STRINGS.NAME.INFERNO_CHARM = "Inferno Charm"
	STRINGS.CHARACTERS.KILALA.DESCRIBE.INFERNO_CHARM = "I can feel the heat of the internal fire in here."
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.INFERNO_CHARM = "HOT!!!"

end


function MakeOrb(name, usefn)

	local function fn()
		local inst = CreateEntity()

		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()

		MakeInventoryPhysics(inst)

		inst.AnimState:SetBank("orbs")
		inst.AnimState:SetBank("orbs")
		inst.AnimState:PlayAnimation(name)

		if not TheWorld.ismastersim then
			return inst
		end

		inst.entity:SetPristine()

		-----------------------------------

		inst:AddComponent("inspectable")
		--inst:AddComponent("orb")
		inst.components.book.onupgrade = usefn

		inst:AddComponent("inventoryitem")

		inst:AddComponent("finiteuses")
		inst.components.finiteuses:SetMaxUses(1)
		inst.components.finiteuses:SetUses(1)
		inst.components.finiteuses:SetOnFinished(inst.Remove)

		MakeHauntableLaunch(inst)

		return inst
	end

	return Prefab("common/"..name, fn, assets, prefabs)
end

return 	MakeOrb("fire_orb", fireorbfn),
		MakeOrb("light_orb", lightorbfn),
		MakeOrb("dark_orb", darkorbfn),
		MakeOrb("inferno_orb", infernoorbfn)