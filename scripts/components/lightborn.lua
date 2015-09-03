local Lightborn = Class(function(self, inst)
	self.inst = inst

	inst:AddTag("lightborn")
end)

function Lightborn:OnRemoveFromEntity()
	self.inst:RemoveTag("lightborn")
end

function Lightborn:Upgrade(lightorb)
	if lightorb.components.lightorb then
		if lightorb.components.lightorb.OnUpgrade(self.inst) then
			if lightorb.components.finiteuses then
				lightorb.components.finiteuses:Use(1)
			end
			return true
		end
	end
end

return Lightborn