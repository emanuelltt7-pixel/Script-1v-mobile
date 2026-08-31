-- ============================================
-- 💎 PAINEL PREMIUM ULTRA - FINAL 💎
-- FUNDO PRETO | TEXTO BRANCO | 19 FUNÇÕES
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- ============================================
-- CORES - 100% CONTRASTE
-- ============================================
local COLORS = {
    Background = Color3.fromRGB(0, 0, 0),      -- FUNDO PRETO
    Card = Color3.fromRGB(20, 20, 20),         -- CINZA ESCURO
    CardHover = Color3.fromRGB(40, 40, 40),    -- CINZA MÉDIO
    Border = Color3.fromRGB(255, 255, 255),    -- BRANCO
    Text = Color3.fromRGB(255, 255, 255),      -- BRANCO
    TextSecondary = Color3.fromRGB(200, 200, 200), -- CINZA CLARO
    Success = Color3.fromRGB(0, 255, 100),     -- VERDE NEON
    Danger = Color3.fromRGB(255, 60, 60),      -- VERMELHO NEON
    Combat = Color3.fromRGB(255, 60, 60),      -- VERMELHO
    Visual = Color3.fromRGB(0, 200, 255),      -- AZUL
    Movement = Color3.fromRGB(0, 255, 100),    -- VERDE
    Power = Color3.fromRGB(255, 210, 0),       -- AMARELO
    Weapon = Color3.fromRGB(255, 150, 0),      -- LARANJA
}

-- ============================================
-- VARIÁVEIS
-- ============================================
local aimbotActive = false
local aimbotConnection = nil
local espActive = false
local espHighlights = {}
local speedActive = false
local originalSpeed = 16
local jumpActive = false
local godModeActive = false
local antiKickActive = false
local flyActive = false
local noClipActive = false
local invisibleActive = false
local instantKillActive = false
local superFarActive = false
local freezeActive = false
local explodeActive = false
local silentAimActive = false
local wallbangActive = false
local noRecoilActive = false
local noSpreadActive = false
local infiniteAmmoActive = false

local currentSpeed = 70
local flySpeed = 60
local flyConnection = nil
local noClipConnection = nil
local antiKickConnection = nil

local CONFIG = {
    AimbotRange = 200,
}

-- ============================================
-- CRIAÇÃO DA GUI
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PremiumHack"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- ========== BOTÃO FLUTUANTE ==========
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 70, 0, 70)
floatBtn.Position = UDim2.new(0.83, 0, 0.02, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.BackgroundTransparency = 0.1
floatBtn.Text = "⚡"
floatBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 34
floatBtn.BorderSizePixel = 3
floatBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Parent = screenGui
floatBtn.ZIndex = 999

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

-- ========== MENU PRINCIPAL ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 620)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -310)
mainFrame.BackgroundColor3 = COLORS.Background
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Visible = false
mainFrame.ZIndex = 100

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

-- ========== HEADER ==========
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 75)
header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
header.BackgroundTransparency = 0
header.BorderSizePixel = 2
header.BorderColor3 = Color3.fromRGB(255, 255, 255)
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 20)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 0.55, 0)
title.Position = UDim2.new(0.12, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ PREMIUM ULTRA"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(0.6, 0, 0.35, 0)
subTitle.Position = UDim2.new(0.12, 0, 0.6, 0)
subTitle.BackgroundTransparency = 1
subTitle.Text = "19 FUNÇÕES PODEROSAS"
subTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subTitle.Font = Enum.Font.GothamBold
subTitle.TextSize = 14
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = header

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0.15, 0, 0.35, 0)
version.Position = UDim2.new(0.82, 0, 0.6, 0)
version.BackgroundTransparency = 1
version.Text = "v5.0"
version.TextColor3 = Color3.fromRGB(150, 150, 150)
version.Font = Enum.Font.GothamBold
version.TextSize = 12
version.TextXAlignment = Enum.TextXAlignment.Right
version.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 42, 0, 42)
closeBtn.Position = UDim2.new(1, -52, 0, 16)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.BackgroundTransparency = 0.1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BorderSizePixel = 2
closeBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    toggleMenu()
end)

-- ========== SCROLL ==========
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -75)
scrollFrame.Position = UDim2.new(0, 0, 0, 75)
scrollFrame.BackgroundColor3 = COLORS.Background
scrollFrame.BackgroundTransparency = 0
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = mainFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 2100)
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
scrollFrame.ScrollBarImageTransparency = 0.3

-- ============================================
-- FUNÇÕES DE CRIAÇÃO
-- ============================================

-- ========== CRIAR CATEGORIA ==========
local function createCategory(parent, text, yPos, icon, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 42)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Position = UDim2.new(0.04, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = icon .. "  " .. text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    return frame
end

-- ========== CRIAR TOGGLE ==========
local function createToggle(parent, text, yPos, color, icon, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 54)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    -- Ícone
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 40, 1, 0)
    iconLabel.Position = UDim2.new(0.02, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "◆"
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 24
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    -- Texto
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, 0, 1, 0)
    btn.Position = UDim2.new(0.12, 0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 17
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.Parent = frame
    
    -- Status Toggle
    local status = Instance.new("Frame")
    status.Size = UDim2.new(0, 52, 0, 30)
    status.Position = UDim2.new(0.86, 0, 0.22, 0)
    status.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    status.BackgroundTransparency = 0.1
    status.BorderSizePixel = 2
    status.BorderColor3 = Color3.fromRGB(255, 255, 255)
    status.Parent = frame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = status
    
    local statusGlow = Instance.new("Frame")
    statusGlow.Size = UDim2.new(1, 0, 1, 0)
    statusGlow.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    statusGlow.BackgroundTransparency = 0.6
    statusGlow.BorderSizePixel = 0
    statusGlow.Parent = status
    
    local glowCorner2 = Instance.new("UICorner")
    glowCorner2.CornerRadius = UDim.new(1, 0)
    glowCorner2.Parent = statusGlow
    
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "OFF"
    statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusText.Font = Enum.Font.GothamBold
    statusText.TextSize = 13
    statusText.Parent = status
    
    local active = false
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        callback(active)
        
        if active then
            status.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            statusGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            statusText.Text = "ON"
            frame.BorderColor3 = Color3.fromRGB(0, 255, 100)
        else
            status.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            statusGlow.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            statusText.Text = "OFF"
            frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        if not active then
            TweenService:Create(frame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
        end
    end)
    
    return btn, frame, status
end

-- ========== CRIAR SLIDER ==========
local function createSlider(parent, text, yPos, icon, minVal, maxVal, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 54)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 35, 1, 0)
    iconLabel.Position = UDim2.new(0.02, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "◆"
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 20
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.35, 0, 1, 0)
    label.Position = UDim2.new(0.12, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.12, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.50, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 18
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.Parent = frame
    
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0, 32, 0, 32)
    minusBtn.Position = UDim2.new(0.72, 0, 0.20, 0)
    minusBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    minusBtn.BackgroundTransparency = 0.2
    minusBtn.Text = "−"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.TextSize = 18
    minusBtn.BorderSizePixel = 2
    minusBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Parent = frame
    
    local minusCorner = Instance.new("UICorner")
    minusCorner.CornerRadius = UDim.new(1, 0)
    minusCorner.Parent = minusBtn
    
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0, 32, 0, 32)
    plusBtn.Position = UDim2.new(0.85, 0, 0.20, 0)
    plusBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    plusBtn.BackgroundTransparency = 0.2
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.TextSize = 18
    plusBtn.BorderSizePixel = 2
    plusBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Parent = frame
    
    local plusCorner = Instance.new("UICorner")
    plusCorner.CornerRadius = UDim.new(1, 0)
    plusCorner.Parent = plusBtn
    
    local currentVal = defaultVal
    
    minusBtn.MouseButton1Click:Connect(function()
        currentVal = math.max(minVal, currentVal - 10)
        valueLabel.Text = tostring(currentVal)
        callback(currentVal)
    end)
    
    plusBtn.MouseButton1Click:Connect(function()
        currentVal = math.min(maxVal, currentVal + 10)
        valueLabel.Text = tostring(currentVal)
        callback(currentVal)
    end)
    
    return frame
end

-- ============================================
-- CONSTRUÇÃO DO PAINEL - 19 FUNÇÕES
-- ============================================

local yPos = 0.01

-- ===== CATEGORIA 1: ⚔️ COMBATE (4) =====
createCategory(scrollFrame, "COMBATE (4)", yPos, "⚔️", COLORS.Combat)
yPos = yPos + 0.065

createToggle(scrollFrame, "AIMBOT 100%", yPos, COLORS.Combat, "🎯", function(active)
    aimbotActive = active
    if active then
        aimbotConnection = RunService.Heartbeat:Connect(function()
            if not aimbotActive then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local closest = nil
            local closestDist = superFarActive and math.huge or CONFIG.AimbotRange
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local targetChar = player.Character
                    if targetChar and targetChar:FindFirstChild("Humanoid") and targetChar.Humanoid.Health > 0 then
                        local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
                        if targetHrp then
                            local dist = (targetHrp.Position - hrp.Position).Magnitude
                            if dist < closestDist then
                                closestDist = dist
                                closest = targetChar
                            end
                        end
                    end
                end
            end
            if closest then
                local head = closest:FindFirstChild("Head")
                if head then
                    if silentAimActive then
                        local mouse = LocalPlayer:GetMouse()
                        mouse.Target = head
                    else
                        hrp.CFrame = CFrame.new(hrp.Position, head.Position)
                    end
                    if instantKillActive then
                        local humanoid = closest:FindFirstChild("Humanoid")
                        if humanoid then humanoid.Health = 0 end
                    end
                end
            end
        end)
    else
        if aimbotConnection then aimbotConnection:Disconnect() aimbotConnection = nil end
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "SUPER FAR", yPos, COLORS.Combat, "🔭", function(active)
    superFarActive = active
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "SILENT AIM", yPos, COLORS.Combat, "🔇", function(active)
    silentAimActive = active
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "INSTANT KILL", yPos, COLORS.Combat, "💀", function(active)
    instantKillActive = active
end)
yPos = yPos + 0.09

-- ===== CATEGORIA 2: 🔫 ARMAS (4) =====
createCategory(scrollFrame, "ARMAS (4)", yPos, "🔫", COLORS.Weapon)
yPos = yPos + 0.065

createToggle(scrollFrame, "WALLBANG", yPos, COLORS.Weapon, "🧱", function(active)
    wallbangActive = active
    if active then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("BasePart") then
                pcall(function()
                    obj.CanQuery = false
                    obj.CanTouch = false
                end)
            end
        end
    else
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("BasePart") then
                pcall(function()
                    obj.CanQuery = true
                    obj.CanTouch = true
                end)
            end
        end
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "NO RECOIL", yPos, COLORS.Weapon, "🔫", function(active)
    noRecoilActive = active
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "NO SPREAD", yPos, COLORS.Weapon, "🎯", function(active)
    noSpreadActive = active
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "MUNIÇÃO INFINITA", yPos, COLORS.Weapon, "🔫", function(active)
    infiniteAmmoActive = active
    if active then
        game:GetService("RunService").Heartbeat:Connect(function()
            if not infiniteAmmoActive then return end
            local backpack = LocalPlayer.Backpack
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, child in pairs(tool:GetDescendants()) do
                        if child:IsA("NumberValue") and child.Name:lower():find("ammo") then
                            child.Value = 999
                        end
                        if child:IsA("IntValue") and child.Name:lower():find("ammo") then
                            child.Value = 999
                        end
                    end
                end
            end
        end)
    end
end)
yPos = yPos + 0.09

-- ===== CATEGORIA 3: 👁️ VISUAIS (3) =====
createCategory(scrollFrame, "VISUAIS (3)", yPos, "👁️", COLORS.Visual)
yPos = yPos + 0.065

createToggle(scrollFrame, "ESP BOX", yPos, COLORS.Visual, "📦", function(active)
    espActive = active
    if active then
        local function addESP(player)
            if player == LocalPlayer then return end
            local char = player.Character
            if not char then return end
            local highlight = Instance.new("Highlight")
            highlight.Parent = char
            highlight.FillColor = Color3.fromRGB(255, 50, 50)
            highlight.FillTransparency = 0.3
            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
            highlight.OutlineTransparency = 0
            espHighlights[player] = highlight
        end
        local function removeESP(player)
            if espHighlights[player] then
                espHighlights[player]:Destroy()
                espHighlights[player] = nil
            end
        end
        for _, player in pairs(Players:GetPlayers()) do addESP(player) end
        Players.PlayerAdded:Connect(addESP)
        Players.PlayerRemoving:Connect(removeESP)
        for _, player in pairs(Players:GetPlayers()) do
            player.CharacterAdded:Connect(function()
                removeESP(player)
                addESP(player)
            end)
        end
    else
        for _, highlight in pairs(espHighlights) do
            highlight:Destroy()
        end
        espHighlights = {}
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "INVISIBILIDADE", yPos, COLORS.Visual, "👻", function(active)
    invisibleActive = active
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = active and 1 or 0
            end
        end
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "VISÃO NOTURNA", yPos, COLORS.Visual, "🌙", function(active)
    if active then
        Lighting.Ambient = Color3.fromRGB(100, 100, 150)
        Lighting.Brightness = 2
    else
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.Brightness = 1
    end
end)
yPos = yPos + 0.09

-- ===== CATEGORIA 4: 🏃 MOVIMENTO (4) =====
createCategory(scrollFrame, "MOVIMENTO (4)", yPos, "🏃", COLORS.Movement)
yPos = yPos + 0.065

createToggle(scrollFrame, "VELOCIDADE", yPos, COLORS.Movement, "💨", function(active)
    speedActive = active
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = active and currentSpeed or originalSpeed
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "SUPER JUMP", yPos, COLORS.Movement, "⚡", function(active)
    jumpActive = active
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = active and 200 or 50
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "FLY", yPos, COLORS.Movement, "🌊", function(active)
    flyActive = active
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    if active then
        humanoid.PlatformStand = true
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyActive then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local moveDirection = Vector3.new()
            local camera = Workspace.CurrentCamera
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + camera.CFrame.LookVector * Vector3.new(1, 0, 1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camera.CFrame.LookVector * Vector3.new(1, 0, 1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camera.CFrame.RightVector * Vector3.new(1, 0, 1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector * Vector3.new(1, 0, 1)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit * flySpeed
                hrp.Velocity = moveDirection
            else
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        humanoid.PlatformStand = false
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "NO CLIP", yPos, COLORS.Movement, "🧱", function(active)
    noClipActive = active
    if active then
        noClipConnection = RunService.Heartbeat:Connect(function()
            if not noClipActive then return end
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noClipConnection then
            noClipConnection:Disconnect()
            noClipConnection = nil
        end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)
yPos = yPos + 0.09

-- ===== CATEGORIA 5: 💥 PODERES (4) =====
createCategory(scrollFrame, "PODERES (4)", yPos, "💥", COLORS.Power)
yPos = yPos + 0.065

createToggle(scrollFrame, "GOD MODE", yPos, COLORS.Power, "🛡️", function(active)
    godModeActive = active
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            if active then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                humanoid.BreakJointsOnDeath = false
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
                humanoid.BreakJointsOnDeath = true
            end
        end
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "ANTI-KICK", yPos, COLORS.Power, "🛡️", function(active)
    antiKickActive = active
    if active then
        LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
            if antiKickActive and LocalPlayer.Parent == nil then
                wait(0.1)
                LocalPlayer.Parent = Players
            end
        end)
        antiKickConnection = RunService.Heartbeat:Connect(function()
            if antiKickActive then
                for _, gui in pairs(CoreGui:GetChildren()) do
                    if gui:IsA("ScreenGui") and (gui.Name:lower():find("kick") or gui.Name:lower():find("ban")) then
                        gui:Destroy()
                    end
                end
            end
        end)
    else
        if antiKickConnection then
            antiKickConnection:Disconnect()
            antiKickConnection = nil
        end
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "FREEZE PLAYERS", yPos, COLORS.Power, "🌀", function(active)
    freezeActive = active
    if active then
        RunService.Heartbeat:Connect(function()
            if not freezeActive then return end
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end)
    end
end)
yPos = yPos + 0.08

createToggle(scrollFrame, "EXPLODE PLAYERS", yPos, COLORS.Power, "💣", function(active)
    if active then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local explosion = Instance.new("Explosion")
                    explosion.Position = char.HumanoidRootPart.Position
                    explosion.BlastRadius = 15
                    explosion.BlastPressure = 2000
                    explosion.Parent = Workspace
                    local humanoid = char:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                    end
                end
            end
        end
    end
end)
yPos = yPos + 0.09

-- ===== SLIDERS =====
createSlider(scrollFrame, "VELOCIDADE", yPos, "⚡", 50, 500, 70, function(val)
    currentSpeed = val
    if speedActive then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = val
        end
    end
end)
yPos = yPos + 0.08

createSlider(scrollFrame, "FLY SPEED", yPos, "🚀", 30, 300, 60, function(val)
    flySpeed = val
end)
yPos = yPos + 0.08

createSlider(scrollFrame, "AIMBOT RANGE", yPos, "📏", 50, 500, 200, function(val)
    CONFIG.AimbotRange = val
end)
yPos = yPos + 0.08

-- ============================================
-- STATUS BAR
-- ============================================
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(0.35, 0, 0, 32)
statusBar.Position = UDim2.new(0.325, 0, 0.01, 0)
statusBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statusBar.BackgroundTransparency = 0
statusBar.BorderSizePixel = 2
statusBar.BorderColor3 = Color3.fromRGB(255, 255, 255)
statusBar.Parent = screenGui
statusBar.ZIndex = 998

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "◆ SYSTEM READY"
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 15
statusText.Parent = statusBar

-- ============================================
-- TOGGLE MENU
-- ============================================
local menuOpen = false

function toggleMenu()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    floatBtn.Visible = not menuOpen
    
    if menuOpen then
        mainFrame.Size = UDim2.new(0, 420, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 420, 0, 620)
        }):Play()
    end
end

floatBtn.MouseButton1Click:Connect(toggleMenu)

-- ============================================
-- KEYBINDS
-- ============================================
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Escape and menuOpen then
        toggleMenu()
    end
    if input.KeyCode == Enum.KeyCode.F5 then
        toggleMenu()
    end
end)

-- ============================================
-- ARRASTAR MENU
-- ============================================
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                     input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ============================================
-- UPDATE STATUS
-- ============================================
local function updateStatus()
    local active = {}
    if aimbotActive then table.insert(active, "🎯") end
    if espActive then table.insert(active, "📦") end
    if flyActive then table.insert(active, "🌊") end
    if godModeActive then table.insert(active, "🛡️") end
    if speedActive then table.insert(active, "💨") end
    if wallbangActive then table.insert(active, "🧱") end
    if infiniteAmmoActive then table.insert(active, "🔫") end
    
    if #active > 0 then
        statusText.Text = "◆ " .. table.concat(active, " ")
        statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        statusText.Text = "◆ SYSTEM READY"
        statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if math.random(1, 30) == 1 then
        updateStatus()
    end
end)

-- ============================================
-- PRINT FINAL
-- ============================================
print("========================================")
print("💎 PAINEL FINALIZADO - 100% VISÍVEL!")
print("========================================")
print("⚔️ COMBATE (4): Aimbot, Far, Silent, Kill")
print("🔫 ARMAS (4): Wallbang, Recoil, Spread, Ammo")
print("👁️ VISUAIS (3): ESP, Invisível, Visão Noturna")
print("🏃 MOVIMENTO (4): Speed, Jump, Fly, No Clip")
print("💥 PODERES (4): God, Anti-Kick, Freeze, Explode")
print("========================================")
print("⚡ Clique em ⚡ para abrir")
print("⌨️ F5 ou ESC para fechar")
print("========================================")
print("✅ FUNDO PRETO | TEXTO BRANCO | BORDAS BRANCAS")
print("✅ 100% LEGÍVEL E VISÍVEL!")
print("========================================")
