local assets =
{
    Asset("ANIM", "anim/fire_spirit_track.zip"),
}

local function OnSave(inst, data)

    data.direction = inst.Transform:GetRotation()

end
        
local function OnLoad(inst, data)

    if data and data.direction then
        inst.Transform:SetRotation(data.direction)
    end

end

local function create(sim)

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddTag("track")
    
    inst.AnimState:SetBank("track")
    inst.AnimState:SetBuild("fire_spirit_track")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder( 3 )
    inst.AnimState:SetRayTestOnBB(true)
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("inspectable")

    inst:StartThread(
        function ()
            Sleep(30)
            fadeout(inst, 15) 
            inst:Remove() 
        end 
    )

    inst.OnLoad = OnLoad
    inst.OnSave = OnSave

    return inst

end

return Prefab("forest/objects/fire_spirit_track", create, assets)