local Lightorb = Class(function(self, inst)
	self.inst = inst
end)

function Lightorb:OnUpgrade(lightborn)
	if self.onupgrade then
		return self.onupgrade(self.inst, lightborn)
	end

	return true
end

return Lightorb