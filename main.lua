-- ============================================
-- PAINEL PREMIUM ULTRA v6.0 - VISUAL CLARO
-- CORES VIBRANTES | TEXTO GRANDE | FÁCIL DE VER
-- ============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- ========== CRIAR GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenuClaro"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- ========== FUNDO DO PAINEL (CLARO) ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 520)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40) -- Fundo escuro com leve tom azulado
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(100, 150, 255)
mainFrame.Parent = screenGui
mainFrame.ZIndex = 100
mainFrame.ClipsDescendants = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

-- ========== TÍTULO DO PAINEL (BEM CLARO) ==========
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, 55)
titleFrame.BackgroundColor3 = Color3.fromRGB(40, 50, 80)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "🔥 PAINEL ULTIMATE 🔥"
title.TextColor3 = Color3.fromRGB(255, 220, 80) -- Amarelo claro
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextScaled = true
title.Parent = titleFrame

-- Subtítulo
local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, 0, 0, 16)
subTitle.Position = UDim2.new(0, 0, 0.65, 0)
subTitle.BackgroundTransparency = 1
subTitle.Text = "TOQUE NOS BOTÕES PARA ATIVAR"
subTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 12
subTitle.Parent = titleFrame

-- ========== BOTÃO FECHAR ==========
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -48, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50) -- Vermelho claro
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
    screenGui:Destroy()
end)

-- ========== SCROLLVIEW ==========
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -55)
scrollFrame.Position = UDim2.new(0, 0, 0, 55)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = mainFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)

-- ========== FUNÇÃO CRIAR BOTÃO CLARO ==========
local function criarBotaoClaro(parent, texto, cor, yPos, icone)
    local btn = Instance.new("TextButton")
    local stroke = Instance.new("UIStroke")
    local corner = Instance.new("UICorner")
    
    btn.Size = UDim2.new(0.92, 0, 0, 48) -- Botão MAIOR
    btn.Position = UDim2.new(0.04, 0, yPos, 0)
    btn.Text = icone .. " " .. texto .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texto BRANCO
    btn.TextScaled = false
    btn.TextSize = 17 -- Texto MAIOR
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(30, 35, 55) -- Fundo levemente azulado
    btn.BorderSizePixel = 0
    btn.Parent = parent
    btn.ZIndex = 101
    
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    stroke.Thickness = 2
    stroke.Color = cor
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = btn
    
    local ativo = false
    btn.MouseButton1Click:Connect(function()
        ativo = not ativo
        btn.Text = icone .. " " .. texto .. (ativo and " [ON]" or " [OFF]")
        btn.TextColor3 = ativo and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
        stroke.Color = ativo and Color3.fromRGB(0, 255, 100) or cor
        btn.BackgroundColor3 = ativo and Color3.fromRGB(20, 60, 40) or Color3.fromRGB(30, 35, 55)
    end)
    
    return btn
end

-- ========== CATEGORIA: COMBATE ==========
local catLabel1 = Instance.new("TextLabel")
catLabel1.Size = UDim2.new(0.92, 0, 0, 28)
catLabel1.Position = UDim2.new(0.04, 0, 0.01, 0)
catLabel1.BackgroundTransparency = 1
catLabel1.Text = "⚔️ COMBATE"
catLabel1.TextColor3 = Color3.fromRGB(255, 100, 100) -- Vermelho claro
catLabel1.Font = Enum.Font.GothamBold
catLabel1.TextSize = 18
catLabel1.TextXAlignment = Enum.TextXAlignment.Left
catLabel1.Parent = scrollFrame

local btn1 = criarBotaoClaro(scrollFrame, "AIMBOT 100%", Color3.fromRGB(255, 80, 80), 0.07, "🎯")
local btn2 = criarBotaoClaro(scrollFrame, "SUPER FAR", Color3.fromRGB(100, 200, 255), 0.15, "🔭")
local btn3 = criarBotaoClaro(scrollFrame, "SILENT AIM", Color3.fromRGB(200, 100, 255), 0.23, "🔇")
local btn4 = criarBotaoClaro(scrollFrame, "INSTANT KILL", Color3.fromRGB(255, 50, 50), 0.31, "💀")

-- ========== CATEGORIA: VISUAIS ==========
local catLabel2 = Instance.new("TextLabel")
catLabel2.Size = UDim2.new(0.92, 0, 0, 28)
catLabel2.Position = UDim2.new(0.04, 0, 0.39, 0)
catLabel2.BackgroundTransparency = 1
catLabel2.Text = "👁️ VISUAIS"
catLabel2.TextColor3 = Color3.fromRGB(100, 200, 255) -- Azul claro
catLabel2.Font = Enum.Font.GothamBold
catLabel2.TextSize = 18
catLabel2.TextXAlignment = Enum.TextXAlignment.Left
catLabel2.Parent = scrollFrame

local btn5 = criarBotaoClaro(scrollFrame, "ESP BOX", Color3.fromRGB(100, 200, 255), 0.45, "📦")
local btn6 = criarBotaoClaro(scrollFrame, "INVISIBILIDADE", Color3.fromRGB(200, 150, 255), 0.53, "👻")
local btn7 = criarBotaoClaro(scrollFrame, "VISÃO NOTURNA", Color3.fromRGB(100, 150, 255), 0.61, "🌙")

-- ========== CATEGORIA: MOVIMENTO ==========
local catLabel3 = Instance.new("TextLabel")
catLabel3.Size = UDim2.new(0.92, 0, 0, 28)
catLabel3.Position = UDim2.new(0.04, 0, 0.69, 0)
catLabel3.BackgroundTransparency = 1
catLabel3.Text = "🏃 MOVIMENTO"
catLabel3.TextColor3 = Color3.fromRGB(100, 255, 100) -- Verde claro
catLabel3.Font = Enum.Font.GothamBold
catLabel3.TextSize = 18
catLabel3.TextXAlignment = Enum.TextXAlignment.Left
catLabel3.Parent = scrollFrame

local btn8 = criarBotaoClaro(scrollFrame, "VELOCIDADE", Color3.fromRGB(100, 255, 100), 0.75, "💨")
local btn9 = criarBotaoClaro(scrollFrame, "SUPER JUMP", Color3.fromRGB(200, 255, 100), 0.83, "⚡")
local btn10 = criarBotaoClaro(scrollFrame, "FLY (VOAR)", Color3.fromRGB(100, 255, 200), 0.91, "🌊")
local btn11 = criarBotaoClaro(scrollFrame, "NO CLIP", Color3.fromRGB(255, 200, 100), 0.99, "🧱")

-- ========== CATEGORIA: PODERES ==========
local catLabel4 = Instance.new("TextLabel")
catLabel4.Size = UDim2.new(0.92, 0, 0, 28)
catLabel4.Position = UDim2.new(0.04, 0, 1.07, 0)
catLabel4.BackgroundTransparency = 1
catLabel4.Text = "💥 PODERES"
catLabel4.TextColor3 = Color3.fromRGB(255, 255, 100) -- Amarelo claro
catLabel4.Font = Enum.Font.GothamBold
catLabel4.TextSize = 18
catLabel4.TextXAlignment = Enum.TextXAlignment.Left
catLabel4.Parent = scrollFrame

local btn12 = criarBotaoClaro(scrollFrame, "GOD MODE", Color3.fromRGB(255, 200, 100), 1.13, "🛡️")
local btn13 = criarBotaoClaro(scrollFrame, "ANTI-KICK", Color3.fromRGB(255, 150, 100), 1.21, "🛡️")
local btn14 = criarBotaoClaro(scrollFrame, "FREEZE PLAYERS", Color3.fromRGB(100, 200, 255), 1.29, "🌀")
local btn15 = criarBotaoClaro(scrollFrame, "EXPLODE PLAYERS", Color3.fromRGB(255, 100, 50), 1.37, "💣")
local btn16 = criarBotaoClaro(scrollFrame, "TELEPORT TO PLAYER", Color3.fromRGB(150, 150, 255), 1.45, "📌")

-- ========== SLIDER DE VELOCIDADE (BEM VISÍVEL) ==========
local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(0.92, 0, 0, 55)
sliderFrame.Position = UDim2.new(0.04, 0, 1.54, 0)
sliderFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 65)
sliderFrame.BorderSizePixel = 2
sliderFrame.BorderColor3 = Color3.fromRGB(100, 200, 255)
sliderFrame.Parent = scrollFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 10)
sliderCorner.Parent = sliderFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ VELOCIDADE: 70"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 16
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = sliderFrame

local speedSlider = Instance.new("TextButton")
speedSlider.Size = UDim2.new(0.3, 0, 0.8, 0)
speedSlider.Position = UDim2.new(0.65, 0, 0.1, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(60, 80, 140)
speedSlider.Text = "70"
speedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
speedSlider.Font = Enum.Font.GothamBold
speedSlider.TextSize = 20
speedSlider.BorderSizePixel = 2
speedSlider.BorderColor3 = Color3.fromRGB(100, 200, 255)
speedSlider.Parent = sliderFrame

local sliderCorner2 = Instance.new("UICorner")
sliderCorner2.CornerRadius = UDim.new(0, 8)
sliderCorner2.Parent = speedSlider

local currentSpeed = 70
speedSlider.MouseButton1Click:Connect(function()
    local speeds = {50, 70, 90, 120, 150, 200, 300, 500}
    local idx = 0
    for i, v in pairs(speeds) do
        if v == currentSpeed then idx = i break end
    end
    idx = idx % #speeds + 1
    currentSpeed = speeds[idx]
    speedSlider.Text = tostring(currentSpeed)
    speedLabel.Text = "⚡ VELOCIDADE: " .. currentSpeed
end)

-- ========== BOTÃO FLUTUANTE (ABRIR/FECHAR) ==========
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 60, 0, 60)
floatBtn.Position = UDim2.new(0.82, 0, 0.03, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 80)
floatBtn.BackgroundTransparency = 0.1
floatBtn.Text = "🔥"
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 28
floatBtn.BorderSizePixel = 2
floatBtn.BorderColor3 = Color3.fromRGB(255, 200, 80)
floatBtn.Parent = screenGui
floatBtn.ZIndex = 999

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

-- Sombra
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(0, 65, 0, 65)
shadow.Position = UDim2.new(0.815, 0, 0.025, 0)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.5
shadow.BorderSizePixel = 0
shadow.Parent = screenGui
shadow.ZIndex = 998

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(1, 0)
shadowCorner.Parent = shadow

-- ========== ABRIR/FECHAR MENU ==========
local menuAberto = true

floatBtn.MouseButton1Click:Connect(function()
    menuAberto = not menuAberto
    mainFrame.Visible = menuAberto
    floatBtn.Text = menuAberto and "🔥" or "🔒"
end)

-- ========== STATUS BAR (BEM VISÍVEL) ==========
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
statusText.Text = "✅ HACK ATIVO"
statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 14
statusText.Parent = statusBar

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

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ========== MENSAGEM DE CARREGAMENTO ==========
print("========================================")
print("🔥 PAINEL ULTIMATE CLARO CARREGADO!")
print("========================================")
print("📱 Clique no 🔥 para abrir/fechar")
print("👆 Toque nos botões para ativar")
print("⚡ Use o slider para ajustar velocidade")
print("========================================")
