hook.Add("Initialize", "Reik.Fahrzeugdroideinitlize", function (ply)
    if not (file.Exists("reik", "DATA")) then
        file.CreateDir("reik")
    end
    
    if not (file.Exists("reik/datapad.json", "DATA")) then
        file.Write("reik/datapad.json", "{}")
    end
    if not (file.Exists("reik/fahrzeugdatapad.json", "DATA")) then
        file.Write("reik/fahrzeugdatapad.json", "{}")
    end
end)

