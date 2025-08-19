local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local bodyParts = {
    {name = "Head", color = Color3.fromRGB(0, 255, 0)},
    {name = "Torso", color = Color3.fromRGB(255, 0, 0)},
    {name = "Left Arm", color = Color3.fromRGB(0, 0, 255)},
    {name = "Right Arm", color = Color3.fromRGB(255, 255, 0)},
    {name = "Left Leg", color = Color3.fromRGB(0, 255, 255)},
    {name = "Right Leg", color = Color3.fromRGB(255, 0, 255)}
}

-- List of body parts to ignore rotation for
local ignoreRotation = {
    Head = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true
}

local targetFolder = game.Workspace:FindFirstChild("vauhtit4 Aircraft")-- CHANGE VAUHTIT4 TO YOUR USERNAME!
if targetFolder then
    for _, model in ipairs(targetFolder:GetChildren()) do
        if model:IsA("Model") and model.Name == "BlockStd" then
            for _, part in ipairs(model:GetChildren()) do
                if part:IsA("BasePart") then
                    for _, bodyPart in ipairs(bodyParts) do
                        local characterPart = character:FindFirstChild(bodyPart.name)
                        if characterPart and part.Color == bodyPart.color then
                            part.Massless = true
                            part.Anchored = false
                            part.CanCollide = false

                            local bodyPos = Instance.new("BodyPosition", part)
                            bodyPos.MaxForce = Vector3.new(500000, 500000, 500000)
                            bodyPos.D = 1000 -- Increased damping to reduce lag
                            bodyPos.P = 100000 -- Increased power for responsiveness

                            local bodyGyro = Instance.new("BodyGyro", part)
                            bodyGyro.MaxTorque = Vector3.new(500000, 500000, 500000)
                            bodyGyro.D = 1000
                            bodyGyro.P = 100000

                            task.spawn(function()
                                while part and part.Parent and characterPart and humanoid do
                                    local targetPosition = characterPart.Position + characterPart.Velocity * 0.05

                                    -- Apply 90-degree X rotation if not in ignore list
                                    local targetRotation
                                    if ignoreRotation[bodyPart.name] then
                                        targetRotation = characterPart.CFrame
                                    else
                                        targetRotation = characterPart.CFrame * CFrame.Angles(math.rad(90), 0, 0)
                                    end

                                    bodyPos.Position = targetPosition
                                    bodyGyro.CFrame = targetRotation

                                    task.wait(0.03)
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end
