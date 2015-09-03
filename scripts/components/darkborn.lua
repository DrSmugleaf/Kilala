local Darkborn = Class(function(self, inst)
	self.inst = inst

	inst:AddTag("darkborn")
end)

function Darkborn:OnRemoveFromEntity()
	self.inst:RemoveTag("darkborn")
end

function Darkborn:Upgrade(darkorb)
	if darkorb.components.darkorb then
		if darkorb.components.darkorb.OnUpgrade(self.inst) then
			if darkorb.components.finiteuses then
				darkorb.components.finiteuses:Use(1)
			end
			return true
		end
	end
end

return Darkborn