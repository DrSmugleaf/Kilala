local Infernoorb = Class(function(self, inst)
	self.inst = inst
end)

function Infernoorb:OnUpgrade(infernoborn)
	if self.onupgrade then
		return self.onupgrade(self.inst, infernoborn)
	end

	return true
end

return Infernoorb