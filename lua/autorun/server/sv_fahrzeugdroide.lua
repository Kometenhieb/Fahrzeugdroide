airtrafficcontrol = {}
vehicleinrequest = {
    dauer = {
        {
            name = "1 Tag",
            value = 1
        },
        {
            name = "2 Tage",
            value = 2
        },
    }
}

net.Receive("Reik.spawnvehicles", function ()
    local vehicle = net.ReadTable()
    if vehicle.vehiclenumber and vehicle.vehiclenumber > 0 then
        -- Verringere die Anzahl der Fahrzeuge um 1
        
        -- Lese die JSON-Datei mit den Einstellungen
        local settingsdatawithjson = file.Read("reik/fahrzeugdatapad.json", "DATA")
        if not settingsdatawithjson then
            print("Fehler beim Lesen der JSON-Datei")
            return
        end
        
        -- Parse die JSON-Daten
        local settingsdata = util.JSONToTable(settingsdatawithjson)
        if not settingsdata then
            print("Fehler beim Parsen der JSON-Daten")
            return
        end
        
        -- Initialisiere das Fahrzeugarray, falls nicht vorhanden
        if not settingsdata.vehicle then
            settingsdata.vehicle = {}
        end

        -- Suche das Fahrzeug in den Einstellungen
        local found = false
        for _, v in ipairs(settingsdata.vehicle) do
            if v.name == vehicle.vehiclename then
                v.class = vehicle.vehicleclass
                v.anzahl = v.anzahl - 1
                found = true
                break
            end
        end
        
        -- Falls das Fahrzeug nicht gefunden wurde, füge es hinzu
        if not found then
            table.insert(settingsdata.vehicle, {
                name = vehicle.vehiclename,
                class = vehicle.vehicleclass,
                anzahl = vehicle.vehiclenumber
            })
        end



        -- Konvertiere die Daten zurück in JSON und speichere sie
        local newData = util.TableToJSON(settingsdata, true)
        file.Write("reik/fahrzeugdatapad.json", newData)
        removeVehicleFromATC(vehicle.vehiclename)
        local vehicle = ents.Create(vehicle.vehicleclass)
        vehicle:SetPos(Vector(spawnpointvehicledroid.krodx, spawnpointvehicledroid.krody, spawnpointvehicledroid.krodz))
        vehicle:Spawn()

    else
    end
end)

net.Receive("Reik.sendvehicletable", function (len, ply)
    VehicleTable = net.ReadTable()
end)

net.Receive("Reik.getatcstuffsv", function (len, ply)
    net.Start("Reik.spawnvehiclesrequestreal")
    net.WriteTable(airtrafficcontrol)
    net.Broadcast()
end)

net.Receive("Reik.spawnvehiclesrequest", function (len, ply)
    spawnpointvehicledroid = net.ReadTable()
    addvehicleforatckonsole(ply)
end)

function addvehicleforatckonsole(ply)
    local addvehicleforatc = {
        vehiclename = VehicleTable.name,
        vehicleclass = VehicleTable.class,
        vehiclenumber = VehicleTable.anzahl,
        spawnpoinmtname = spawnpointvehicledroid.name,
        krodx = spawnpointvehicledroid.krodx,
        krody = spawnpointvehicledroid.krody,
        krodz = spawnpointvehicledroid.krodz,
        angefragterspieler = ply
    }
    table.insert(airtrafficcontrol, addvehicleforatc)
    net.Start("Reik.spawnvehiclesrequestreal")
    net.WriteTable(airtrafficcontrol)
    net.Broadcast()
end

function removeVehicleFromATC(vehicleName)
    for i, vehicle in ipairs(airtrafficcontrol) do
        if vehicle.vehiclename == vehicleName then
            table.remove(airtrafficcontrol, i)
            net.Start("Reik.spawnvehiclesdeleteship")
            net.WriteTable(airtrafficcontrol)
            net.Broadcast()
            break
        end
    end

end


net.Receive("Reik.dissagretovehiclespawn", function ()
    local vehicle = net.ReadTable()
    removeVehicleFromATC(vehicle.vehiclename)
    net.Start("Reik.dissagretovehiclespawnnotfi")
    net.Send(vehicle.angefragterspieler)
end)


net.Receive("Reik.requestvehiclesnachbestellungtable", function (len, ply)
    net.Start("Reik.sendvehiclesnachbestellungtable")
        net.WriteTable(vehicleinrequest.dauer)
    net.Send(ply)
end)