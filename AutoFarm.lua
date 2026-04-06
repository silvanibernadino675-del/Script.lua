-- AUTO CLICK M1 - POR POSIÇÃO (Funciona em qualquer jogo)
-- Clica automaticamente na área do botão M1

local ativado = false
local minimizado = false

-- GUI
local tela = Instance.new("ScreenGui")
tela.Name = "AutoClickM1"
tela.Parent = game.CoreGui
tela.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = tela
frame.Size = UDim2.new(0, 160, 0, 100)
frame.Position = UDim2.new(0.5, -80, 0.75, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner")
corner.Parent = frame
corner.CornerRadius = UDim.new(0, 10)

-- Botão liga/desliga
local botao = Instance.new("TextButton")
botao.Parent = frame
botao.Size = UDim2.new(0, 100, 0, 45)
botao.Position = UDim2.new(0.5, -50, 0.35, -22)
botao.Text = "🔴 OFF"
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.TextSize = 14
botao.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
botao.BorderSizePixel = 0

local botaoCorner = Instance.new("UICorner")
botaoCorner.Parent = botao
botaoCorner.CornerRadius = UDim.new(0, 8)

-- Botão minimizar
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

-- Status
local status = Instance.new("TextLabel")
status.Parent = frame
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0.7, 0)
status.Text = "📍 Modo: Posição"
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.TextSize = 11
status.BackgroundTransparency = 1

-- FUNÇÃO PARA CLICAR NA POSIÇÃO DO M1
local function clicarM1()
    -- Pega o tamanho da tela
    local viewport = game:GetService("Workspace").CurrentCamera.ViewportSize
    local telaLargura = viewport.X
    local telaAltura = viewport.Y
    
    -- Posição do botão M1 (canto inferior direito)
    -- Ajuste esses valores se necessário!
    local posX = telaLargura * 0.85  -- 85% da largura (lado direito)
    local posY = telaAltura * 0.92   -- 92% da altura (quase embaixo)
    
    -- Simula o toque na tela
    local inputService = game:GetService("UserInputService")
    inputService:TouchTap(UDim2.new(0, posX, 0, posY))
    
    return true
end

-- FUNÇÃO PARA AJUSTAR POSIÇÃO (você pode testar valores diferentes)
local function ajustarPosicao(percentX, percentY)
    local viewport = game:GetService("Workspace").CurrentCamera.ViewportSize
    local posX = viewport.X * percentX
    local posY = viewport.Y * percentY
    local inputService = game:GetService("UserInputService")
    inputService:TouchTap(UDim2.new(0, posX, 0, posY))
    status.Text = "🎯 Teste: " .. math.floor(percentX*100) .. "% , " .. math.floor(percentY*100) .. "%"
    task.wait(0.5)
end

-- LOOP PRINCIPAL
local function loopAtaque()
    local contador = 0
    while ativado do
        clicarM1()
        contador = contador + 1
        status.Text = "⚔️ Atacando... (" .. contador .. ")"
        task.wait(0.2)  -- 5 ataques por segundo
    end
end

-- BOTÃO LIGAR/DESLIGAR
botao.MouseButton1Click:Connect(function()
    ativado = not ativado
    if ativado then
        botao.Text = "🟢 ON"
        botao.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        status.Text = "⚔️ Atacando na posição do M1..."
        task.spawn(loopAtaque)
    else
        botao.Text = "🔴 OFF"
        botao.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        status.Text = "⏹️ Desligado"
    end
end)

-- MINIMIZAR
btnMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        frame.Size = UDim2.new(0, 40, 0, 40)
        botao.Visible = false
        status.Visible = false
        btnMinimizar.Text = "□"
        btnMinimizar.Position = UDim2.new(0.5, -12, 0.5, -12)
    else
        frame.Size = UDim2.new(0, 160, 0, 100)
        botao.Visible = true
        status.Visible = true
        btnMinimizar.Text = "✖"
        btnMinimizar.Position = UDim2.new(1, -30, 0, 5)
    end
end)

print("✅ Auto Click M1 carregado! Clicando na posição do botão M1")
