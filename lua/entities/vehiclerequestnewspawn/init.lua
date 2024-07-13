    AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")




function ENT:Initialize()
    self:SetModel("models/lordtrilobite/starwars/isd/imp_console_medium02.mdl")
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
    if SERVER then
        net.Start("Reik.requestvehiclesnachbestellung")
            net.WriteTable(settingsdata)
        net.Send(ply)
    end
end 
 