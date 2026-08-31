-- ============================================
-- 💎 PAINEL - 10% PRETO | CONTRASTE 40% 💎
-- VERSÃO OTIMIZADA - COM VALIDAÇÕES E SEGURANÇA
-- ============================================

-- ============================================
-- [1] CARREGAMENTO SEGURO DE DEPENDÊNCIAS
-- ============================================
local dependencies = {
    "Players",
    "RunService",
    "UserInputService",
    "CoreGui",
    "Workspace",
    "TweenService",
    "Lighting",
}

local success, err = pcall(function()
    for _, dep in pairs(dependencies) do
        if not game:GetService(dep) then
            error("Serviço não encontrado: " .. dep)
        end
    end
end)

if not success then
    print("❌ ERRO AO CARREGAR DEPENDÊNCIAS: " .. tostring(err))
    return
end

-- ============================================
-- [2] DECLARAÇÃO DAS VARIÁVEIS GLOBAIS
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- ============================================
-- [3] VARIÁVEIS INICIALIZADAS
-- ============================================
-- Variáveis das funções
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

-- Variáveis de configuração
local currentSpeed = 70
local flySpeed = 60
local flyConnection = nil
local noClipConnection = nil
local antiKickConnection = nil
local menuOpen = false

-- Variáveis de estado
local CONFIG = {
    AimbotRange = 200,
}

-- Variáveis para loops seguros
local loopCount = 0
local MAX_LOOP_ITERATIONS = 1000

-- ============================================
-- [4] CORES DO PAINEL
-- ============================================
local COLORS = {
    Background = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.90,
    Card = Color3.fromRGB(20, 20, 20),
    CardTransparency = 0.80,
    Border = Color3.fromRGB(255, 255, 255),
    BorderTransparency = 0.60,
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(220, 220, 220),
    Combat = Color3.fromRGB(255, 60, 60),
    Weapon = Color3.fromRGB(255, 150, 0),
    Visual = Color3.fromRGB(0, 200, 255),
    Movement = Color3.fromRGB(0, 255, 100),
    Power = Color3.fromRGB(255, 210, 0),
    Success = Color3.fromRGB(0, 255, 100),
    Danger = Color3.fromRGB(255, 60, 60),
}

-- ============================================
-- [5] FUNÇÃO DE LOG
-- ============================================
local function logMessage(level, message)
    local timestamp = os.date("%H:%M:%S")
    local prefix = "[" .. timestamp .. "] "
    
    if level == "INFO" then
        print(prefix .. "ℹ️ " .. message)
    elseif level == "SUCCESS" then
        print(prefix .. "✅ " .. message)
    elseif level == "WARNING" then
        print(prefix .. "⚠️ " .. message)
    elseif level == "ERROR" then
        print(prefix .. "❌ " .. message)
    else
        print(prefix .. message)
    end
end

-- ============================================
-- [6] VALIDAÇÃO DE ENTRADAS
-- ============================================
local function validarJogador(player)
    if not player then
        logMessage("WARNING", "Jogador é nil")
        return false
    end
    
    if not player:IsA("Player") then
        logMessage("WARNING", "Objeto não é um Player válido")
        return false
    end
    
    if not player.Character then
        logMessage("WARNING", "Jogador não tem personagem: " .. player.Name)
        return false
    end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid then
        logMessage("WARNING", "Jogador não tem Humanoid: " .. player.Name)
        return false
    end
    
    if humanoid.Health <= 0 then
        logMessage("WARNING", "Jogador está morto: " .. player.Name)
        return false
    end
    
    return true
end

local function validarNumero(valor, min, max, nome)
    if type(valor) ~= "number" then
        logMessage("WARNING", nome .. " não é um número: " .. tostring(valor))
        return false
    end
    
    if valor < min or valor > max then
        logMessage("WARNING", nome .. " fora do intervalo [" .. min .. ", " .. max .. "]: " .. tostring(valor))
        return false
    end
    
    return true
end

-- ============================================
-- [7] FUNÇÕES PRINCIPAIS (COM PCALL)
-- ============================================

-- ========== AIMBOT ==========
local function executarAimbot()
    local success, err = pcall(function()
        if not aimbotActive then return end
        
        local char = LocalPlayer.Character
        if not char then
            logMessage("WARNING", "Personagem local não encontrado")
            return
        end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            logMessage("WARNING", "HumanoidRootPart não encontrado")
            return
        end
        
        local closest = nil
        local closestDist = superFarActive and math.huge or CONFIG.AimbotRange
        local players = Players:GetPlayers()
        
        for _, player in pairs(players) do
            if player ~= LocalPlayer then
                if validarJogador(player) then
                    local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if targetHrp then
                        local dist = (targetHrp.Position - hrp.Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closest = player.Character
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
                    if mouse then
                        mouse.Target = head
                    end
                else
                    hrp.CFrame = CFrame.new(hrp.Position, head.Position)
                end
                
                if instantKillActive then
                    local humanoid = closest:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                        logMessage("SUCCESS", "Instant Kill aplicado!")
                    end
                end
            end
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro no Aimbot: " .. tostring(err))
    end
end

-- ========== WALLBANG ==========
local function toggleWallbang(active)
    local success, err = pcall(function()
        wallbangActive = active
        
        if active then
            local count = 0
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") or obj:IsA("BasePart") then
                    pcall(function()
                        obj.CanQuery = false
                        obj.CanTouch = false
                    end)
                end
                count = count + 1
                if count > MAX_LOOP_ITERATIONS then
                    logMessage("WARNING", "Loop de Wallbang atingiu limite máximo")
                    break
                end
            end
            logMessage("SUCCESS", "🧱 WALLBANG ATIVADO!")
        else
            local count = 0
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") or obj:IsA("BasePart") then
                    pcall(function()
                        obj.CanQuery = true
                        obj.CanTouch = true
                    end)
                end
                count = count + 1
                if count > MAX_LOOP_ITERATIONS then
                    logMessage("WARNING", "Loop de Wallbang atingiu limite máximo")
                    break
                end
            end
            logMessage("SUCCESS", "🧱 WALLBANG DESATIVADO!")
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro no Wallbang: " .. tostring(err))
    end
end

-- ========== ESP BOX ==========
local function toggleESP(active)
    local success, err = pcall(function()
        espActive = active
        
        if active then
            local function addESP(player)
                if not player or player == LocalPlayer then return end
                if not validarJogador(player) then return end
                
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
            
            Players.PlayerAdded:Connect(addESP)
            Players.PlayerRemoving:Connect(removeESP)
            
            for _, player in pairs(Players:GetPlayers()) do
                player.CharacterAdded:Connect(function()
                    removeESP(player)
                    addESP(player)
                end)
            end
            
            logMessage("SUCCESS", "📦 ESP BOX ATIVADO!")
        else
            for _, highlight in pairs(espHighlights) do
                pcall(function()
                    highlight:Destroy()
                end)
            end
            espHighlights = {}
            logMessage("SUCCESS", "📦 ESP BOX DESATIVADO!")
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro no ESP: " .. tostring(err))
    end
end

-- ========== MUNIÇÃO INFINITA ==========
local function toggleInfiniteAmmo(active)
    local success, err = pcall(function()
        infiniteAmmoActive = active
        
        if active then
            logMessage("SUCCESS", "🔫 MUNIÇÃO INFINITA ATIVADA!")
            
            RunService.Heartbeat:Connect(function()
                if not infiniteAmmoActive then return end
                
                local backpack = LocalPlayer.Backpack
                if not backpack then return end
                
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, child in pairs(tool:GetDescendants()) do
                            if child:IsA("NumberValue") and string.find(string.lower(child.Name or ""), "ammo") then
                                child.Value = 999
                            end
                            if child:IsA("IntValue") and string.find(string.lower(child.Name or ""), "ammo") then
                                child.Value = 999
                            end
                        end
                    end
                end
            end)
        else
            logMessage("SUCCESS", "🔫 MUNIÇÃO INFINITA DESATIVADA!")
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro na Munição Infinita: " .. tostring(err))
    end
end

-- ========== GOD MODE ==========
local function toggleGodMode(active)
    local success, err = pcall(function()
        godModeActive = active
        local char = LocalPlayer.Character
        
        if not char then
            logMessage("WARNING", "Personagem não encontrado para God Mode")
            return
        end
        
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then
            logMessage("WARNING", "Humanoid não encontrado para God Mode")
            return
        end
        
        if active then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            humanoid.BreakJointsOnDeath = false
            logMessage("SUCCESS", "🛡️ GOD MODE ATIVADO!")
        else
            humanoid.MaxHealth = 100
            humanoid.Health = 100
            humanoid.BreakJointsOnDeath = true
            logMessage("SUCCESS", "🛡️ GOD MODE DESATIVADO!")
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro no God Mode: " .. tostring(err))
    end
end

-- ========== ANTI-KICK ==========
local function toggleAntiKick(active)
    local success, err = pcall(function()
        antiKickActive = active
        
        if active then
            logMessage("SUCCESS", "🛡️ ANTI-KICK ATIVADO!")
            
            LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
                if antiKickActive and LocalPlayer.Parent == nil then
                    wait(0.1)
                    LocalPlayer.Parent = Players
                    logMessage("SUCCESS", "🛡️ ANTI-KICK: Reconectado!")
                end
            end)
            
            antiKickConnection = RunService.Heartbeat:Connect(function()
                if antiKickActive then
                    for _, gui in pairs(CoreGui:GetChildren()) do
                        if gui:IsA("ScreenGui") then
                            local nome = string.lower(gui.Name or "")
                            if string.find(nome, "kick") or string.find(nome, "ban") then
                                gui:Destroy()
                                logMessage("SUCCESS", "🛡️ ANTI-KICK: Gui removida!")
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
            logMessage("SUCCESS", "🛡️ ANTI-KICK DESATIVADO!")
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro no Anti-Kick: " .. tostring(err))
    end
end

-- ========== FLY ==========
local function toggleFly(active)
    local success, err = pcall(function()
        flyActive = active
        local char = LocalPlayer.Character
        
        if not char then
            logMessage("WARNING", "Personagem não encontrado para Fly")
            return
        end
        
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then
            logMessage("WARNING", "Humanoid não encontrado para Fly")
            return
        end
        
        if active then
            humanoid.PlatformStand = true
            logMessage("SUCCESS", "🌊 FLY ATIVADO!")
            
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyActive then return end
                
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                local moveDirection = Vector3.new()
                local camera = Workspace.CurrentCamera
                if not camera then return end
                
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
            logMessage("SUCCESS", "🌊 FLY DESATIVADO!")
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro no Fly: " .. tostring(err))
    end
end

-- ========== NO CLIP ==========
local function toggleNoClip(active)
    local success, err = pcall(function()
        noClipActive = active
        
        if active then
            logMessage("SUCCESS", "🧱 NO CLIP ATIVADO!")
            
            noClipConnection = RunService.Heartbeat:Connect(function()
                if not noClipActive then return end
                
                local char = LocalPlayer.Character
                if not char then return end
                
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
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
            logMessage("SUCCESS", "🧱 NO CLIP DESATIVADO!")
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro no No Clip: " .. tostring(err))
    end
end

-- ========== TOGGLE MENU ==========
function toggleMenu()
    local success, err = pcall(function()
        menuOpen = not menuOpen
        mainFrame.Visible = menuOpen
        floatBtn.Visible = not menuOpen
        
        if menuOpen then
            mainFrame.Size = UDim2.new(0, 420, 0, 0)
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                Size = UDim2.new(0, 420, 0, 620)
            }):Play()
            logMessage("INFO", "Menu aberto")
        else
            logMessage("INFO", "Menu fechado")
        end
    end)
    
    if not success then
        logMessage("ERROR", "Erro ao alternar menu: " .. tostring(err))
    end
end

-- ============================================
-- [8] CRIAÇÃO DA GUI (COM PCALL)
-- ============================================
local screenGui = nil
local mainFrame = nil
local floatBtn = nil
local scrollFrame = nil
local statusBar = nil
local statusText = nil

local success, err = pcall(function()
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PremiumHack"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false
    logMessage("SUCCESS", "GUI criada com sucesso!")
end)

if not success then
    logMessage("ERROR", "Erro ao criar GUI: " .. tostring(err))
    return
end

-- ========== BOTÃO FLUTUANTE ==========
success, err = pcall(function()
    floatBtn = Instance.new("TextButton")
    floatBtn.Size = UDim2.new(0, 70, 0, 70)
    floatBtn.Position = UDim2.new(0.83, 0, 0.02, 0)
    floatBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    floatBtn.BackgroundTransparency = 0.1
    floatBtn.Text = "⚡"
    floatBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    floatBtn.Font = Enum.Font.GothamBold
    floatBtn.TextSize = 34
    floatBtn.BorderSizePixel = 2
    floatBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    floatBtn.Parent = screenGui
    floatBtn.ZIndex = 999
    
    local floatCorner = Instance.new("UICorner")
    floatCorner.CornerRadius = UDim.new(1, 0)
    floatCorner.Parent = floatBtn
    logMessage("SUCCESS", "Botão flutuante criado!")
end)

if not success then
    logMessage("ERROR", "Erro ao criar botão flutuante: " .. tostring(err))
    return
end

-- ========== MENU PRINCIPAL ==========
success, err = pcall(function()
    mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 420, 0, 620)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -310)
    mainFrame.BackgroundColor3 = COLORS.Background
    mainFrame.BackgroundTransparency = COLORS.BackgroundTransparency
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = COLORS.Border
    mainFrame.BorderTransparency = COLORS.BorderTransparency
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    mainFrame.Visible = false
    mainFrame.ZIndex = 100
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 20)
    mainCorner.Parent = mainFrame
    
    logMessage("SUCCESS", "Menu principal criado!")
end)

if not success then
    logMessage("ERROR", "Erro ao criar menu principal: " .. tostring(err))
    return
end

-- ========== HEADER ==========
success, err = pcall(function()
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 75)
    header.BackgroundColor3 = COLORS.Background
    header.BackgroundTransparency = COLORS.BackgroundTransparency
    header.BorderSizePixel = 2
    header.BorderColor3 = COLORS.Border
    header.BorderTransparency = COLORS.BorderTransparency
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 20)
    headerCorner.Parent = header
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.6, 0, 0.55, 0)
    title.Position = UDim2.new(0.12, 0, 0.1, 0)
    title.BackgroundTransparency = 1
    title.Text = "⚡ PREMIUM ULTRA"
    title.TextColor3 = COLORS.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    local subTitle = Instance.new("TextLabel")
    subTitle.Size = UDim2.new(0.6, 0, 0.35, 0)
    subTitle.Position = UDim2.new(0.12, 0, 0.6, 0)
    subTitle.BackgroundTransparency = 1
    subTitle.Text = "19 FUNÇÕES PODEROSAS"
    subTitle.TextColor3 = COLORS.TextSecondary
    subTitle.Font = Enum.Font.GothamBold
    subTitle.TextSize = 14
    subTitle.TextXAlignment = Enum.TextXAlignment.Left
    subTitle.Parent = header
    
    local version = Instance.new("TextLabel")
    version.Size = UDim2.new(0.15, 0, 0.35, 0)
    version.Position = UDim2.new(0.82, 0, 0.6, 0)
    version.BackgroundTransparency = 1
    version.Text = "v5.0"
    version.TextColor3 = COLORS.TextSecondary
    version.Font = Enum.Font.GothamBold
    version.TextSize = 13
    version.TextXAlignment = Enum.TextXAlignment.Right
    version.Parent = header
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 42, 0, 42)
    closeBtn.Position = UDim2.new(1, -52, 0, 16)
    closeBtn.BackgroundColor3 = COLORS.Danger
    closeBtn.BackgroundTransparency = 0.7
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = COLORS.Text
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.BorderSizePixel = 2
    closeBtn.BorderColor3 = COLORS.Border
    closeBtn.BorderTransparency = COLORS.BorderTransparency
    closeBtn.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(toggleMenu)
    logMessage("SUCCESS", "Header criado!")
end)

if not success then
    logMessage("ERROR", "Erro ao criar header: " .. tostring(err))
    return
end

-- ========== SCROLL ==========
success, err = pcall(function()
    scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, 0, 1, -75)
    scrollFrame.Position = UDim2.new(0, 0, 0, 75)
    scrollFrame.BackgroundColor3 = COLORS.Background
    scrollFrame.BackgroundTransparency = COLORS.BackgroundTransparency
    scrollFrame.BorderSizePixel = 0
    scrollFrame.Parent = mainFrame
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 2100)
    scrollFrame.ScrollBarThickness = 5
    scrollFrame.ScrollBarImageColor3 = COLORS.Border
    scrollFrame.ScrollBarImageTransparency = 0.6
    logMessage("SUCCESS", "Scroll criado!")
end)

if not success then
    logMessage("ERROR", "Erro ao criar scroll: " .. tostring(err))
    return
end

-- ============================================
-- [9] FUNÇÕES DE CRIAÇÃO
-- ============================================

local function createCategory(parent, text, yPos, icon, color)
    if not parent then
        logMessage("ERROR", "Parent é nil em createCategory")
        return nil
    end
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 42)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = color or COLORS.Text
    frame.BackgroundTransparency = 0.8
    frame.BorderSizePixel = 2
    frame.BorderColor3 = COLORS.Border
    frame.BorderTransparency = COLORS.BorderTransparency
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Position = UDim2.new(0.04, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = icon .. "  " .. text
    label.TextColor3 = COLORS.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    return frame
end

local function createPremiumToggle(parent, text, yPos, color, icon, callback)
    if not parent then
        logMessage("ERROR", "Parent é nil em createPremiumToggle")
        return nil
    end
    
    if not callback then
        logMessage("ERROR", "Callback é nil em createPremiumToggle")
        return nil
    end
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 55)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = COLORS.Card
    frame.BackgroundTransparency = COLORS.CardTransparency
    frame.BorderSizePixel = 2
    frame.BorderColor3 = COLORS.Border
    frame.BorderTransparency = COLORS.BorderTransparency
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 45, 1, 0)
    iconLabel.Position = UDim2.new(0.02, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "◆"
    iconLabel.TextColor3 = COLORS.Text
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 24
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, 0, 1, 0)
    btn.Position = UDim2.new(0.12, 0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = text
    btn.TextColor3 = COLORS.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 17
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.Parent = frame
    
    local status = Instance.new("Frame")
    status.Size = UDim2.new(0, 55, 0, 30)
    status.Position = UDim2.new(0.87, 0, 0.22, 0)
    status.BackgroundColor3 = COLORS.Danger
    status.BackgroundTransparency = 0.6
    status.BorderSizePixel = 2
    status.BorderColor3 = COLORS.Border
    status.BorderTransparency = COLORS.BorderTransparency
    status.Parent = frame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = status
    
    local statusGlow = Instance.new("Frame")
    statusGlow.Size = UDim2.new(1, 0, 1, 0)
    statusGlow.BackgroundColor3 = COLORS.Danger
    statusGlow.BackgroundTransparency = 0.7
    statusGlow.BorderSizePixel = 0
    statusGlow.Parent = status
    
    local glowCorner2 = Instance.new("UICorner")
    glowCorner2.CornerRadius = UDim.new(1, 0)
    glowCorner2.Parent = statusGlow
    
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "OFF"
    statusText.TextColor3 = COLORS.Text
    statusText.Font = Enum.Font.GothamBold
    statusText.TextSize = 13
    statusText.Parent = status
    
    local active = false
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        pcall(function()
            callback(active)
        end)
        
        if active then
            status.BackgroundColor3 = COLORS.Success
            statusGlow.BackgroundColor3 = COLORS.Success
            statusText.Text = "ON"
            frame.BorderColor3 = COLORS.Success
            logMessage("INFO", "✅ " .. text .. " ATIVADO")
        else
            status.BackgroundColor3 = COLORS.Danger
            statusGlow.BackgroundColor3 = COLORS.Danger
            statusText.Text = "OFF"
            frame.BorderColor3 = COLORS.Border
            logMessage("INFO", "❌ " .. text .. " DESATIVADO")
        end
    end)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.15), {BackgroundTransparency = 0.7}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        if not active then
            TweenService:Create(frame, TweenInfo.new(0.15), {BackgroundTransparency = COLORS.CardTransparency}):Play()
        end
    end)
    
    return btn, frame, status
end

local function createPremiumSlider(parent, text, yPos, icon, minVal, maxVal, defaultVal, callback)
    if not parent then
        logMessage("ERROR", "Parent é nil em createPremiumSlider")
        return nil
    end
    
    if not callback then
        logMessage("ERROR", "Callback é nil em createPremiumSlider")
        return nil
    end
    
    if not validarNumero(minVal, -99999, 99999, "minVal") then return nil end
    if not validarNumero(maxVal, -99999, 99999, "maxVal") then return nil end
    if not validarNumero(defaultVal, minVal, maxVal, "defaultVal") then return nil end
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 55)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = COLORS.Card
    frame.BackgroundTransparency = COLORS.CardTransparency
    frame.BorderSizePixel = 2
    frame.BorderColor3 = COLORS.Border
    frame.BorderTransparency = COLORS.BorderTransparency
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = frame
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 40, 1, 0)
    iconLabel.Position = UDim2.new(0.02, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "◆"
    iconLabel.TextColor3 = COLORS.Text
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 22
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.35, 0, 1, 0)
    label.Position = UDim2.new(0.12, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.12, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.50, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = COLORS.Text
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 19
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.Parent = frame
    
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0, 35, 0, 35)
    minusBtn.Position = UDim2.new(0.72, 0, 0.18, 0)
    minusBtn.BackgroundColor3 = COLORS.Danger
    minusBtn.BackgroundTransparency = 0.6
    minusBtn.Text = "−"
    minusBtn.TextColor3 = COLORS.Text
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.TextSize = 20
    minusBtn.BorderSizePixel = 2
    minusBtn.BorderColor3 = COLORS.Border
    minusBtn.BorderTransparency = COLORS.BorderTransparency
    minusBtn.Parent = frame
    
    local minusCorner = Instance.new("UICorner")
    minusCorner.CornerRadius = UDim.new(1, 0)
    minusCorner.Parent = minusBtn
    
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0, 35, 0, 35)
    plusBtn.Position = UDim2.new(0.85, 0, 0.18, 0)
    plusBtn.BackgroundColor3 = COLORS.Success
    plusBtn.BackgroundTransparency = 0.6
    plusBtn.Text = "+"
    plusBtn.TextColor3 = COLORS.Text
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.TextSize = 20
    plusBtn.BorderSizePixel = 2
    plusBtn.BorderColor3 = COLORS.Border
    plusBtn.BorderTransparency = COLORS.BorderTransparency
    plusBtn.Parent = frame
    
    local plusCorner = Instance.new("UICorner")
    plusCorner.CornerRadius = UDim.new(1, 0)
    plusCorner.Parent = plusBtn
    
    local currentVal = defaultVal
    
    minusBtn.MouseButton1Click:Connect(function()
        currentVal = math.max(minVal, currentVal - 10)
        valueLabel.Text = tostring(currentVal)
        pcall(function()
            callback(currentVal)
        end)
        logMessage("INFO", text .. " ajustado para: " .. currentVal)
    end)
    
    plusBtn.MouseButton1Click:Connect(function()
        currentVal = math.min(maxVal, currentVal + 10)
        valueLabel.Text = tostring(currentVal)
        pcall(function()
            callback(currentVal)
        end)
        logMessage("INFO", text .. " ajustado para: " .. currentVal)
    end)
    
    return frame
end

-- ============================================
-- [10] CONSTRUÇÃO DO PAINEL
-- ============================================

local yPos = 0.01

success, err = pcall(function()
    -- COMBATE (4)
    createCategory(scrollFrame, "COMBATE (4)", yPos, "⚔️", COLORS.Combat)
    yPos = yPos + 0.065
    
    createPremiumToggle(scrollFrame, "AIMBOT 100%", yPos, COLORS.Combat, "🎯", function(active)
        aimbotActive = active
        if active then
            aimbotConnection = RunService.Heartbeat:Connect(executarAimbot)
        else
            if aimbotConnection then
                aimbotConnection:Disconnect()
                aimbotConnection = nil
            end
        end
    end)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "SUPER FAR", yPos, COLORS.Combat, "🔭", function(active)
        superFarActive = active
    end)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "SILENT AIM", yPos, COLORS.Combat, "🔇", function(active)
        silentAimActive = active
    end)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "INSTANT KILL", yPos, COLORS.Combat, "💀", function(active)
        instantKillActive = active
    end)
    yPos = yPos + 0.09
    
    -- ARMAS (4)
    createCategory(scrollFrame, "ARMAS (4)", yPos, "🔫", COLORS.Weapon)
    yPos = yPos + 0.065
    
    createPremiumToggle(scrollFrame, "WALLBANG", yPos, COLORS.Weapon, "🧱", toggleWallbang)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "NO RECOIL", yPos, COLORS.Weapon, "🔫", function(active)
        noRecoilActive = active
    end)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "NO SPREAD", yPos, COLORS.Weapon, "🎯", function(active)
        noSpreadActive = active
    end)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "MUNIÇÃO INFINITA", yPos, COLORS.Weapon, "🔫", toggleInfiniteAmmo)
    yPos = yPos + 0.09
    
    -- VISUAIS (3)
    createCategory(scrollFrame, "VISUAIS (3)", yPos, "👁️", COLORS.Visual)
    yPos = yPos + 0.065
    
    createPremiumToggle(scrollFrame, "ESP BOX", yPos, COLORS.Visual, "📦", toggleESP)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "INVISIBILIDADE", yPos, COLORS.Visual, "👻", function(active)
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
    
    createPremiumToggle(scrollFrame, "VISÃO NOTURNA", yPos, COLORS.Visual, "🌙", function(active)
        if active then
            Lighting.Ambient = Color3.fromRGB(100, 100, 150)
            Lighting.Brightness = 2
        else
            Lighting.Ambient = Color3.fromRGB(0, 0, 0)
            Lighting.Brightness = 1
        end
    end)
    yPos = yPos + 0.09
    
    -- MOVIMENTO (4)
    createCategory(scrollFrame, "MOVIMENTO (4)", yPos, "🏃", COLORS.Movement)
    yPos = yPos + 0.065
    
    createPremiumToggle(scrollFrame, "VELOCIDADE", yPos, COLORS.Movement, "💨", function(active)
        speedActive = active
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = active and currentSpeed or originalSpeed
        end
    end)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "SUPER JUMP", yPos, COLORS.Movement, "⚡", function(active)
        jumpActive = active
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = active and 200 or 50
        end
    end)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "FLY", yPos, COLORS.Movement, "🌊", toggleFly)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "NO CLIP", yPos, COLORS.Movement, "🧱", toggleNoClip)
    yPos = yPos + 0.09
    
    -- PODERES (4)
    createCategory(scrollFrame, "PODERES (4)", yPos, "💥", COLORS.Power)
    yPos = yPos + 0.065
    
    createPremiumToggle(scrollFrame, "GOD MODE", yPos, COLORS.Power, "🛡️", toggleGodMode)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "ANTI-KICK", yPos, COLORS.Power, "🛡️", toggleAntiKick)
    yPos = yPos + 0.08
    
    createPremiumToggle(scrollFrame, "FREEZE PLAYERS", yPos, COLORS.Power, "🌀", function(active)
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
    
    createPremiumToggle(scrollFrame, "EXPLODE PLAYERS", yPos, COLORS.Power, "💣", function(active)
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
    
    -- SLIDERS
    createPremiumSlider(scrollFrame, "VELOCIDADE", yPos, "⚡", 50, 500, 70, function(val)
        currentSpeed = val
        if speedActive then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = val
            end
        end
    end)
    yPos = yPos + 0.08
    
    createPremiumSlider(scrollFrame, "FLY SPEED", yPos, "🚀", 30, 300, 60, function(val)
        flySpeed = val
    end)
    yPos = yPos + 0.08
    
    createPremiumSlider(scrollFrame, "AIMBOT RANGE", yPos, "📏", 50, 500, 200, function(val)
        CONFIG.AimbotRange = val
    end)
    yPos = yPos + 0.08
    
    logMessage("SUCCESS", "Painel construído com sucesso!")
end)

if not success then
    logMessage("ERROR", "Erro ao construir painel: " .. tostring(err))
end

-- ============================================
-- [11] STATUS BAR
-- ============================================
success, err = pcall(function()
    statusBar = Instance.new("Frame")
    statusBar.Size = UDim2.new(0.35, 0, 0, 35)
    statusBar.Position = UDim2.new(0.325, 0, 0.01, 0)
    statusBar.BackgroundColor3 = COLORS.Background
    statusBar.BackgroundTransparency = COLORS.BackgroundTransparency
    statusBar.BorderSizePixel = 2
    statusBar.BorderColor3 = COLORS.Border
    statusBar.BorderTransparency = COLORS.BorderTransparency
    statusBar.Parent = screenGui
    statusBar.ZIndex = 998
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 10)
    statusCorner.Parent = statusBar
    
    statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "◆ SYSTEM READY"
    statusText.TextColor3 = COLORS.Text
    statusText.Font = Enum.Font.GothamBold
    statusText.TextSize = 16
    statusText.Parent = statusBar
    logMessage("SUCCESS", "Status bar criada!")
end)

if not success then
    logMessage("ERROR", "Erro ao criar status bar: " .. tostring(err))
end

-- ============================================
-- [12] KEYBINDS
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
-- [13] ARRASTAR MENU
-- ============================================
local dragging = false
local dragStart, startPos

if mainFrame then
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
end

-- ============================================
-- [14] UPDATE STATUS
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
    
    if statusText then
        if #active > 0 then
            statusText.Text = "◆ " .. table.concat(active, " ")
            statusText.TextColor3 = COLORS.Success
        else
            statusText.Text = "◆ SYSTEM READY"
            statusText.TextColor3 = COLORS.Text
        end
    end
end

RunService.Heartbeat:Connect(function()
    if math.random(1, 30) == 1 then
        pcall(updateStatus)
    end
end)

-- ============================================
-- [15] INSTRUÇÕES FINAIS
-- ============================================
print("========================================")
print("💎 PAINEL 10% PRETO - CONTRASTE 40%!")
print("========================================")
print("🔳 Fundo 10% PRETO (90% transparente)")
print("🔳 Botões 20% PRETO (80% transparente)")
print("🔲 Texto 100% BRANCO")
print("📏 Tamanho GRANDE (16-22px)")
print("🎯 Contraste 40%")
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
logMessage("SUCCESS", "🔥 PAINEL CARREGADO COM SUCESSO!")
