local Darkorb = Class(function(self, inst)
	self.inst = inst
end)

function Darkorb:OnUpgrade(darkborn)
	if self.onupgrade then
		return self.onupgrade(self.inst, darkborn)
	end

	return true
end

return Darkorb