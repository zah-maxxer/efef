local tsc = getrenv()._G.classes.Camera.GetCframe
local entityPlayer = getrenv()._G.classes.Player.EntityMap
local Camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()  

local function getClosestPlayerToMouse()
    local closestPlayer = nil
    local closestDistance = math.huge 
    local mousePos = mouse.Hit.Position 

    for i, v in pairs(entityPlayer) do
        if v.type == "Player" and not v.sleeping then
            local character = v.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local playerPos = character.HumanoidRootPart.Position
                local distance = (playerPos - mousePos).Magnitude 
                
                if distance < closestDistance then
                    closestPlayer = v
                    closestDistance = distance
                end
            end
        end
    end

    return closestPlayer
end

local originalGetCframe = getrenv()._G.classes.Camera.GetCframe

getrenv()._G.classes.Camera.GetCframe = hookfunction(originalGetCframe, function()
    local cframe = originalGetCframe()
    
    local closestPlayer = getClosestPlayerToMouse()
    
    if closestPlayer then
        local playerPos = closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart")
        if playerPos then
            cframe = CFrame.lookAt(cframe.Position, playerPos.Position)
        end
    end
    
    return cframe
end)
