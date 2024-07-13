AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")




function ENT:Initialize()
    self:SetModel("models/props/starwars/tech/gonk_droid.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:Activate()
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()

    if (IsValid(phys)) then
        phys:Wake()
    end 
end

function ENT:Use(ply)
    local settingsdatawithjson = file.Read("reik/fahrzeugdatapad.json", "DATA")
    local settingsdata = util.JSONToTable(settingsdatawithjson)

    net.Start("Reik.requestvehiclenumber")
        net.WriteTable(settingsdata)
    net.Send(ply)
end 
 