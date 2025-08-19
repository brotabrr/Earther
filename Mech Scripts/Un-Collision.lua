-- Get the model in the workspace
local aircraftModel = game.Workspace:WaitForChild("vauhtit4 Aircraft")

-- Function to set all parts in the model to be collisionless
local function makeCollisionless(model)
    for _, child in pairs(model:GetDescendants()) do
        if child:IsA("BasePart") then
            -- Set the CanCollide property of the part to false
            child.CanCollide = false
        end
    end
end

-- Call the function to make every part collisionless
makeCollisionless(aircraftModel)
