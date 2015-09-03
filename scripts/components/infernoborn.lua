local Infernoborn = Class(function(self, inst)
	self.inst = inst

	inst:AddTag("infernoborn")
end)

function Infernoborn:OnRemoveFromEntity()
	self.inst:RemoveTag("infernoborn")
end

function Infernoborn:Upgrade(infernoorb)
	if infernoorb.components.infernoorb then
		if infernoorb.components.infernoorb.OnUpgrade(self.inst) then
			if infernoorb.components.finiteuses then
				infernoorb.components.finiteuses:Use(1)
			end
			return true
		end
	end
end

return Infernoborn