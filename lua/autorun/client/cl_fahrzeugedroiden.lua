--net.Receive("Reik.openvehicledroid", function ()
   -- local ply = LocalPlayer()
--end)

if atcconsolelooked == nil then
    atcconsolelooked = false
end

local backgroundvehiclecolor = Color(73,71,71,9)
local mainvehiclecolor = Color(0, 0, 0, 135)
local fontvehicledatapad = color_white
atcvehiclerequests = {}
local screenhigh = ScrH()
local screenwide = ScrW()
local function sc(x)
    return x / 1080 * screenhigh
end
local angriff = false 
local atcconsolelooked = false
net.Receive("Reik.requestvehiclenumber", function ()
    local testtable = net.ReadTable()
    local vehicledroidmenu = vgui.Create("DFrame")
    vehicledroidmenu:SetTitle("")
    vehicledroidmenu:Dock(FILL)
    vehicledroidmenu:SetDraggable(false)
    vehicledroidmenu:ShowCloseButton(false)
    vehicledroidmenu:MakePopup()
    vehicledroidmenu.Paint = function (self, w, h)
        draw.RoundedBox(25, w / 3.025, h / 3.555, 610, 710, backgroundvehiclecolor)
        draw.RoundedBox(25, w / 3, h / 3.5, 600, 700, mainvehiclecolor)

        draw.RoundedBox(25, w / 3.025, h / 9.35, 610, 130, backgroundvehiclecolor)
        draw.RoundedBox(25, w / 3, h / 9, 600, 120, mainvehiclecolor)

        draw.RoundedBox(5, w / 3, h / 6, 600, 3, fontvehicledatapad)
        draw.SimpleText("Fahrzeugdroide", "VFSFont_35", w / 2.05, h / 7, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end


    local vehicleKonsoleImageButton = vehicledroidmenu:Add("DImageButton")
    vehicleKonsoleImageButton:SetPos( sc(1200), sc(140) )
    vehicleKonsoleImageButton:SetSize( 30, 30 )
    vehicleKonsoleImageButton:SetImage("materials/closesymbol.png")
    vehicleKonsoleImageButton.DoClick = function()
        vehicledroidmenu:Close()
    end


    vehiclescrollmenu = vehicledroidmenu:Add("DScrollPanel")
    vehiclescrollmenu:SetSize(600, 700)
    vehiclescrollmenu:SetPos(640, 310)
    vehiclescrollmenu.Paint = function(self, w, h)
        --draw.RoundedBox(5, 0, 0 , w, h, color_black)
    end


    local scrollBar = vehiclescrollmenu:GetVBar()
    scrollBar:SetWide(0)
    scrollBar:SetAlpha(0)
    scrollBar.Paint = function() end
    scrollBar.btnUp.Paint = function() end
    scrollBar.btnDown.Paint = function() end
    scrollBar.btnGrip.Paint = function() end

    local yoffsetvehicle = 0

    for k, v in ipairs(testtable.vehicle) do
        local panelforvehicle = vehiclescrollmenu:Add("DPanel")
        panelforvehicle:SetSize(600, 80)
        panelforvehicle:SetPos(0, yoffsetvehicle)
        panelforvehicle.Paint = function(self, w, h)
            draw.RoundedBox(1, sc(20), 10, 560, 1, fontvehicledatapad)
            draw.RoundedBox(1, sc(20), 70, 560, 1, fontvehicledatapad)
            draw.RoundedBox(1, sc(20), 15, 1, 50, fontvehicledatapad)
            draw.RoundedBox(1, sc(580), 15, 1, 50, fontvehicledatapad)
            draw.SimpleText(v.name .. " | Zur Verfügung: " ..v.anzahl, "VFSFont_20", sc(40), sc(30), fontvehicledatapad, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
        end

        local vehiclespawnbutton = vehiclescrollmenu:Add("DButton")
        vehiclespawnbutton:SetSize(185, 40)
        vehiclespawnbutton:SetPos(sc(380), yoffsetvehicle + 20)
        vehiclespawnbutton:SetText("")
        vehiclespawnbutton.Paint = function (self, w, h)
            surface.SetDrawColor(fontvehicledatapad)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.SimpleText("Spawn!", "VFSFont_25", w / 2, h / 2, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    
        vehiclespawnbutton.DoClick = function (self, w, h)
            if angriff == false then
                local angriff = true
                if v.anzahl > 0 then
                    vehiclespawnmenupositions()
                    vehicledroidmenu:Close()
                    net.Start("Reik.sendvehicletable")
                        net.WriteTable(v)
                    net.SendToServer()
                    local angriff = false
                else
                    VoidLib.Notify("ERROR", "Es gibt diesen Fahrzeugtyp nichtmehr!", Color(255, 0, 0), 5)
                end
            end

        end

        yoffsetvehicle = yoffsetvehicle + 70
    end
end)


 
function vehiclespawnmenupositions() 
    vehiclespawndroidmenu = vgui.Create("DFrame")
    vehiclespawndroidmenu:SetTitle("")
    vehiclespawndroidmenu:Dock(FILL)
    vehiclespawndroidmenu:SetDraggable(false)
    vehiclespawndroidmenu:ShowCloseButton(false)
    vehiclespawndroidmenu:MakePopup()
    vehiclespawndroidmenu.Paint = function (self, w, h)
        draw.RoundedBox(25, w / 3.025, h / 3.555, 610, 710, backgroundvehiclecolor)
        draw.RoundedBox(25, w / 3, h / 3.5, 600, 700, mainvehiclecolor)

        draw.RoundedBox(25, w / 3.025, h / 9.35, 610, 130, backgroundvehiclecolor)
        draw.RoundedBox(25, w / 3, h / 9, 600, 120, mainvehiclecolor)

        draw.RoundedBox(5, w / 3, h / 6, 600, 3, fontvehicledatapad)
        draw.SimpleText("Fahrzeugdroide", "VFSFont_35", w / 2.05, h / 7, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local vehiclepositionKonsoleImageButton = vehiclespawndroidmenu:Add("DImageButton")
    vehiclepositionKonsoleImageButton:SetPos( sc(1200), sc(140) )
    vehiclepositionKonsoleImageButton:SetSize( 30, 30 )
    vehiclepositionKonsoleImageButton:SetImage("materials/closesymbol.png")
    vehiclepositionKonsoleImageButton.DoClick = function()
        vehiclespawndroidmenu:Close()
    end


    vehiclespawnscrollmenu = vehiclespawndroidmenu:Add("DScrollPanel")
    vehiclespawnscrollmenu:SetSize(600, 700)
    vehiclespawnscrollmenu:SetPos(640, 310)
    vehiclespawnscrollmenu.Paint = function(self, w, h)
        --draw.RoundedBox(5, 0, 0 , w, h, color_black)
    end

    local scrollBar = vehiclespawnscrollmenu:GetVBar()
    scrollBar:SetWide(0)
    scrollBar:SetAlpha(0)
    scrollBar.Paint = function() end
    scrollBar.btnUp.Paint = function() end
    scrollBar.btnDown.Paint = function() end
    scrollBar.btnGrip.Paint = function() end

    local yoffsetvehiclespawnpoint = 0

    for k, v in ipairs(Reik.vehicles.spawnpoints) do
        if v.map == game.GetMap() then
            local panelforvehiclespawnpoints = vehiclespawnscrollmenu:Add("DPanel")
            panelforvehiclespawnpoints:SetSize(600, 80)
            panelforvehiclespawnpoints:SetPos(0, yoffsetvehiclespawnpoint)
            panelforvehiclespawnpoints.Paint = function(self, w, h)
                draw.RoundedBox(1, sc(20), 10, 560, 1, fontvehicledatapad)
                draw.RoundedBox(1, sc(20), 70, 560, 1, fontvehicledatapad)
                draw.RoundedBox(1, sc(20), 15, 1, 50, fontvehicledatapad)
                draw.RoundedBox(1, sc(580), 15, 1, 50, fontvehicledatapad)
                draw.SimpleText(v.name, "VFSFont_25", sc(40), sc(30), fontvehicledatapad, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
            end
    
            local vehiclespawnspawnpointsbutton = vehiclespawnscrollmenu:Add("DButton")
            vehiclespawnspawnpointsbutton:SetSize(185, 40)
            vehiclespawnspawnpointsbutton:SetPos(sc(380), yoffsetvehiclespawnpoint + 20)
            vehiclespawnspawnpointsbutton:SetText("")
            vehiclespawnspawnpointsbutton.Paint = function (self, w, h)
                surface.SetDrawColor(fontvehicledatapad)
                surface.DrawOutlinedRect(0, 0, w, h)
                draw.SimpleText("Spawn!", "VFSFont_25", w / 2, h / 2, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            vehiclespawnspawnpointsbutton.DoClick = function (self, w, h)
                net.Start("Reik.spawnvehiclesrequest")
                    net.WriteTable(v)
                net.SendToServer()
                vehiclespawndroidmenu:Close()
            end
    
            yoffsetvehiclespawnpoint = yoffsetvehiclespawnpoint + 70
        end
    end
end

net.Receive("Reik.spawnvehiclesrequestreal", function ()
    atcvehiclerequests = net.ReadTable()
    
end)


net.Receive("Reik.GetATCfunktion", function ()
    net.Start("Reik.getatcstuffsv")
    net.SendToServer()
    reiksatckonsole()
end)

function reiksatckonsole()
    yoffsetvehiclespawnpointatc = 0
    atcconsolelooked = false 

    vehicleatcdmenu = vgui.Create("DFrame")
    vehicleatcdmenu:SetTitle("")
    vehicleatcdmenu:Dock(FILL)
    vehicleatcdmenu:SetDraggable(false)
    vehicleatcdmenu:ShowCloseButton(false)
    vehicleatcdmenu:MakePopup()
    vehicleatcdmenu.Paint = function (self, w, h)
        draw.RoundedBox(25, w / 3.025, h / 3.555, 610, 710, backgroundvehiclecolor)
        draw.RoundedBox(25, w / 3, h / 3.5, 600, 700, mainvehiclecolor)

        draw.RoundedBox(25, w / 3.025, h / 9.35, 610, 130, backgroundvehiclecolor)
        draw.RoundedBox(25, w / 3, h / 9, 600, 120, mainvehiclecolor)

        draw.RoundedBox(5, w / 3, h / 6, 600, 3, fontvehicledatapad)
        draw.SimpleText("VTC-Konsole", "VFSFont_35", w / 2.05, h / 7, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local ATCKonsoleImageButton = vehicleatcdmenu:Add("DImageButton")
    ATCKonsoleImageButton:SetPos( sc(1200), sc(140) )
    ATCKonsoleImageButton:SetSize( 30, 30 )
    ATCKonsoleImageButton:SetImage("materials/closesymbol.png")
    ATCKonsoleImageButton.DoClick = function()
        vehicleatcdmenu:Close()
    end


    vehiclespawnatcscrollmenu = vehicleatcdmenu:Add("DScrollPanel")
    vehiclespawnatcscrollmenu:SetSize(600, 700)
    vehiclespawnatcscrollmenu:SetPos(640, 310)
    vehiclespawnatcscrollmenu.Paint = function(self, w, h)
        --draw.RoundedBox(5, 0, 0 , w, h, color_black)
    end

    for k, v in ipairs(atcvehiclerequests) do
        local panelforvehicleatc = vehiclespawnatcscrollmenu:Add("DPanel")
        panelforvehicleatc:SetSize(600, 145)
        panelforvehicleatc:SetPos(0, yoffsetvehiclespawnpointatc)
        panelforvehicleatc.Paint = function(self, w, h)
            draw.RoundedBox(1, sc(20), 20, 560, 1, fontvehicledatapad)
            draw.RoundedBox(1, sc(20), 140, 560, 1, fontvehicledatapad)
            draw.RoundedBox(1, sc(20), 30, 1, 100, fontvehicledatapad)
            draw.RoundedBox(1, sc(580), 30, 1, 100, fontvehicledatapad)
            draw.SimpleText(v.vehiclename .. " | Bei Ausparkpunkt: " ..v.spawnpoinmtname, "VFSFont_18", sc(30), sc(50), fontvehicledatapad, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
            draw.SimpleText("Anfräger: ".. v.angefragterspieler:Nick(), "VFSFont_18", sc(30), sc(80), fontvehicledatapad, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
        end

        local vehiclespawnatcbutton = vehiclespawnatcscrollmenu:Add("DButton")
        vehiclespawnatcbutton:SetSize(185, 40)
        vehiclespawnatcbutton:SetPos(sc(380), yoffsetvehiclespawnpointatc + 30)
        vehiclespawnatcbutton:SetText("")
        vehiclespawnatcbutton.Paint = function (self, w, h)
            surface.SetDrawColor(fontvehicledatapad)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.SimpleText("Genemigen!", "VFSFont_25", w / 2, h / 2, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    
        vehiclespawnatcbutton.DoClick = function (self, w, h)
            net.Start("Reik.spawnvehicles")
                net.WriteTable(v)
            net.SendToServer()
        end

        local vehicleddeclientatcbutton = vehiclespawnatcscrollmenu:Add("DButton")
        vehicleddeclientatcbutton:SetSize(185, 40)
        vehicleddeclientatcbutton:SetPos(sc(380), yoffsetvehiclespawnpointatc + 90)
        vehicleddeclientatcbutton:SetText("")
        vehicleddeclientatcbutton.Paint = function (self, w, h)
            surface.SetDrawColor(fontvehicledatapad)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.SimpleText("Ablehnen!", "VFSFont_25", w / 2, h / 2, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    
        vehicleddeclientatcbutton.DoClick = function (self, w, h)
            net.Start("Reik.dissagretovehiclespawn")
                net.WriteTable(v)
            net.SendToServer()
        end

        yoffsetvehiclespawnpointatc = yoffsetvehiclespawnpointatc + 140
    end

    vehicleatcdmenu.OnClose = function()
        atcconsolelooked = false
    end

end


net.Receive("Reik.spawnvehiclesdeleteship", function ()
    if atcconsolelooked == false then
        atcconsolelooked = true
        atcvehiclerequests = net.ReadTable()
        vehicleatcdmenu:Close()
        reiksatckonsole()
    end
end)

net.Receive("Reik.dissagretovehiclespawnnotfi", function ()
    VoidLib.Notify("VTC Konsole", "Deine Anfrage wurde Abgelehnt!", Color(255, 0, 0), 5)
end)


-- Nachbestellungskonsole


net.Receive("Reik.sendvehiclesnachbestellungtable", function ()
    vehicletablefornachbestellungsdauer = net.ReadTable()
    vehiclenachbestelleungsdroidmenu:Close()
    reiksnachbestellungsmenu()
end)

function reiksnachbestellungsmenu()
    vehiclenachbestelleungsdroidmenu = vgui.Create("DFrame")
    vehiclenachbestelleungsdroidmenu:SetTitle("")
    vehiclenachbestelleungsdroidmenu:Dock(FILL)
    vehiclenachbestelleungsdroidmenu:SetDraggable(false)
    vehiclenachbestelleungsdroidmenu:ShowCloseButton(false)
    vehiclenachbestelleungsdroidmenu:MakePopup()
    vehiclenachbestelleungsdroidmenu.Paint = function (self, w, h)
        draw.RoundedBox(25, w / 3.025, h / 3.555, 610, 710, backgroundvehiclecolor)
            draw.RoundedBox(25, w / 3, h / 3.5, 600, 700, mainvehiclecolor)
    
            draw.RoundedBox(25, w / 3.025, h / 9.35, 610, 130, backgroundvehiclecolor)
            draw.RoundedBox(25, w / 3, h / 9, 600, 120, mainvehiclecolor)
    
            draw.RoundedBox(5, w / 3, h / 6, 600, 3, fontvehicledatapad)
            draw.SimpleText("Nachbestellungskonsole", "VFSFont_35", w / 2.05, h / 7, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    
    local vehiclepositionKonsoleImageButton = vehiclenachbestelleungsdroidmenu:Add("DImageButton")
    vehiclepositionKonsoleImageButton:SetPos( sc(1200), sc(140) )
    vehiclepositionKonsoleImageButton:SetSize( 30, 30 )
    vehiclepositionKonsoleImageButton:SetImage("materials/closesymbol.png")
    vehiclepositionKonsoleImageButton.DoClick = function()
        vehiclenachbestelleungsdroidmenu:Close()
    end
    
    
    vehiclenachbestellungscrollmenu = vehiclenachbestelleungsdroidmenu:Add("DScrollPanel")
    vehiclenachbestellungscrollmenu:SetSize(600, 700)
    vehiclenachbestellungscrollmenu:SetPos(640, 310)
    vehiclenachbestellungscrollmenu.Paint = function(self, w, h)
        --draw.RoundedBox(5, 0, 0 , w, h, color_black)
    end
    
    local scrollBarmtc = vehiclenachbestellungscrollmenu:GetVBar()
    scrollBarmtc:SetWide(0)
    scrollBarmtc:SetAlpha(0)
    scrollBarmtc.Paint = function() end
    scrollBarmtc.btnUp.Paint = function() end
    scrollBarmtc.btnDown.Paint = function() end
    scrollBarmtc.btnGrip.Paint = function() end
    
    local yoffsetvehiclespawnpointntc = 0

    for k, v in pairs(vehicletablefornachbestellung.vehicle) do
        local panelforvehicleatc = vehiclenachbestellungscrollmenu:Add("DPanel")
        panelforvehicleatc:SetSize(600, 145)
        panelforvehicleatc:SetPos(0, yoffsetvehiclespawnpointntc)
        panelforvehicleatc.Paint = function(self, w, h)
            draw.RoundedBox(1, sc(20), 20, 560, 1, fontvehicledatapad)
            draw.RoundedBox(1, sc(20), 140, 560, 1, fontvehicledatapad)
            draw.RoundedBox(1, sc(20), 30, 1, 100, fontvehicledatapad)
            draw.RoundedBox(1, sc(580), 30, 1, 100, fontvehicledatapad)
            draw.SimpleText(v.name , "VFSFont_20", sc(30), sc(30), fontvehicledatapad, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
            draw.SimpleText("Aktuell zur Verfügung: " .. v.anzahl, "VFSFont_20", sc(30), sc(60), fontvehicledatapad, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
            --draw.SimpleText("In Lieferung: " .. vehicletablefornachbestellungsdauer[1].value, "VFSFont_20", sc(30), sc(90), fontvehicledatapad, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
        end

        local vehiclespawnatcbutton = vehiclenachbestellungscrollmenu:Add("DButton")
        vehiclespawnatcbutton:SetSize(185, 40)
        vehiclespawnatcbutton:SetPos(sc(380), yoffsetvehiclespawnpointntc + 30)
        vehiclespawnatcbutton:SetText("")
        vehiclespawnatcbutton.Paint = function (self, w, h)
            surface.SetDrawColor(fontvehicledatapad)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.SimpleText("1 Anfordern!", "VFSFont_25", w / 2, h / 2, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end 
    
        vehiclespawnatcbutton.DoClick = function (self, w, h)
            net.Start("Reik.spawnvehicles")
                net.WriteTable(v)
            net.SendToServer()
        end

        local vehicleddeclientatcbutton = vehiclenachbestellungscrollmenu:Add("DButton")
        vehicleddeclientatcbutton:SetSize(185, 40)
        vehicleddeclientatcbutton:SetPos(sc(380), yoffsetvehiclespawnpointntc + 90)
        vehicleddeclientatcbutton:SetText("")
        vehicleddeclientatcbutton.Paint = function (self, w, h)
            surface.SetDrawColor(fontvehicledatapad)
            surface.DrawOutlinedRect(0, 0, w, h)
            draw.SimpleText("3 Anfordern!", "VFSFont_25", w / 2, h / 2, fontvehicledatapad, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    
        vehicleddeclientatcbutton.DoClick = function (self, w, h)
            net.Start("Reik.dissagretovehiclespawn")
                net.WriteTable(v)
            net.SendToServer()
        end

        yoffsetvehiclespawnpointntc = yoffsetvehiclespawnpointntc + 140
    end
end
net.Receive("Reik.requestvehiclesnachbestellung", function ()
    vehicletablefornachbestellung = net.ReadTable()
    reiksnachbestellungsmenu()

    net.Start("Reik.requestvehiclesnachbestellungtable")
    net.SendToServer()
end)

