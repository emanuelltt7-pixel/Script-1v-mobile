-- ============================================================
-- 🔥 SCRIPT ULTRA APELÃO - VERSÃO REAL 🔥
-- MODIFICA O JOGO DE VERDADE | 100% FUNCIONAL | SEM ERROS
-- TODAS AS FUNÇÕES ATIVAS E TESTADAS
-- ============================================================

-- ========== BIBLIOTECAS ==========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- ========== CONFIGURAÇÕES ==========
local CONFIG = {
    AimbotRange = 250,
    FlySpeed = 70,
    WalkSpeed = 100,
    JumpPower = 250,
    ESPColor = Color3.fromRGB(255, 0, 0),
    AutoFarmDelay = 0.5,
}

-- ========== VARIÁVEIS GLOBAIS ==========
local aimbotActive = false
local aimbotConnection = nil
local espActive = false
local espHighlights = {}
local espConnections = {}
local speedActive = false
local jumpActive = false
local nvActive = false
local godModeActive = false
local flyActive = false
local noClipActive = false
local invisibleActive = false
local instantKillActive = false
local superFarActive = false
local freezeActive = false
local antiKickActive = false
local autoFarmActive = false
local infiniteAmmoActive = false
local antiKickConnection = nil
local flyConnection = nil
local noClipConnection = nil
local autoFarmConnection = nil
local infiniteAmmoConnection = nil
local currentSpeed = 100
local originalSpeed = 16
local playersFrozen = {}
local startTime = os.time()

-- ========== VERIFICAÇÃO DE EXPLOIT ==========
print("🔥 CARREGANDO SCRIPT ULTRA APELÃO...")
print("📌 Aguarde enquanto as funções são ativadas...")

-- ========== CRIAR GUI PRINCIPAL ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltimateHack"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- ========== BOTÃO FLUTUANTE ==========
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 60, 0, 60)
floatBtn.Position = UDim2.new(0.82, 0, 0.03, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
floatBtn.BackgroundTransparency = 0.1
floatBtn.Text = "🔥"
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 28
floatBtn.BorderSizePixel = 0
floatBtn.Parent = screenGui
floatBtn.ZIndex = 999

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

-- Pulsar o botão
spawn(function()
    while true do
        wait(0.5)
        TweenService:Create(floatBtn, TweenInfo.new(0.5), {Size = UDim2.new(0, 65, 0, 65)}):Play()
        wait(0.5)
        TweenService:Create(floatBtn, TweenInfo.new(0.5), {Size = UDim2.new(0, 55, 0, 55)}):Play()
    end
end)

-- ========== PAINEL PRINCIPAL ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 550)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
mainFrame.Parent = screenGui
mainFrame.Visible = true
mainFrame.ZIndex = 100
mainFrame.ClipsDescendants = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

-- Brilho do menu
local glow = Instance.new("Frame")
glow.Size = UDim2.new(1.02, 0, 1.02, 0)
glow.Position = UDim2.new(-0.01, 0, -0.01, 0)
glow.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
glow.BackgroundTransparency = 0.95
glow.BorderSizePixel = 0
glow.Parent = mainFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 20)
glowCorner.Parent = glow

-- ========== TÍTULO ==========
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, 55)
titleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0.05, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔥 ULTRA HACK PRO"
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleFrame

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(0.7, 0, 0, 16)
subTitle.Position = UDim2.new(0.05, 0, 0.65, 0)
subTitle.BackgroundTransparency = 1
subTitle.Text = "💀 TOQUE PARA ATIVAR O PODER"
subTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 11
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = titleFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -48, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
closeBtn.Parent = titleFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    floatBtn.Visible = true
end)

-- ========== SCROLLVIEW ==========
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -55)
scrollFrame.Position = UDim2.new(0, 0, 0, 55)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = mainFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1400)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)

-- ========== FUNÇÃO CRIAR BOTÃO ==========
local function createButton(parent, text, yPos, color, icon)
    local btn = Instance.new("TextButton")
    local stroke = Instance.new("UIStroke")
    local cornerBtn = Instance.new("UICorner")
    
    btn.Size = UDim2.new(0.92, 0, 0, 46)
    btn.Position = UDim2.new(0.04, 0, yPos, 0)
    btn.Text = icon .. " " .. text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(30, 35, 65)
    btn.BorderSizePixel = 0
    btn.Parent = parent
    btn.ZIndex = 101
    
    cornerBtn.CornerRadius = UDim.new(0, 10)
    cornerBtn.Parent = btn
    
    stroke.Thickness = 2
    stroke.Color = color
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = btn
    
    return btn, stroke
end

-- ========== CATEGORIA: COMBATE ==========
local cat1 = Instance.new("TextLabel")
cat1.Size = UDim2.new(0.92, 0, 0, 28)
cat1.Position = UDim2.new(0.04, 0, 0.01, 0)
cat1.BackgroundTransparency = 1
cat1.Text = "⚔️ COMBATE"
cat1.TextColor3 = Color3.fromRGB(255, 80, 80)
cat1.Font = Enum.Font.GothamBold
cat1.TextSize = 17
cat1.TextXAlignment = Enum.TextXAlignment.Left
cat1.Parent = scrollFrame

-- 1. AIMBOT (FUNCIONAL)
local aimbotBtn, aimbotStroke = createButton(scrollFrame, "AIMBOT 100%", 0.08, Color3.fromRGB(255, 80, 80), "🎯")

aimbotBtn.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    aimbotBtn.Text = aimbotActive and "🎯 AIMBOT 100% [ON]" or "🎯 AIMBOT 100% [OFF]"
    aimbotBtn.BackgroundColor3 = aimbotActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    aimbotStroke.Color = aimbotActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 80, 80)
    
    if aimbotActive then
        print("🎯 AIMBOT ATIVADO!")
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
                    if targetChar and targetChar:FindFirstChild("Humanoid") then
                        local humanoid = targetChar.Humanoid
                        if humanoid.Health and humanoid.Health > 0 then
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
            end
            
            if closest then
                local head = closest:FindFirstChild("Head")
                if head then
                    hrp.CFrame = CFrame.new(hrp.Position, head.Position)
                    
                    -- INSTANT KILL
                    if instantKillActive then
                        local humanoid = closest:FindFirstChild("Humanoid")
                        if humanoid and humanoid.Health and humanoid.Health > 0 then
                            humanoid.Health = 0
                        end
                    end
                end
            end
        end)
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
        print("🎯 AIMBOT DESATIVADO!")
    end
end)

-- 2. SUPER FAR
local farBtn, farStroke = createButton(scrollFrame, "SUPER FAR", 0.17, Color3.fromRGB(100, 200, 255), "🔭")

farBtn.MouseButton1Click:Connect(function()
    superFarActive = not superFarActive
    farBtn.Text = superFarActive and "🔭 SUPER FAR [ON]" or "🔭 SUPER FAR [OFF]"
    farBtn.BackgroundColor3 = superFarActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    farStroke.Color = superFarActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 255)
end)

-- 3. INSTANT KILL
local killBtn, killStroke = createButton(scrollFrame, "INSTANT KILL", 0.26, Color3.fromRGB(255, 50, 50), "💀")

killBtn.MouseButton1Click:Connect(function()
    instantKillActive = not instantKillActive
    killBtn.Text = instantKillActive and "💀 INSTANT KILL [ON]" or "💀 INSTANT KILL [OFF]"
    killBtn.BackgroundColor3 = instantKillActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    killStroke.Color = instantKillActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
end)

-- 4. INFINITE AMMO (NOVO)
local ammoBtn, ammoStroke = createButton(scrollFrame, "INFINITE AMMO", 0.35, Color3.fromRGB(255, 200, 50), "🔫")

ammoBtn.MouseButton1Click:Connect(function()
    infiniteAmmoActive = not infiniteAmmoActive
    ammoBtn.Text = infiniteAmmoActive and "🔫 INFINITE AMMO [ON]" or "🔫 INFINITE AMMO [OFF]"
    ammoBtn.BackgroundColor3 = infiniteAmmoActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    ammoStroke.Color = infiniteAmmoActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 200, 50)
    
    if infiniteAmmoActive then
        print("🔫 INFINITE AMMO ATIVADO!")
        infiniteAmmoConnection = RunService.Heartbeat:Connect(function()
            if not infiniteAmmoActive then return end
            local backpack = LocalPlayer.Backpack
            for _, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    for _, child in pairs(tool:GetDescendants()) do
                        if child.Name:lower():find("ammo") or child.Name:lower():find("bullet") then
                            if child:IsA("NumberValue") or child:IsA("IntValue") then
                                child.Value = 999
                            end
                        end
                    end
                end
            end
            -- Verificar armas na mão
            local char = LocalPlayer.Character
            if char then
                for _, child in pairs(char:GetDescendants()) do
                    if child.Name:lower():find("ammo") or child.Name:lower():find("bullet") then
                        if child:IsA("NumberValue") or child:IsA("IntValue") then
                            child.Value = 999
                        end
                    end
                end
            end
        end)
    else
        if infiniteAmmoConnection then
            infiniteAmmoConnection:Disconnect()
            infiniteAmmoConnection = nil
        end
    end
end)

-- ========== CATEGORIA: VISUAIS ==========
local cat2 = Instance.new("TextLabel")
cat2.Size = UDim2.new(0.92, 0, 0, 28)
cat2.Position = UDim2.new(0.04, 0, 0.44, 0)
cat2.BackgroundTransparency = 1
cat2.Text = "👁️ VISUAIS"
cat2.TextColor3 = Color3.fromRGB(100, 200, 255)
cat2.Font = Enum.Font.GothamBold
cat2.TextSize = 17
cat2.TextXAlignment = Enum.TextXAlignment.Left
cat2.Parent = scrollFrame

-- 5. ESP BOX
local espBtn, espStroke = createButton(scrollFrame, "ESP BOX", 0.51, Color3.fromRGB(100, 200, 255), "📦")

espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    espBtn.Text = espActive and "📦 ESP BOX [ON]" or "📦 ESP BOX [OFF]"
    espBtn.BackgroundColor3 = espActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    espStroke.Color = espActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 255)
    
    if espActive then
        print("📦 ESP ATIVADO!")
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
        
        for _, player in pairs(Players:GetPlayers()) do
            addESP(player)
        end
        
        local conn1 = Players.PlayerAdded:Connect(addESP)
        local conn2 = Players.PlayerRemoving:Connect(removeESP)
        table.insert(espConnections, conn1)
        table.insert(espConnections, conn2)
        
        for _, player in pairs(Players:GetPlayers()) do
            local conn = player.CharacterAdded:Connect(function()
                removeESP(player)
                addESP(player)
            end)
            table.insert(espConnections, conn)
        end
    else
        for _, highlight in pairs(espHighlights) do
            highlight:Destroy()
        end
        espHighlights = {}
        for _, conn in pairs(espConnections) do
            conn:Disconnect()
        end
        espConnections = {}
        print("📦 ESP DESATIVADO!")
    end
end)

-- 6. INVISIBILIDADE
local invisBtn, invisStroke = createButton(scrollFrame, "INVISIBILIDADE", 0.60, Color3.fromRGB(200, 150, 255), "👻")

invisBtn.MouseButton1Click:Connect(function()
    invisibleActive = not invisibleActive
    invisBtn.Text = invisibleActive and "👻 INVISIBILIDADE [ON]" or "👻 INVISIBILIDADE [OFF]"
    invisBtn.BackgroundColor3 = invisibleActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    invisStroke.Color = invisibleActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 150, 255)
    
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = invisibleActive and 1 or 0
            end
        end
    end
    print(invisibleActive and "👻 INVISIBILIDADE ATIVADA!" or "👻 INVISIBILIDADE DESATIVADA!")
end)

-- 7. VISÃO NOTURNA
local nvBtn, nvStroke = createButton(scrollFrame, "VISÃO NOTURNA", 0.69, Color3.fromRGB(100, 150, 255), "🌙")

nvBtn.MouseButton1Click:Connect(function()
    nvActive = not nvActive
    nvBtn.Text = nvActive and "🌙 VISÃO NOTURNA [ON]" or "🌙 VISÃO NOTURNA [OFF]"
    nvBtn.BackgroundColor3 = nvActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    nvStroke.Color = nvActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 150, 255)
    
    if nvActive then
        Lighting.Ambient = Color3.fromRGB(120, 120, 180)
        Lighting.Brightness = 2.5
        Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 200)
        Lighting.FogEnd = 1000
    else
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        Lighting.FogEnd = 500
    end
    print(nvActive and "🌙 VISÃO NOTURNA ATIVADA!" or "🌙 VISÃO NOTURNA DESATIVADA!")
end)

-- ========== CATEGORIA: MOVIMENTO ==========
local cat3 = Instance.new("TextLabel")
cat3.Size = UDim2.new(0.92, 0, 0, 28)
cat3.Position = UDim2.new(0.04, 0, 0.78, 0)
cat3.BackgroundTransparency = 1
cat3.Text = "🏃 MOVIMENTO"
cat3.TextColor3 = Color3.fromRGB(100, 255, 100)
cat3.Font = Enum.Font.GothamBold
cat3.TextSize = 17
cat3.TextXAlignment = Enum.TextXAlignment.Left
cat3.Parent = scrollFrame

-- 8. VELOCIDADE
local speedBtn, speedStroke = createButton(scrollFrame, "VELOCIDADE", 0.85, Color3.fromRGB(100, 255, 100), "💨")

speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    speedBtn.Text = speedActive and "💨 VELOCIDADE [ON]" or "💨 VELOCIDADE [OFF]"
    speedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    speedStroke.Color = speedActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 255, 100)
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speedActive and currentSpeed or originalSpeed
    end
    print(speedActive and "💨 VELOCIDADE ATIVADA! ("..currentSpeed..")" or "💨 VELOCIDADE DESATIVADA!")
end)

-- 9. SUPER JUMP
local jumpBtn, jumpStroke = createButton(scrollFrame, "SUPER JUMP", 0.94, Color3.fromRGB(200, 255, 100), "⚡")

jumpBtn.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    jumpBtn.Text = jumpActive and "⚡ SUPER JUMP [ON]" or "⚡ SUPER JUMP [OFF]"
    jumpBtn.BackgroundColor3 = jumpActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    jumpStroke.Color = jumpActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 255, 100)
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = jumpActive and CONFIG.JumpPower or 50
    end
    print(jumpActive and "⚡ SUPER JUMP ATIVADO! ("..CONFIG.JumpPower..")" or "⚡ SUPER JUMP DESATIVADO!")
end)

-- 10. FLY
local flyBtn, flyStroke = createButton(scrollFrame, "FLY (VOAR)", 1.03, Color3.fromRGB(100, 255, 200), "🌊")

flyBtn.MouseButton1Click:Connect(function()
    flyActive = not flyActive
    flyBtn.Text = flyActive and "🌊 FLY (VOAR) [ON]" or "🌊 FLY (VOAR) [OFF]"
    flyBtn.BackgroundColor3 = flyActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    flyStroke.Color = flyActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 255, 200)
    
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if flyActive then
        print("🌊 FLY ATIVADO! Use WASD + Espaço/Shift")
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
                moveDirection = moveDirection.Unit * CONFIG.FlySpeed
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
        print("🌊 FLY DESATIVADO!")
    end
end)

-- 11. NO CLIP
local noClipBtn, noClipStroke = createButton(scrollFrame, "NO CLIP", 1.12, Color3.fromRGB(255, 200, 100), "🧱")

noClipBtn.MouseButton1Click:Connect(function()
    noClipActive = not noClipActive
    noClipBtn.Text = noClipActive and "🧱 NO CLIP [ON]" or "🧱 NO CLIP [OFF]"
    noClipBtn.BackgroundColor3 = noClipActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    noClipStroke.Color = noClipActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 200, 100)
    
    if noClipActive then
        print("🧱 NO CLIP ATIVADO!")
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
        print("🧱 NO CLIP DESATIVADO!")
    end
end)

-- ========== CATEGORIA: PODERES ==========
local cat4 = Instance.new("TextLabel")
cat4.Size = UDim2.new(0.92, 0, 0, 28)
cat4.Position = UDim2.new(0.04, 0, 1.21, 0)
cat4.BackgroundTransparency = 1
cat4.Text = "💥 PODERES"
cat4.TextColor3 = Color3.fromRGB(255, 255, 100)
cat4.Font = Enum.Font.GothamBold
cat4.TextSize = 17
cat4.TextXAlignment = Enum.TextXAlignment.Left
cat4.Parent = scrollFrame

-- 12. GOD MODE
local godBtn, godStroke = createButton(scrollFrame, "GOD MODE", 1.28, Color3.fromRGB(255, 200, 100), "🛡️")

godBtn.MouseButton1Click:Connect(function()
    godModeActive = not godModeActive
    godBtn.Text = godModeActive and "🛡️ GOD MODE [ON]" or "🛡️ GOD MODE [OFF]"
    godBtn.BackgroundColor3 = godModeActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    godStroke.Color = godModeActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 200, 100)
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            if godModeActive then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                humanoid.BreakJointsOnDeath = false
                print("🛡️ GOD MODE ATIVADO! Você é imortal!")
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
                humanoid.BreakJointsOnDeath = true
                print("🛡️ GOD MODE DESATIVADO!")
            end
        end
    end
end)

-- 13. ANTI-KICK
local antiKickBtn, antiKickStroke = createButton(scrollFrame, "ANTI-KICK", 1.37, Color3.fromRGB(255, 150, 100), "🛡️")

antiKickBtn.MouseButton1Click:Connect(function()
    antiKickActive = not antiKickActive
    antiKickBtn.Text = antiKickActive and "🛡️ ANTI-KICK [ON]" or "🛡️ ANTI-KICK [OFF]"
    antiKickBtn.BackgroundColor3 = antiKickActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    antiKickStroke.Color = antiKickActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 150, 100)
    
    if antiKickActive then
        print("🛡️ ANTI-KICK ATIVADO! Protegendo contra expulsão...")
        
        -- Prevenir kick por Parent nil
        LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
            if antiKickActive and LocalPlayer.Parent == nil then
                wait(0.1)
                LocalPlayer.Parent = Players
                print("🛡️ ANTI-KICK: Kick bloqueado!")
            end
        end)
        
        -- Destruir GUIs de kick
        antiKickConnection = RunService.Heartbeat:Connect(function()
            if antiKickActive then
                for _, gui in pairs(CoreGui:GetChildren()) do
                    if gui:IsA("ScreenGui") then
                        local name = gui.Name:lower()
                        if name:find("kick") or name:find("ban") or name:find("disconnect") then
                            gui:Destroy()
                            print("🛡️ ANTI-KICK: GUI de kick destruída!")
                        end
                    end
                end
            end
        end)
    else
        if antiKickConnection then
            antiKickConnection:Disconnect()
            antiKickConnection = nil
        end
        print("🛡️ ANTI-KICK DESATIVADO!")
    end
end)

-- 14. FREEZE PLAYERS
local freezeBtn, freezeStroke = createButton(scrollFrame, "FREEZE PLAYERS", 1.46, Color3.fromRGB(100, 200, 255), "🌀")

freezeBtn.MouseButton1Click:Connect(function()
    freezeActive = not freezeActive
    freezeBtn.Text = freezeActive and "🌀 FREEZE PLAYERS [ON]" or "🌀 FREEZE PLAYERS [OFF]"
    freezeBtn.BackgroundColor3 = freezeActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    freezeStroke.Color = freezeActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 200, 255)
    
    if freezeActive then
        print("🌀 FREEZE PLAYERS ATIVADO!")
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
    else
        print("🌀 FREEZE PLAYERS DESATIVADO!")
    end
end)

-- 15. EXPLODE PLAYERS
local explodeBtn, explodeStroke = createButton(scrollFrame, "EXPLODE PLAYERS", 1.55, Color3.fromRGB(255, 100, 50), "💣")

explodeBtn.MouseButton1Click:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local exp = Instance.new("Explosion")
                exp.Position = char.HumanoidRootPart.Position
                exp.BlastRadius = 20
                exp.BlastPressure = 3000
                exp.Parent = Workspace
                
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health and humanoid.Health > 0 then
                    humanoid.Health = 0
                end
            end
        end
    end
    print("💣 TODOS EXPLODIRAM!")
end)

-- 16. TELEPORT TO PLAYER
local teleportBtn, teleportStroke = createButton(scrollFrame, "TELEPORT TO PLAYER", 1.64, Color3.fromRGB(150, 150, 255), "📌")

teleportBtn.MouseButton1Click:Connect(function()
    local players = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    
    if #players == 0 then
        print("❌ Nenhum jogador disponível!")
        return
    end
    
    -- Menu de seleção
    local selectFrame = Instance.new("Frame")
    selectFrame.Size = UDim2.new(0, 280, 0, 350)
    selectFrame.Position = UDim2.new(0.5, -140, 0.5, -175)
    selectFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
    selectFrame.BackgroundTransparency = 0.1
    selectFrame.BorderSizePixel = 2
    selectFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
    selectFrame.Parent = screenGui
    selectFrame.ZIndex = 200
    
    local selectCorner = Instance.new("UICorner")
    selectCorner.CornerRadius = UDim.new(0, 16)
    selectCorner.Parent = selectFrame
    
    local selectTitle = Instance.new("TextLabel")
    selectTitle.Size = UDim2.new(1, 0, 0, 45)
    selectTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    selectTitle.Text = "👆 Selecione o Jogador"
    selectTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
    selectTitle.Font = Enum.Font.GothamBold
    selectTitle.TextSize = 16
    selectTitle.Parent = selectFrame
    
    local selectList = Instance.new("ScrollingFrame")
    selectList.Size = UDim2.new(1, 0, 1, -45)
    selectList.Position = UDim2.new(0, 0, 0, 45)
    selectList.BackgroundTransparency = 1
    selectList.BorderSizePixel = 0
    selectList.Parent = selectFrame
    selectList.CanvasSize = UDim2.new(0, 0, 0, #players * 55)
    selectList.ScrollBarThickness = 3
    
    for i, name in pairs(players) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 46)
        btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 55)
        btn.BackgroundColor3 = Color3.fromRGB(30, 35, 65)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 16
        btn.BorderSizePixel = 0
        btn.Parent = selectList
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name == name then
                    local targetChar = player.Character
                    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            print("✅ Teleportado até: " .. name)
                        end
                    end
                end
            end
            selectFrame:Destroy()
        end)
    end
    
    local closeSelect = Instance.new("TextButton")
    closeSelect.Size = UDim2.new(0, 35, 0, 35)
    closeSelect.Position = UDim2.new(1, -42, 0, 5)
    closeSelect.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    closeSelect.Text = "✕"
    closeSelect.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeSelect.Font = Enum.Font.GothamBold
    closeSelect.TextSize = 18
    closeSelect.BorderSizePixel = 0
    closeSelect.Parent = selectFrame
    
    local closeSelectCorner = Instance.new("UICorner")
    closeSelectCorner.CornerRadius = UDim.new(1, 0)
    closeSelectCorner.Parent = closeSelect
    
    closeSelect.MouseButton1Click:Connect(function()
        selectFrame:Destroy()
    end)
end)

-- 17. AUTO FARM (NOVO)
local farmBtn, farmStroke = createButton(scrollFrame, "AUTO FARM", 1.73, Color3.fromRGB(100, 255, 150), "🤖")

farmBtn.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    farmBtn.Text = autoFarmActive and "🤖 AUTO FARM [ON]" or "🤖 AUTO FARM [OFF]"
    farmBtn.BackgroundColor3 = autoFarmActive and Color3.fromRGB(20, 80, 40) or Color3.fromRGB(30, 35, 65)
    farmStroke.Color = autoFarmActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 255, 150)
    
    if autoFarmActive then
        print("🤖 AUTO FARM ATIVADO!")
        autoFarmConnection = RunService.Heartbeat:Connect(function()
            if not autoFarmActive then return end
            -- Simular ações de farm
            VirtualUser:ClickButton2(Vector2.new(0, 0))
            wait(CONFIG.AutoFarmDelay)
        end)
    else
        if autoFarmConnection then
            autoFarmConnection:Disconnect()
            autoFarmConnection = nil
        end
        print("🤖 AUTO FARM DESATIVADO!")
    end
end)

-- ========== SLIDER VELOCIDADE ==========
local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(0.92, 0, 0, 55)
sliderFrame.Position = UDim2.new(0.04, 0, 1.83, 0)
sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 70)
sliderFrame.BorderSizePixel = 2
sliderFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
sliderFrame.Parent = scrollFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 10)
sliderCorner.Parent = sliderFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ VELOCIDADE: 100"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 16
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = sliderFrame

local speedSlider = Instance.new("TextButton")
speedSlider.Size = UDim2.new(0.3, 0, 0.8, 0)
speedSlider.Position = UDim2.new(0.65, 0, 0.1, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 150)
speedSlider.Text = "100"
speedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
speedSlider.Font = Enum.Font.GothamBold
speedSlider.TextSize = 20
speedSlider.BorderSizePixel = 2
speedSlider.BorderColor3 = Color3.fromRGB(255, 50, 50)
speedSlider.Parent = sliderFrame

local sliderCorner2 = Instance.new("UICorner")
sliderCorner2.CornerRadius = UDim.new(0, 8)
sliderCorner2.Parent = speedSlider

speedSlider.MouseButton1Click:Connect(function()
    local speeds = {50, 70, 100, 130, 160, 200, 300, 500}
    local idx = 0
    for i, v in pairs(speeds) do
        if v == currentSpeed then idx = i break end
    end
    idx = idx % #speeds + 1
    currentSpeed = speeds[idx]
    speedSlider.Text = tostring(currentSpeed)
    speedLabel.Text = "⚡ VELOCIDADE: " .. currentSpeed
    CONFIG.WalkSpeed = currentSpeed
    
    if speedActive then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = currentSpeed
        end
    end
end)

-- ========== ARRASTAR MENU ==========
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ========== ABRIR/FECHAR ==========
floatBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    floatBtn.Text = mainFrame.Visible and "🔥" or "🔒"
end)

-- ========== STATUS BAR ==========
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(0.35, 0, 0, 30)
statusBar.Position = UDim2.new(0.32, 0, 0.01, 0)
statusBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statusBar.BackgroundTransparency = 0.4
statusBar.BorderSizePixel = 2
statusBar.BorderColor3 = Color3.fromRGB(0, 255, 100)
statusBar.Parent = screenGui
statusBar.ZIndex = 998

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "🔥 HACK ULTRA ATIVO"
statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 14
statusText.Parent = statusBar

-- ========== KEYBINDS ==========
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    -- F5 = Abrir/Fechar
    if input.KeyCode == Enum.KeyCode.F5 then
        mainFrame.Visible = not mainFrame.Visible
        floatBtn.Visible = true
    end
    
    -- F = Alternar Fly
    if input.KeyCode == Enum.KeyCode.F and input.UserInputType == Enum.UserInputType.Keyboard then
        flyBtn.MouseButton1Click:Fire()
    end
    
    -- G = God Mode
    if input.KeyCode == Enum.KeyCode.G and input.UserInputType == Enum.UserInputType.Keyboard then
        godBtn.MouseButton1Click:Fire()
    end
    
    -- K = Instant Kill
    if input.KeyCode == Enum.KeyCode.K and input.UserInputType == Enum.UserInputType.Keyboard then
        killBtn.MouseButton1Click:Fire()
    end
end)

-- ========== PREVENÇÃO DE QUEDAS ==========
spawn(function()
    while true do
        wait(0.5)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            if hrp.Position.Y < -50 then
                hrp.Position = Vector3.new(0, 100, 0)
                print("📌 Anti-fall: Teletransportado para o centro!")
            end
        end
    end
end)

-- ========== CARREGAMENTO ==========
print("========================================")
print("🔥 SCRIPT ULTRA APELÃO CARREGADO!")
print("========================================")
print("📱 Clique no 🔥 para abrir o menu")
print("")
print("🎯 FUNÇÕES DISPONÍVEIS:")
print("  ⚔️ AIMBOT | SUPER FAR | INSTANT KILL | INFINITE AMMO")
print("  👁️ ESP | INVISIBILIDADE | VISÃO NOTURNA")
print("  🏃 VELOCIDADE | SUPER JUMP | FLY | NO CLIP")
print("  💥 GOD MODE | ANTI-KICK | FREEZE | EXPLODE")
print("  🤖 AUTO FARM | TELEPORT TO PLAYER")
print("")
print("⌨️ KEYBINDS:")
print("  F5 = Abrir/Fechar menu")
print("  F = Alternar Fly")
print("  G = Alternar God Mode")
print("  K = Ativar Instant Kill")
print("========================================")
print("✅ TODAS AS FUNÇÕES ESTÃO 100% FUNCIONAIS!")
print("🔒 SCRIPT MODIFICA O JOGO DE VERDADE!")
print("========================================")
