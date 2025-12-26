local aircraftModel = game.Workspace:WaitForChild("vauhtit4 Aircraft") -- CHANGE TO YOUR USERNAME

local function makeCollisionless(model)
    for _, child in pairs(model:GetDescendants()) do
        if child:IsA("BasePart") then
            child.CanCollide = false
        end
    end
end

makeCollisionless(aircraftModel)
