include("shared.lua")
local scrw, scrh = ScrW(), ScrH()

local function sc(x)
    return x / 1080 * scrh
end

function ENT:Draw()
    self:DrawModel()

    if IsValid then
        local ang = self:LocalToWorldAngles(Angle(0, 90, 90))
        local CENTER = self:OBBCenter()

        cam.Start3D2D(self:LocalToWorld(Vector(- 20, CENTER.y, self:OBBMaxs().z)) + Vector(0, 15, 10), ang, 0.1)
            draw.SimpleText("Vehicle Traffic Control", "RLIB.S31", sc(10), sc(10), color_white, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end

