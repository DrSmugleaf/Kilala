local Fireorb = Class(function(self, inst)
	self.inst = inst
end)

function Fireorb:OnUpgrade(fireborn)
	if self.onupgrade then
		return self.onupgrade(self.inst, fireborn)
	end

	return true
end

return Fireorb