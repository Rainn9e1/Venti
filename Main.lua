--[[
    Venti ESP
    
    Other = People not on your Team
    Team = People on your Team
    
    Still a few bugs, reexecute if you see wrong colors. (Happens if the user switches teams)
]]

print("Venti [Loading...]")

_G.Settings = {
    ["Team ESP"] = true,
    ["Other ESP"] = true,
    ["Team Color"] = Color3.fromRGB(75, 93, 172),
    ["Other Color"] = Color3.fromRGB(172, 77, 78)
}

local BodyParts = {
    "Head",
    "LowerTorso",
    "UpperTorso",
    "Torso",
    "Left Leg",
    "Right Leg"
}

local Targets = {}
local Players = game:GetService("Players")
local Holder = true

spawn(function()
    while Holder == true and wait(1) do
        if Holder == false then
            break
        end
        
        local TeamName = Players.LocalPlayer.Team
    
        for _,Player in pairs(Players:GetPlayers()) do
            local Error = pcall(function()
                if _G.Settings["Team ESP"] == true then
                    if Player.Team == TeamName then
                        if Player.Name == Players.LocalPlayer.Name then
                            --Pass
                        else
                            table.insert(Targets, Player.Name)
                        end
                    end
                end
                
                if _G.Settings["Other ESP"] == true then
                    if Player.Team == TeamName then
                        --Pass
                    else
                        if Player.Name == Players.LocalPlayer.Name then
                            --Pass
                        else
                            if Player.Team == TeamName then
                                --Double Check
                            else
                                table.insert(Targets, Player.Name)
                            end
                        end
                    end
                end
                
                if _G.Settings["Other ESP"] and _G.Settings["Team ESP"] == false then
                    return(false)
                end
            end)
        end
        
        for _,Target in pairs(Targets) do
            local Player = Players[Target]
            local PChar = Player.Character
            
            for _,BodyPart in pairs(BodyParts) do
                if PChar:FindFirstChild(BodyPart) then
                    if PChar[BodyPart]:FindFirstChild("discord.gg/Kenta") then
                        PChar[BodyPart]:FindFirstChild("discord.gg/Kenta"):Destroy()
                    end
                    
                    local EspBOX = Instance.new("BoxHandleAdornment", PChar[BodyPart])
                    EspBOX.Adornee = PChar[BodyPart]
                    EspBOX.AlwaysOnTop = true
                    EspBOX.ZIndex = 2
                    EspBOX.Name = "discord.gg/Kenta"
                    
                    if Player.Team == TeamName then
                        if _G.Settings["Team ESP"] == true then
                            EspBOX.Color3 = _G.Settings["Team Color"]
                        else
                            EspBOX:Destroy()
                        end
                    else
                        if _G.Settings["Other ESP"] == true then
                            EspBOX.Color3 = _G.Settings["Other Color"]
                        else
                            EspBOX:Destroy()
                        end
                    end
                else
                    print("Venti [Couldn't Find "..BodyPart.." in "..Player.Name.."]")
                end
            end
        end
    end
end)

print("Venti [Loaded!]")
