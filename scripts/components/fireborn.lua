local Fireborn = Class(function(self, inst)
	self.inst = inst

	inst:AddTag("fireborn")
end)

function Fireborn:OnRemoveFromEntity()
	self.inst:RemoveTag("fireborn")
end

function Fireborn:Upgrade(fireorb)
	if fireorb.components.fireorb then
		if fireorb.components.fireorb.OnUpgrade(self.inst) then
			if fireorb.components.finiteuses then
				fireorb.components.finiteuses:Use(1)
			end
			return true
		end
	end
end

return Fireborn