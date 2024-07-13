AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("Reik.GetATCfunktion")

function ENT:Initialize()
    self:SetModel("models/lordtrilobite/starwars/isd/imp_console_large01.mdl")
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
    net.Start("Reik.GetATCfunktion")
    net.Send(ply)
end 
  