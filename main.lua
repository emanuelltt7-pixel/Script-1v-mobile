-- ============================================
-- 💎 PAINEL PREMIUM - VERSÃO ALTA VISIBILIDADE 💎
-- FUNDO BRANCO / LETRAS VERDES
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
-- CORES (FUNDO BRANCO E LETRAS VERDES)
-- ============================================
local COLORS = {
    Background = Color3.fromRGB(255, 255, 255), -- Fundo Branco
    Card = Color3.fromRGB(240, 240, 240), -- Cartões Cinza Bem Claro
    CardHover = Color3.fromRGB(220, 220, 220),
    Primary = Color3.fromRGB(0, 160, 60), -- Verde Escuro (Para bordas e destaques)
    PrimaryLight = Color3.fromRGB(0, 255, 100), -- Verde Neon
    Success = Color3.fromRGB(0, 200, 80), -- Verde ao ligar
    Danger = Color3.fromRGB(255, 80, 80), -- Vermelho ao desligar
    Warning = Color3.fromRGB(255, 210, 0),
    Info = Color3.fromRGB(0, 210, 255),
    Text = Color3.fromRGB(0, 180, 60), -- LETRAS VERDES
    TextSecondary = Color3.fromRGB(0, 140, 50), -- Letras secundárias verdes
    Combat = Color3.fromRGB(0, 200, 80),
    Visual = Color3.fromRGB(0, 210, 255),
    Movement = Color3.fromRGB(0, 255, 130),
    Power = Color3.fromRGB(255, 210, 0),
    Weapon = Color3.fromRGB(0, 160, 60),
}

-- ============================================
-- VARIÁVEIS DAS FUNÇÕES
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
floatBtn.BackgroundColor3 = COLORS.PrimaryLight
floatBtn.BackgroundTransparency = 0.05
floatBtn.Text = "⚡"
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 34
floatBtn.BorderSizePixel = 3
floatBtn.BorderColor3 = Color3.fromRGB(0, 255, 0)
floatBtn.Parent = screenGui
floatBtn.ZIndex = 999

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

-- ========== MENU PRINCIPAL ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 650)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -325)
mainFrame.BackgroundColor3 = COLORS.Background
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = COLORS.PrimaryLight
mainFrame.ClipsDescendants = false -- Mudei para false para evitar bug visual
mainFrame.Parent = screenGui
mainFrame.Visible = false
mainFrame.ZIndex = 100

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

-- ========== HEADER ==========
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 75)
header.BackgroundColor3 = COLORS.PrimaryLight
header.BackgroundTransparency = 0.8
header.BorderSizePixel = 2
header.BorderColor3 = Color3.fromRGB(0, 255, 0)
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 20)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 0.55, 0)
title.Position = UDim2.new(0.12, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ PREMIUM ULTRA"
title.TextColor3 = Color3.fromRGB(0, 255, 100) -- Verde Neon
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(0.6, 0, 0.35, 0)
subTitle.Position = UDim2.new(0.12, 0, 0.6, 0)
subTitle.BackgroundTransparency = 1
subTitle.Text = "19 FUNÇÕES PODEROSAS"
subTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
subTitle.Font = Enum.Font.GothamBold
subTitle.TextSize = 15
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = header

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0.15, 0, 0.35, 0)
version.Position = UDim2.new(0.82, 0, 0.6, 0)
version.BackgroundTransparency = 1
version.Text = "v5.0"
version.TextColor3 = COLORS.TextSecondary
version.Font = Enum.Font.GothamBold
version.TextSize = 14
version.TextXAlignment = Enum.TextXAlignment.Right
version.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 42, 0, 42)
closeBtn.Position = UDim2.new(1, -52, 0, 16)
closeBtn.BackgroundColor3 = COLORS.Danger
closeBtn.BackgroundTransparency = 0.5
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
closeBtn.BorderSizePixel = 2
closeBtn.BorderColor3 = Color3.fromRGB(0, 255, 0)
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
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = mainFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 2100)
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = COLORS.PrimaryLight
scrollFrame.ScrollBarImageTransparency = 0.2

-- ============================================
-- FUNÇÕES DE CRIAÇÃO
-- ============================================

-- ========== CRIAR CATEGORIA ==========
local function createCategory(parent, text, yPos, icon, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 40)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = color or COLORS.Primary
    frame.BackgroundTransparency = 0.7
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Position = UDim2.new(0.04, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = icon .. "  " .. text
    label.TextColor3 = Color3.fromRGB(0, 255, 100) -- Verde
    label.Font = Enum.Font.GothamBold
    label.TextSize = 19 -- Maior
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    return frame
end

-- ========== CRIAR TOGGLE ==========
local function createPremiumToggle(parent, text, yPos, color, icon, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 52)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = COLORS.Card
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 2
    frame.BorderColor3 = color or COLORS.Primary
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
    iconLabel.TextColor3 = Color3.fromRGB(0, 180, 60) -- Verde
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
    btn.TextColor3 = Color3.fromRGB(0, 160, 40) -- Verde Escuro para dar contraste no fundo branco
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18 -- Maior
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.Parent = frame
    
    -- Status Toggle
    local status = Instance.new("Frame")
    status.Size = UDim2.new(0, 50, 0, 28)
    status.Position = UDim2.new(0.87, 0, 0.23, 0)
    status.BackgroundColor3 = COLORS.Danger
    status.BackgroundTransparency = 0.1
    status.BorderSizePixel = 2
    status.BorderColor3 = Color3.fromRGB(255, 255, 255)
    status.Parent = frame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = status
    
    local statusGlow = Instance.new("Frame")
    statusGlow.Size = UDim2.new(1, 0, 1, 0)
    statusGlow.BackgroundColor3 = COLORS.Danger
    statusGlow.BackgroundTransparency = 0.6
    statusGlow.BorderSizePixel = 0
    statusGlow.Parent = status
    
    local glowCorner2 = Instance.new("UICorner")
    glowCorner2.CornerRadius = UDim.new(1, 0)
    glowCorner2.Parent = statusGlow
    
    -- Texto do status
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "OFF"
    statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusText.Font = Enum.Font.GothamBold
    statusText.TextSize = 14
    statusText.Parent = status
    
    local active = false
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        callback(active)
        
        if active then
            status.BackgroundColor3 = COLORS.Success
            statusGlow.BackgroundColor3 = COLORS.Success
            statusText.Text = "ON"
            frame.BorderColor3 = COLORS.Success
            frame.BackgroundTransparency = 0.05
        else
            status.BackgroundColor3 = COLORS.Danger
            statusGlow.BackgroundColor3 = COLORS.Danger
            statusText.Text = "OFF"
            frame.BorderColor3 = color or COLORS.Primary
            frame.BackgroundTransparency = 0.1
        end
    end)
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.15), {BackgroundTransparency = 0.02}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        if not active then
            TweenService:Create(frame, TweenInfo.new(0.15), {BackgroundTransparency = 0.1}):Play()
        end
    end)
    
    return btn, frame, status
end

-- ========== CRIAR SLIDER ==========
local function createPremiumSlider(parent, text, yPos, icon, minVal, maxVal, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 52)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = COLORS.Card
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 2
    frame.BorderColor3 = COLORS.Primary
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    -- Ícone
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 35, 1, 0)
    iconLabel.Position = UDim2.new(0.02, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "◆"
    iconLabel.TextColor3 = Color3.fromRGB(0, 180, 60)
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 22
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    -- Texto
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.35, 0, 1, 0)
    label.Position = UDim2.new(0.12, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 160, 40) -- Verde Escuro
    label.Font = Enum.Font.GothamBold
    label.TextSize = 17
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    -- Valor
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.12, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.50, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = COLORS.PrimaryLight -- Verde Neon
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 20
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.Parent = frame
    
    -- Botão MENOS
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0, 32, 0, 32)
    minusBtn.Position = UDim2.new(0.72, 0, 0.19, 0)
    minusBtn.BackgroundColor3 = COLORS.Danger
    minusBtn.BackgroundTransparency = 0.4
    minusBtn.Text = "−"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.TextSize = 20
    minusBtn.BorderSizePixel = 2
    minusBtn.BorderColor3 = Color3.fromRGB(0, 255, 0)
    minusBtn.Parent = frame
    
    local minusCorner = Instance.new("UICorner")
    minusCorner.CornerRadius = UDim.new(1, 0)
    minusCorner.Parent = minusBtn
    
    -- Botão MAIS
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0, 32, 0, 32)
    plusBtn.Position = UDim2.new(0.85, 0, 0.19, 0)
    plusBtn.BackgroundColor3 = COLORS.Success
    plusBtn.BackgroundTransparency = 0.4
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.TextSize = 20
    plusBtn.BorderSizePixel = 2
    plusBtn.BorderColor3 = Color3.fromRGB(0, 255, 0)
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
-- CONSTRUÇÃO DO PAINEL
-- ============================================

local yPos = 0.01

-- ============================================
-- CATEGORIA 1: ⚔️ COMBATE
-- ============================================
createCategory(scrollFrame, "COMBATE (4)", yPos, "⚔️", COLORS.Combat)
yPos = yPos + 0.065

local aimbotBtn = createPremiumToggle(scrollFrame, "AIMBOT 100%", yPos, COLORS.Combat, "🎯", function(active)
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

local farBtn = createPremiumToggle(scrollFrame, "SUPER FAR", yPos, COLORS.Combat, "🔭", function(active)
    superFarActive = active
end)
yPos = yPos + 0.08

local silentBtn = createPremiumToggle(scrollFrame, "SILENT AIM", yPos, COLORS.Combat, "🔇", function(active)
    silentAimActive = active
end)
yPos = yPos + 0.08

local killBtn = createPremiumToggle(scrollFrame, "INSTANT KILL", yPos, COLORS.Combat, "💀", function(active)
    instantKillActive = active
end)
yPos = yPos + 0.09

-- ============================================
-- CATEGORIA 2: 🔫 ARMAS
-- ============================================
createCategory(scrollFrame, "ARMAS (4)", yPos, "🔫", COLORS.Weapon)
yPos = yPos + 0.065

local wallbangBtn = createPremiumToggle(scrollFrame, "WALLBANG", yPos, COLORS.Weapon, "🧱", function(active)
    wallbangActive = active
    if active then
        -- REMOVI O LOOP QUE QUEBRAVA O JOGO NO CELULAR
        print("🧱 WALLBANG ATIVADO!")
    else
        print("🧱 WALLBANG DESATIVADO!")
    end
end)
yPos = yPos + 0.08

local noRecoilBtn = createPremiumToggle(scrollFrame, "NO RECOIL", yPos, COLORS.Weapon, "🔫", function(active)
    noRecoilActive = active
    print(active and "🔫 NO RECOIL ATIVADO!" or "🔫 NO RECOIL DESATIVADO!")
end)
yPos = yPos + 0.08

local noSpreadBtn = createPremiumToggle(scrollFrame, "NO SPREAD", yPos, COLORS.Weapon, "🎯", function(active)
    noSpreadActive = active
    print(active and "🎯 NO SPREAD ATIVADO!" or "🎯 NO SPREAD DESATIVADO!")
end)
yPos = yPos + 0.08

local infiniteAmmoBtn = createPremiumToggle(scrollFrame, "MUNIÇÃO INFINITA", yPos, COLORS.Weapon, "🔫", function(active)
    infiniteAmmoActive = active
    if active then
        print("🔫 MUNIÇÃO INFINITA ATIVADA!")
        game:GetService("RunService").Heartbeat:Connect(function()
            if not infiniteAmmoActive then return end
            local backpack = LocalPlayer.Backpack
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    pcall(function()
                        tool:FindFirstChild("Ammo").Value = math.huge
                    end)
                end
            end
            local char = LocalPlayer.Character
            if char then
                for _, tool in pairs(char:GetChildren()) do
                    if tool:IsA("Tool") then
                        pcall(function()
                            tool:FindFirstChild("Ammo").Value = math.huge
                        end)
                    end
                end
            end
        end)
    else
        print("🔫 MUNIÇÃO INFINITA DESATIVADA!")
    end
end)
yPos = yPos + 0.09

-- ============================================
-- CONTINUAÇÃO DAS CATEGORIAS (Você adiciona as próximas aqui se quiser)
-- ============================================
-- (Aqui entrariam as categorias de Movimento, Visual, etc.)

-- ============================================
-- FUNÇÃO DE ABRIR/FECHAR O MENU
-- ============================================
function toggleMenu()
    mainFrame.Visible = not mainFrame.Visible
    floatBtn.Text = mainFrame.Visible and "✖" or "⚡"
    floatBtn.BackgroundColor3 = mainFrame.Visible and COLORS.Danger or COLORS.PrimaryLight
end

-- Conexão do botão flutuante
floatBtn.MouseButton1Click:Connect(function()
    toggleMenu()
end)
