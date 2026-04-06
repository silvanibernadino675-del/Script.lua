-- AUTO ATTACK SIMPLES - Delta Mobile
-- Apenas ataque automático, com GUI arrastável e minimizável

local player = game.Players.LocalPlayer
local ativado = false
local minimizado = false

-- Criar GUI principal
local tela = Instance.new("ScreenGui")
tela.Name = "AutoAttackGUI"
tela.Parent = game.CoreGui
tela.ResetOnSpawn = false

-- Frame principal (arrastável)
local frame = Instance.new("Frame")
frame.Parent = tela
frame.Size = UDim2.new(0, 140, 0, 70)
frame.Position = UDim2.new(0.5, -70, 0.8, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Cantos arredondados (opcional)
local corner = Instance.new("UICorner")
corner.Parent = frame
corner.CornerRadius = UDim.new(0, 10)

-- Botão liga/desliga
local botao = Instance.new("TextButton")
botao.Parent = frame
botao.Size = UDim2.new(0, 80, 0, 40)
botao.Position = UDim2.new(0.5, -40, 0.5, -20)
botao.Text = "🔴 OFF"
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.TextSize = 14
botao.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
botao.BorderSizePixel = 0

local botaoCorner = Instance.new("UICorner")
botaoCorner.Parent = botao
botaoCorner.CornerRadius = UDim.new(0, 8)

-- Botão minimizar (X)
local btnMinimizar = Instance.new("TextButton")
btnMinimizar.Parent = frame
btnMinimizar.Size = UDim2.new(0, 25, 0, 25)
btnMinimizar.Position = UDim2.new(1, -30, 0, 5)
btnMinimizar.Text = "✖"
btnMinimizar.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMinimizar.TextSize = 12
btnMinimizar.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
btnMinimizar.BorderSizePixel = 0

local miniCorner = Instance.new("UICorner")
miniCorner.Parent = btnMinimizar
miniCorner.CornerRadius = UDim.new(0, 5)

-- Label de status
local status = Instance.new("TextLabel")
status.Parent = frame
status.Size = UDim2.new(1, 0, 0, 15)
status.Position = UDim2.new(0, 0, 1, -18)
status.Text = "⚔️ Parado"
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.TextSize = 10
status.BackgroundTransparency = 1

-- FUNÇÃO DE ATAQUE (procura qualquer botão de ataque)
local function atacar()
    for _, botao in ipairs(player.PlayerGui:GetDescendants()) do
        if botao:IsA("TextButton") then
            local texto = (botao.Text or ""):lower()
            local nome = (botao.Name or ""):lower()
            
            -- Palavras que indicam botão de ataque
            if texto:find("m1") or texto:find("ataque") or texto:find("attack") or
               texto:find("soco") or texto:find("hit") or texto:find("fight") or
               nome:find("m1") or nome:find("ataque") or nome:find("attack") then
                botao:Click()
                return true
            end
        end
    end
    return false
end

-- LOOP PRINCIPAL
local function loopAtaque()
    local falhas = 0
    while ativado do
        local atacou = atacar()
        
        if atacou then
            status.Text = "⚔️ Atacando..."
            falhas = 0
        else
            falhas = falhas + 1
            if falhas >= 15 then
                status.Text = "⚠️ Nenhum botão encontrado!"
            else
                status.Text = "🔍 Procurando..."
            end
        end
        
        wait(0.15)  -- 0.15 segundos entre ataques
    end
end

-- BOTÃO LIGA/DESLIGA
botao.MouseButton1Click:Connect(function()
    ativado = not ativado
    if ativado then
        botao.Text = "🟢 ON"
        botao.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        status.Text = "⚔️ Atacando..."
        spawn(loopAtaque)
    else
        botao.Text = "🔴 OFF"
        botao.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        status.Text = "⚔️ Parado"
    end
end)

-- MINIMIZAR (esconde o botão e fica só o X)
local frameOriginalSize = frame.Size
local botaoOriginalVisible = true

btnMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    
    if minimizado then
        -- Modo minimizado: só mostra o X
        frame.Size = UDim2.new(0, 40, 0, 40)
        botao.Visible = false
        status.Visible = false
        btnMinimizar.Text = "□"  -- ícone de expandir
        btnMinimizar.Position = UDim2.new(0.5, -12, 0.5, -12)
        btnMinimizar.Size = UDim2.new(0, 25, 0, 25)
    else
        -- Modo normal
        frame.Size = UDim2.new(0, 140, 0, 70)
        botao.Visible = true
        status.Visible = true
        btnMinimizar.Text = "✖"
        btnMinimizar.Position = UDim2.new(1, -30, 0, 5)
        btnMinimizar.Size = UDim2.new(0, 25, 0, 25)
    end
end)

print("✅ Auto Attack carregado! Arraste o painel para mover.")
