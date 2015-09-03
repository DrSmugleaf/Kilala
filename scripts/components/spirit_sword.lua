local Spirit_sword = Class(function(self, inst)
    self.inst = inst
    self.spiritmaterial = nil
end,
nil,
{
    spiritmaterial = onspiritmaterial,
})

function Spirit_sword:OnRemoveFromEntity()
    if self.spiritmaterial ~= nil then
        self.inst:RemoveTag("repairable_"..self.spiritmaterial)
    end
end

function Repairable:Repair(doer, repair_item)
    local didrepair = false

	if self.inst.components.health and self.inst.components.health:GetPercent() < 1 then
		if repair_item.components.repairer and self.spiritmaterial == repair_item.components.repairer.spiritmaterial then
			if self.inst.components.health.DoDelta then
                self.inst.components.health:DoDelta(repair_item.components.repairer.healthrepairvalue)
                self.inst.components.health:DoDelta(repair_item.components.repairer.healthrepairpercent * self.inst.components.health.maxhealth)
            end
			
			if repair_item.components.stackable then
				repair_item.components.stackable:Get():Remove()
			else
				repair_item:Remove()
			end

            didrepair = true
        end
    end
    if self.inst.components.workable and self.inst.components.workable.workleft and self.inst.components.workable.workleft < self.inst.components.workable.maxwork then
		if repair_item.components.repairer and self.spiritmaterial == repair_item.components.repairer.spiritmaterial then
	        self.inst.components.workable:SetWorkLeft( self.inst.components.workable.workleft + repair_item.components.repairer.workrepairvalue )
			
			if repair_item.components.stackable then
				repair_item.components.stackable:Get():Remove()
			else
				repair_item:Remove()
			end

            didrepair = true
        end
    end
    if self.inst.components.perishable and self.inst.components.perishable.perishremainingtime and self.inst.components.perishable.perishremainingtime < self.inst.components.perishable.perishtime then
        if repair_item.components.repairer and self.spiritmaterial == repair_item.components.repairer.spiritmaterial then
            self.inst.components.perishable:SetPercent( self.inst.components.perishable:GetPercent() + repair_item.components.repairer.perishrepairpercent )

            if repair_item.components.stackable then
                repair_item.components.stackable:Get():Remove()
            else
                repair_item:Remove()
            end

            didrepair = true
        end
    end

    if didrepair and self.onrepaired ~= nil then
        self.onrepaired(self.inst, doer, repair_item)
    end

    return didrepair
end

return Spirit_sword