-- CONFIG 
local SCALE = 10 -- scale multiplier
local COLOR = Color3.fromRGB(0, 170, 255) -- color of your block to follow
local THICKNESS = 0.05 -- thickness of mesh
local TRANSPARENCY = 0.3 -- transparency of mesh
local source = readfile("mesh.lua") -- file name to load


-- dont scroll any lower if you dont know what youre doing


local mesh = loadstring(source)()

local vertices = mesh.vertices
local triangles = mesh.triangles

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local origin = root.Position

local folder = Instance.new("Folder")
folder.Name = "ClientMeshWireframe"
folder.Parent = workspace

local function drawEdge(v1, v2)
    local p1 = Vector3.new(v1[1], v1[2], v1[3]) * SCALE + origin
    local p2 = Vector3.new(v2[1], v2[2], v2[3]) * SCALE + origin

    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Color = COLOR
    part.Material = Enum.Material.Neon
    part.Transparency = TRANSPARENCY
    part.Size = Vector3.new(THICKNESS, THICKNESS, (p2 - p1).Magnitude)
    part.CFrame = CFrame.lookAt((p1 + p2)/2, p2)
    part.Parent = folder
end

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

for _, edge in pairs(edges) do
    local v1 = vertices[edge[1]]
    local v2 = vertices[edge[2]]
    drawEdge(v1, v2)
end
