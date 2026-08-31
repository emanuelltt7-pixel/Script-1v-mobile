-- ============================================================
-- 🔥 SCRIPT ULTRA COMPACTO - VERSÃO EXTREMA 🔥
-- PAINEL PEQUENO | FUNÇÕES MAIS FORTES | SEM ERROS
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- ========== CONFIGURAÇÕES EXTREMAS ==========
local CONFIG = {
    AimbotRange = 500,        -- Alcance extremo
    FlySpeed = 200,           -- Voo super rápido
    WalkSpeed = 500,          -- Velocidade máxima
    JumpPower = 500,          -- Pulo estratosférico
    ESPColor = Color3.fromRGB(255, 0, 0),
    AutoFarmDelay = 0.1,
}

-- ========== VARIÁVEIS ==========
local toggles = {
    aimbot = false,
    esp = false,
    speed = false,
    jump = false,
    fly = false,
    noclip = false,
    invisible = false,
    god = false,
    antikick = false,
    freeze = false,
    far = false,
    kill = false,
    farm = false,
    ammo = false,
    nv = false,
}

local connections = {}
local currentSpeed = 500
local originalSpeed = 16

-- ========== GUI COMPACTA ==========
local sg = Instance.new("ScreenGui")
sg.Name = "Hack"
sg.Parent = CoreGui
sg.ResetOnSpawn = false

-- Botão flutuante (pequeno)
local fb = Instance.new("TextButton")
fb.Size = UDim2.new(0, 50, 0, 50)
fb.Position = UDim2.new(0.85, 0, 0.02, 0)
fb.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
fb.BackgroundTransparency = 0.1
fb.Text = "🔥"
fb.TextColor3 = Color3.fromRGB(255, 255, 255)
fb.Font = Enum.Font.GothamBold
fb.TextSize = 24
fb.BorderSizePixel = 0
fb.Parent = sg
fb.ZIndex = 999
Instance.new("UICorner").Parent = fb

-- Painel principal (MENOR)
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 250, 0, 380)
main.Position = UDim2.new(0.5, -125, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(255, 50, 50)
main.Parent = sg
main.Visible = true
main.ZIndex = 100
main.ClipsDescendants = true
Instance.new("UICorner").Parent = main

-- Título (pequeno)
local titulo = Instance.new("Frame")
titulo.Size = UDim2.new(1, 0, 0, 40)
titulo.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
titulo.BorderSizePixel = 0
titulo.Parent = main
Instance.new("UICorner").Parent = titulo

local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(0.7, 0, 1, 0)
lbl.Position = UDim2.new(0.05, 0, 0, 0)
lbl.BackgroundTransparency = 1
lbl.Text = "🔥 ULTRA"
lbl.TextColor3 = Color3.fromRGB(255, 50, 50)
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 18
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = titulo

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -38, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
close.BorderSizePixel = 0
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.Parent = titulo
Instance.new("UICorner").Parent = close

close.MouseButton1Click:Connect(function()
    main.Visible = false
    fb.Visible = true
end)

-- Scroll (menor)
local sc = Instance.new("ScrollingFrame")
sc.Size = UDim2.new(1, 0, 1, -40)
sc.Position = UDim2.new(0, 0, 0, 40)
sc.BackgroundTransparency = 1
sc.BorderSizePixel = 0
sc.Parent = main
sc.CanvasSize = UDim2.new(0, 0, 0, 750)
sc.ScrollBarThickness = 2
sc.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)

-- ========== FUNÇÃO CRIAR BOTÃO (MENOR) ==========
local function btn(parent, text, y, color, icon)
    local b = Instance.new("TextButton")
    local s = Instance.new("UIStroke")
    b.Size = UDim2.new(0.9, 0, 0, 32)
    b.Position = UDim2.new(0.05, 0, y, 0)
    b.Text = icon .. " " .. text .. " [OFF]"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.BackgroundColor3 = Color3.fromRGB(30, 35, 65)
    b.BorderSizePixel = 0
    b.Parent = parent
    b.ZIndex = 101
    Instance.new("UICorner").Parent = b
    s.Thickness = 1.5
    s.Color = color
    s.Parent = b
    return b, s
end

-- ========== CATEGORIAS (PEQUENAS) ==========
local function cat(parent, text, y, cor)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.9, 0, 0, 20)
    l.Position = UDim2.new(0.05, 0, y, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = cor
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
end

cat(sc, "⚔️ COMBATE", 0.01, Color3.fromRGB(255, 80, 80))
local a1, s1 = btn(sc, "AIMBOT", 0.08, Color3.fromRGB(255, 80, 80), "🎯")
local a2, s2 = btn(sc, "FAR", 0.16, Color3.fromRGB(100, 200, 255), "🔭")
local a3, s3 = btn(sc, "KILL", 0.24, Color3.fromRGB(255, 50, 50), "💀")
local a4, s4 = btn(sc, "AMMO", 0.32, Color3.fromRGB(255, 200, 50), "🔫")

cat(sc, "👁️ VISUAIS", 0.40, Color3.fromRGB(100, 200, 255))
local a5, s5 = btn(sc, "ESP", 0.47, Color3.fromRGB(100, 200, 255), "📦")
local a6, s6 = btn(sc, "INVIS", 0.55, Color3.fromRGB(200, 150, 255), "👻")
local a7, s7 = btn(sc, "NIGHT", 0.63, Color3.fromRGB(100, 150, 255), "🌙")

cat(sc, "🏃 MOVIMENTO", 0.71, Color3.fromRGB(100, 255, 100))
local a8, s8 = btn(sc, "SPEED", 0.78, Color3.fromRGB(100, 255, 100), "💨")
local a9, s9 = btn(sc, "JUMP", 0.86, Color3.fromRGB(200, 255, 100), "⚡")
local a10, s10 = btn(sc, "FLY", 0.94, Color3.fromRGB(100, 255, 200), "🌊")
local a11, s11 = btn(sc, "NOCLIP", 1.02, Color3.fromRGB(255, 200, 100), "🧱")

cat(sc, "💥 PODERES", 1.10, Color3.fromRGB(255, 255, 100))
local a12, s12 = btn(sc, "GOD", 1.17, Color3.fromRGB(255, 200, 100), "🛡️")
local a13, s13 = btn(sc, "ANTIKICK", 1.25, Color3.fromRGB(255, 150, 100), "🛡️")
local a14, s14 = btn(sc, "FREEZE", 1.33, Color3.fromRGB(100, 200, 255), "🌀")
local a15, s15 = btn(sc, "EXPLODE", 1.41, Color3.fromRGB(255, 100, 50), "💣")
local a16, s16 = btn(sc, "FARM", 1.49, Color3.fromRGB(100, 255, 150), "🤖")

-- ========== SLIDER VELOCIDADE (MENOR) ==========
local sf = Instance.new("Frame")
sf.Size = UDim2.new(0.9, 0, 0, 35)
sf.Position = UDim2.new(0.05, 0, 1.58, 0)
sf.BackgroundColor3 = Color3.fromRGB(35, 40, 70)
sf.BorderSizePixel = 1
sf.BorderColor3 = Color3.fromRGB(255, 50, 50)
sf.Parent = sc
Instance.new("UICorner").Parent = sf

local sl = Instance.new("TextLabel")
sl.Size = UDim2.new(0.5, 0, 1, 0)
sl.BackgroundTransparency = 1
sl.Text = "⚡ SPEED: 500"
sl.TextColor3 = Color3.fromRGB(255, 255, 255)
sl.Font = Enum.Font.GothamBold
sl.TextSize = 12
sl.TextXAlignment = Enum.TextXAlignment.Left
sl.Parent = sf

local ss = Instance.new("TextButton")
ss.Size = UDim2.new(0.3, 0, 0.8, 0)
ss.Position = UDim2.new(0.65, 0, 0.1, 0)
ss.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
ss.Text = "500"
ss.TextColor3 = Color3.fromRGB(255, 255, 255)
ss.Font = Enum.Font.GothamBold
ss.TextSize = 14
ss.BorderSizePixel = 1
ss.BorderColor3 = Color3.fromRGB(255, 50, 50)
ss.Parent = sf
Instance.new("UICorner").Parent = ss

local speeds = {100, 200, 300, 500, 800, 1000, 2000, 5000}
ss.MouseButton1Click:Connect(function()
    local idx = 0
    for i, v in pairs(speeds) do
        if v == currentSpeed then idx = i break end
    end
    idx = idx % #speeds + 1
    currentSpeed = speeds[idx]
    ss.Text = tostring(currentSpeed)
    sl.Text = "⚡ SPEED: " .. currentSpeed
    if toggles.speed then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = currentSpeed
        end
    end
end)

-- ========== FUNÇÕES EXTREMAS ==========

-- 1. AIMBOT
a1.MouseButton1Click:Connect(function()
    toggles.aimbot = not toggles.aimbot
    a1.Text = toggles.aimbot and "🎯 AIMBOT [ON]" or "🎯 AIMBOT [OFF]"
    a1.BackgroundColor3 = toggles.aimbot and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s1.Color = toggles.aimbot and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 80, 80)
    
    if toggles.aimbot then
        if connections.aimbot then connections.aimbot:Disconnect() end
        connections.aimbot = RunService.Heartbeat:Connect(function()
            if not toggles.aimbot then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local closest, dist = nil, toggles.far and math.huge or CONFIG.AimbotRange
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local tc = p.Character
                    if tc and tc:FindFirstChild("Humanoid") and tc.Humanoid.Health > 0 then
                        local th = tc:FindFirstChild("HumanoidRootPart")
                        if th then
                            local d = (th.Position - hrp.Position).Magnitude
                            if d < dist then
                                dist, closest = d, tc
                            end
                        end
                    end
                end
            end
            
            if closest then
                local head = closest:FindFirstChild("Head")
                if head then
                    hrp.CFrame = CFrame.new(hrp.Position, head.Position)
                    if toggles.kill then
                        local h = closest:FindFirstChild("Humanoid")
                        if h and h.Health > 0 then h.Health = 0 end
                    end
                end
            end
        end)
    else
        if connections.aimbot then connections.aimbot:Disconnect() end
    end
end)

-- 2. FAR
a2.MouseButton1Click:Connect(function()
    toggles.far = not toggles.far
    a2.Text = toggles.far and "🔭 FAR [ON]" or "🔭 FAR [OFF]"
    a2.BackgroundColor3 = toggles.far and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s2.Color = toggles.far and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 255)
end)

-- 3. KILL
a3.MouseButton1Click:Connect(function()
    toggles.kill = not toggles.kill
    a3.Text = toggles.kill and "💀 KILL [ON]" or "💀 KILL [OFF]"
    a3.BackgroundColor3 = toggles.kill and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s3.Color = toggles.kill and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
end)

-- 4. AMMO
a4.MouseButton1Click:Connect(function()
    toggles.ammo = not toggles.ammo
    a4.Text = toggles.ammo and "🔫 AMMO [ON]" or "🔫 AMMO [OFF]"
    a4.BackgroundColor3 = toggles.ammo and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s4.Color = toggles.ammo and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 200, 50)
    
    if toggles.ammo then
        if connections.ammo then connections.ammo:Disconnect() end
        connections.ammo = RunService.Heartbeat:Connect(function()
            if not toggles.ammo then return end
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, c in pairs(tool:GetDescendants()) do
                        if c.Name:lower():find("ammo") or c.Name:lower():find("bullet") then
                            if c:IsA("NumberValue") or c:IsA("IntValue") then c.Value = 999 end
                        end
                    end
                end
            end
            local char = LocalPlayer.Character
            if char then
                for _, c in pairs(char:GetDescendants()) do
                    if c.Name:lower():find("ammo") or c.Name:lower():find("bullet") then
                        if c:IsA("NumberValue") or c:IsA("IntValue") then c.Value = 999 end
                    end
                end
            end
        end)
    else
        if connections.ammo then connections.ammo:Disconnect() end
    end
end)

-- 5. ESP
a5.MouseButton1Click:Connect(function()
    toggles.esp = not toggles.esp
    a5.Text = toggles.esp and "📦 ESP [ON]" or "📦 ESP [OFF]"
    a5.BackgroundColor3 = toggles.esp and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s5.Color = toggles.esp and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 255)
    
    if toggles.esp then
        local function add(p)
            if p == LocalPlayer then return end
            local c = p.Character
            if not c then return end
            local h = Instance.new("Highlight")
            h.Parent = c
            h.FillColor = Color3.fromRGB(255, 50, 50)
            h.FillTransparency = 0.3
            h.OutlineColor = Color3.fromRGB(255, 255, 0)
            connections[p] = h
        end
        local function rem(p)
            if connections[p] then connections[p]:Destroy() end
        end
        for _, p in pairs(Players:GetPlayers()) do add(p) end
        Players.PlayerAdded:Connect(add)
        Players.PlayerRemoving:Connect(rem)
        for _, p in pairs(Players:GetPlayers()) do
            p.CharacterAdded:Connect(function() rem(p) wait(0.1) add(p) end)
        end
    else
        for _, h in pairs(connections) do
            if h and h:IsA("Highlight") then h:Destroy() end
        end
        connections = {}
    end
end)

-- 6. INVIS
a6.MouseButton1Click:Connect(function()
    toggles.invisible = not toggles.invisible
    a6.Text = toggles.invisible and "👻 INVIS [ON]" or "👻 INVIS [OFF]"
    a6.BackgroundColor3 = toggles.invisible and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s6.Color = toggles.invisible and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 150, 255)
    
    local char = LocalPlayer.Character
    if char then
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = toggles.invisible and 1 or 0 end
        end
    end
end)

-- 7. NIGHT
a7.MouseButton1Click:Connect(function()
    toggles.nv = not toggles.nv
    a7.Text = toggles.nv and "🌙 NIGHT [ON]" or "🌙 NIGHT [OFF]"
    a7.BackgroundColor3 = toggles.nv and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s7.Color = toggles.nv and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 150, 255)
    
    if toggles.nv then
        Lighting.Ambient = Color3.fromRGB(150, 150, 200)
        Lighting.Brightness = 3
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 255)
        Lighting.FogEnd = 2000
    else
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        Lighting.FogEnd = 500
    end
end)

-- 8. SPEED
a8.MouseButton1Click:Connect(function()
    toggles.speed = not toggles.speed
    a8.Text = toggles.speed and "💨 SPEED [ON]" or "💨 SPEED [OFF]"
    a8.BackgroundColor3 = toggles.speed and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s8.Color = toggles.speed and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 255, 100)
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = toggles.speed and currentSpeed or originalSpeed
    end
end)

-- 9. JUMP
a9.MouseButton1Click:Connect(function()
    toggles.jump = not toggles.jump
    a9.Text = toggles.jump and "⚡ JUMP [ON]" or "⚡ JUMP [OFF]"
    a9.BackgroundColor3 = toggles.jump and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s9.Color = toggles.jump and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 255, 100)
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = toggles.jump and CONFIG.JumpPower or 50
    end
end)

-- 10. FLY
a10.MouseButton1Click:Connect(function()
    toggles.fly = not toggles.fly
    a10.Text = toggles.fly and "🌊 FLY [ON]" or "🌊 FLY [OFF]"
    a10.BackgroundColor3 = toggles.fly and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s10.Color = toggles.fly and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 255, 200)
    
    local char = LocalPlayer.Character
    if not char then return end
    local h = char:FindFirstChild("Humanoid")
    if not h then return end
    
    if toggles.fly then
        h.PlatformStand = true
        if connections.fly then connections.fly:Disconnect() end
        connections.fly = RunService.Heartbeat:Connect(function()
            if not toggles.fly then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local cam = Workspace.CurrentCamera
            local dir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector * Vector3.new(1,0,1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector * Vector3.new(1,0,1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector * Vector3.new(1,0,1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector * Vector3.new(1,0,1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0,1,0) end
            if dir.Magnitude > 0 then
                hrp.Velocity = dir.Unit * CONFIG.FlySpeed
            else
                hrp.Velocity = Vector3.new(0,0,0)
            end
        end)
    else
        h.PlatformStand = false
        if connections.fly then connections.fly:Disconnect() end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Velocity = Vector3.new(0,0,0) end
    end
end)

-- 11. NOCLIP
a11.MouseButton1Click:Connect(function()
    toggles.noclip = not toggles.noclip
    a11.Text = toggles.noclip and "🧱 NOCLIP [ON]" or "🧱 NOCLIP [OFF]"
    a11.BackgroundColor3 = toggles.noclip and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s11.Color = toggles.noclip and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 200, 100)
    
    if toggles.noclip then
        if connections.noclip then connections.noclip:Disconnect() end
        connections.noclip = RunService.Heartbeat:Connect(function()
            if not toggles.noclip then return end
            local char = LocalPlayer.Character
            if char then
                for _, p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    else
        if connections.noclip then connections.noclip:Disconnect() end
        local char = LocalPlayer.Character
        if char then
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end
end)

-- 12. GOD
a12.MouseButton1Click:Connect(function()
    toggles.god = not toggles.god
    a12.Text = toggles.god and "🛡️ GOD [ON]" or "🛡️ GOD [OFF]"
    a12.BackgroundColor3 = toggles.god and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s12.Color = toggles.god and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 200, 100)
    
    local char = LocalPlayer.Character
    if char then
        local h = char:FindFirstChild("Humanoid")
        if h then
            if toggles.god then
                h.MaxHealth = math.huge
                h.Health = math.huge
                h.BreakJointsOnDeath = false
            else
                h.MaxHealth = 100
                h.Health = 100
                h.BreakJointsOnDeath = true
            end
        end
    end
end)

-- 13. ANTIKICK
a13.MouseButton1Click:Connect(function()
    toggles.antikick = not toggles.antikick
    a13.Text = toggles.antikick and "🛡️ ANTIKICK [ON]" or "🛡️ ANTIKICK [OFF]"
    a13.BackgroundColor3 = toggles.antikick and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s13.Color = toggles.antikick and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 150, 100)
    
    if toggles.antikick then
        LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
            if toggles.antikick and LocalPlayer.Parent == nil then
                wait(0.1)
                LocalPlayer.Parent = Players
            end
        end)
        if connections.antikick then connections.antikick:Disconnect() end
        connections.antikick = RunService.Heartbeat:Connect(function()
            if toggles.antikick then
                for _, g in pairs(CoreGui:GetChildren()) do
                    if g:IsA("ScreenGui") then
                        local n = g.Name:lower()
                        if n:find("kick") or n:find("ban") or n:find("disconnect") then
                            g:Destroy()
                        end
                    end
                end
            end
        end)
    else
        if connections.antikick then connections.antikick:Disconnect() end
    end
end)

-- 14. FREEZE
a14.MouseButton1Click:Connect(function()
    toggles.freeze = not toggles.freeze
    a14.Text = toggles.freeze and "🌀 FREEZE [ON]" or "🌀 FREEZE [OFF]"
    a14.BackgroundColor3 = toggles.freeze and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s14.Color = toggles.freeze and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 255)
    
    if toggles.freeze then
        if connections.freeze then connections.freeze:Disconnect() end
        connections.freeze = RunService.Heartbeat:Connect(function()
            if not toggles.freeze then return end
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local c = p.Character
                    if c and c:FindFirstChild("HumanoidRootPart") then
                        c.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                    end
                end
            end
        end)
    else
        if connections.freeze then connections.freeze:Disconnect() end
    end
end)

-- 15. EXPLODE
a15.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local c = p.Character
            if c and c:FindFirstChild("HumanoidRootPart") then
                local e = Instance.new("Explosion")
                e.Position = c.HumanoidRootPart.Position
                e.BlastRadius = 30
                e.BlastPressure = 5000
                e.Parent = Workspace
                local h = c:FindFirstChild("Humanoid")
                if h and h.Health > 0 then h.Health = 0 end
            end
        end
    end
end)

-- 16. FARM
a16.MouseButton1Click:Connect(function()
    toggles.farm = not toggles.farm
    a16.Text = toggles.farm and "🤖 FARM [ON]" or "🤖 FARM [OFF]"
    a16.BackgroundColor3 = toggles.farm and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    s16.Color = toggles.farm and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 255, 150)
    
    if toggles.farm then
        if connections.farm then connections.farm:Disconnect() end
        connections.farm = RunService.Heartbeat:Connect(function()
            if not toggles.farm then return end
            VirtualUser:ClickButton2(Vector2.new(0,0))
            wait(CONFIG.AutoFarmDelay)
        end)
    else
        if connections.farm then connections.farm:Disconnect() end
    end
end)

-- ========== ARRASTAR ==========
local drag = false
local start, pos
main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        start = i.Position
        pos = main.Position
    end
end)
main.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = i.Position - start
        main.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
    end
end)

-- ========== ABRIR/FECHAR ==========
fb.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
    fb.Visible = true
end)

-- ========== KEYBINDS ==========
UserInputService.InputBegan:Connect(function(i, p)
    if p then return end
    if i.KeyCode == Enum.KeyCode.F5 then
        main.Visible = not main.Visible
        fb.Visible = true
    end
    if i.KeyCode == Enum.KeyCode.F then a10.MouseButton1Click:Fire() end
    if i.KeyCode == Enum.KeyCode.G then a12.MouseButton1Click:Fire() end
    if i.KeyCode == Enum.KeyCode.K then a3.MouseButton1Click:Fire() end
end)

-- ========== ANTI-FALL ==========
spawn(function()
    while true do
        wait(0.5)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            if hrp.Position.Y < -50 then
                hrp.Position = Vector3.new(0, 150, 0)
            end
        end
    end
end)

-- ========== STATUS ==========
local st = Instance.new("Frame")
st.Size = UDim2.new(0.25, 0, 0, 25)
st.Position = UDim2.new(0.37, 0, 0.01, 0)
st.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
st.BackgroundTransparency = 0.4
st.BorderSizePixel = 1
st.BorderColor3 = Color3.fromRGB(0, 255, 100)
st.Parent = sg
st.ZIndex = 998
Instance.new("UICorner").Parent = st

local stxt = Instance.new("TextLabel")
stxt.Size = UDim2.new(1, 0, 1, 0)
stxt.BackgroundTransparency = 1
stxt.Text = "🔥 ULTRA"
stxt.TextColor3 = Color3.fromRGB(0, 255, 100)
stxt.Font = Enum.Font.GothamBold
stxt.TextSize = 13
stxt.Parent = st

-- ========== MENSAGEM ==========
print("========================================")
print("🔥 SCRIPT ULTRA COMPACTO CARREGADO!")
print("========================================")
print("📱 PAINEL PEQUENO E PODEROSO")
print("⚡ FUNÇÕES EXTREMAS:")
print("  🎯 AIMBOT | 💀 KILL | 🔫 AMMO")
print("  📦 ESP | 👻 INVIS | 🌙 NIGHT")
print("  💨 SPEED | ⚡ JUMP | 🌊 FLY")
print("  🛡️ GOD | ❄️ FREEZE | 🤖 FARM")
print("========================================")
print("⌨️  F5=Menu  F=Fly  G=God  K=Kill")
print("========================================")
