local SCALE = 4
local THICKNESS = 0.01
local COLOR = Color3.fromRGB(255, 100, 100)
local TRANSPARENCY = 0
local ROT_YAW = 180
local ROT_PITCH = 0
local ROT_ROLL = 0
local BATCH_SIZE = 500 -- reduce this if you have shitty pc
local REF_COLOR = Color3.fromRGB(162, 59, 183)
local FOLDER_NAME = "ClientMeshWireframe"

local oldFolder = workspace:FindFirstChild(FOLDER_NAME)
if oldFolder then oldFolder:Destroy() end

local folder = Instance.new("Folder")
folder.Name = FOLDER_NAME
folder.Parent = workspace

local source = readfile("mesh.lua")
local mesh = loadstring(source)()
local vertices = mesh.vertices
local triangles = mesh.triangles

local playerName = game.Players.LocalPlayer.Name
local aircraftFolder = workspace:WaitForChild("PIayerAircraft"):WaitForChild(playerName)

local refPart
for _, blockModel in pairs(aircraftFolder:GetChildren()) do
    if blockModel:IsA("Model") and blockModel.Name == "BlockStd" then
        local part = blockModel:FindFirstChild("BlockStd")
        if part and part:IsA("BasePart") and part.Color == REF_COLOR then
            refPart = part
            break
        end
    end
end

if not refPart then
    warn("Reference part with color "..tostring(REF_COLOR).." not found!")
    return
end

local lastRefPosition = refPart.Position

local rotCFrame = CFrame.Angles(math.rad(ROT_PITCH), math.rad(ROT_YAW), math.rad(ROT_ROLL))

local edges = {}
for _, tri in ipairs(triangles) do
    local verts = {tri[1], tri[2], tri[3]}
    for i = 1, 3 do
        local a = verts[i]
        local b = verts[i % 3 + 1]
        local key = a < b and (a..":"..b) or (b..":"..a)
        edges[key] = {a, b}
    end
end

local edgeList = {}
for _, edge in pairs(edges) do
    table.insert(edgeList, edge)
end

local placedParts = {}
local partOffsets = {}

local function drawEdge(v1, v2)
    local p1 = rotCFrame * (Vector3.new(v1[1], v1[2], v1[3]) * SCALE)
    local p2 = rotCFrame * (Vector3.new(v2[1], v2[2], v2[3]) * SCALE)
    local mid = (p1 + p2) / 2

    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Color = COLOR
    part.Material = Enum.Material.Neon
    part.Transparency = TRANSPARENCY
    part.Size = Vector3.new(THICKNESS, THICKNESS, (p2 - p1).Magnitude)
    part.CFrame = CFrame.lookAt(mid + refPart.Position, p2 + refPart.Position)
    part.Parent = folder

    table.insert(placedParts, part)
    table.insert(partOffsets, mid)
end

local index = 1
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
    local count = 0
    while index <= #edgeList and count < BATCH_SIZE do
        local edge = edgeList[index]
        local v1 = vertices[edge[1]]
        local v2 = vertices[edge[2]]
        drawEdge(v1, v2)
        index = index + 1
        count = count + 1
    end

    if refPart.Position ~= lastRefPosition then
        local delta = refPart.Position - lastRefPosition
        for i, part in ipairs(placedParts) do
            part.CFrame = CFrame.lookAt(partOffsets[i] + refPart.Position, partOffsets[i] + refPart.Position + (part.CFrame.LookVector))
        end
        lastRefPosition = refPart.Position
    end
end)
