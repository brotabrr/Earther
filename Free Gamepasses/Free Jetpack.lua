local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local offset = CFrame.new(0, 0.2, 0.7)
local jetpackTemplate = ReplicatedStorage:WaitForChild("Jetpack")

local upPressed, downPressed = false, false
local maxFlySpeed = 25
local verticalVel = 0
local easing = 0.1
local jetpackActive = false
local bv
local scriptEnabled = true

local jetpackClone
local jetpackScript
local partsModel
local idleTrack
local fireParts = {}
local animator = humanoid:FindFirstChildWhichIsA("Animator") or Instance.new("Animator", humanoid)

local startHeight = 10
local stopHeight = 4

local function spawnJetpack()
    jetpackClone = jetpackTemplate:Clone()
    jetpackClone.Parent = workspace

    jetpackScript = jetpackClone:FindFirstChildWhichIsA("Script")
    partsModel = jetpackScript:FindFirstChild("Jetpack")

    for _, part in ipairs(partsModel:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 0
            part.CanCollide = false
            part.Anchored = false
        end
    end

    if not partsModel.PrimaryPart then
        partsModel.PrimaryPart = partsModel:FindFirstChildWhichIsA("BasePart")
    end

    partsModel:SetPrimaryPartCFrame(hrp.CFrame * offset)
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = hrp
    weld.Part1 = partsModel.PrimaryPart
    weld.Parent = partsModel.PrimaryPart

    local idleAnim = humanoid.RigType == Enum.HumanoidRigType.R6 and jetpackScript:FindFirstChild("Idle") or jetpackScript:FindFirstChild("IdleR15")
    if idleAnim and idleAnim:IsA("Animation") then
        idleTrack = animator:LoadAnimation(idleAnim)
    end

    fireParts = {}
    for _, fp in ipairs(jetpackScript:GetDescendants()) do
        if fp.Name == "FirePart" then
            table.insert(fireParts, fp)
        end
    end
end

local function activateFireParts()
    for _, fp in ipairs(fireParts) do
        for _, child in ipairs(fp:GetDescendants()) do
            if child:IsA("ParticleEmitter") or child:IsA("Light") then
                child.Enabled = true
            end
        end
    end
end

local function deactivateFireParts()
    for _, fp in ipairs(fireParts) do
        for _, child in ipairs(fp:GetDescendants()) do
            if child:IsA("ParticleEmitter") or child:IsA("Light") then
                child.Enabled = false
            end
        end
    end
end

spawnJetpack()

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.E then upPressed = true end
    if input.KeyCode == Enum.KeyCode.Q then downPressed = true end
    if input.KeyCode == Enum.KeyCode.T then
        scriptEnabled = not scriptEnabled

        if not scriptEnabled then
            if idleTrack and idleTrack.IsPlaying then idleTrack:Stop() end
            idleTrack = nil

            if jetpackClone then
                jetpackClone:Destroy()
                jetpackClone = nil
                partsModel = nil
                fireParts = {}
            end

            if bv then bv:Destroy() bv = nil end
            verticalVel = 0
        else
            spawnJetpack()
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then upPressed = false end
    if input.KeyCode == Enum.KeyCode.Q then downPressed = false end
end)

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Blacklist
rayParams.FilterDescendantsInstances = {character}

RunService.RenderStepped:Connect(function(dt)
    if not scriptEnabled then return end
    if not partsModel then return end

    local origin = hrp.Position
    local groundRay = workspace:Raycast(origin, Vector3.new(0, -2, 0), rayParams)
    local onGround = groundRay ~= nil

    local longRay = workspace:Raycast(origin, Vector3.new(0, -1000, 0), rayParams)
    local distToGround = longRay and (origin.Y - longRay.Position.Y) or math.huge

    local shouldFly
    if distToGround > startHeight and not onGround then
        shouldFly = true
    elseif distToGround <= stopHeight or onGround then
        shouldFly = false
    else
        shouldFly = jetpackActive
    end
    jetpackActive = shouldFly

    if jetpackActive then
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.P = 1250
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = hrp
        end

        if idleTrack and not idleTrack.IsPlaying then idleTrack:Play() end
        activateFireParts()

        local targetVel = 0
        if upPressed then targetVel = maxFlySpeed end
        if downPressed then targetVel = -maxFlySpeed end
        verticalVel = verticalVel + (targetVel - verticalVel) * easing
        bv.Velocity = Vector3.new(0, verticalVel, 0)
    else
        if bv then bv:Destroy() bv = nil end
        if idleTrack and idleTrack.IsPlaying then idleTrack:Stop() end
        deactivateFireParts()
        verticalVel = 0
    end
end)
