-- AUTO FARM M1 - CELULAR (Delta Mobile)
-- Mostra os botões encontrados direto na tela

local player = game.Players.LocalPlayer
local ativado = false
local minimizado = false
local botaoM1Encontrado = nil

-- Criar GUI principal
local tela = Instance.new("ScreenGui")
tela.Name = "AutoFarmM1"
tela.Parent = game.CoreGui
tela.ResetOnSpawn = false

-- Frame principal
local frame = Instance.new("Frame")
frame.Parent = tela
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.7, 0)
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
botao.Position = UDim2.new(0.5, -50, 0.25, -22)
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
status.Size = UDim2.new(1, 0, 0, 30)
status.Position = UDim2.new(0, 0, 0.45, 0)
status.Text = "🔍 Procurando M1..."
status.TextColor3 = Color3.fromRGB(255, 255, 0)
status.TextSize = 12
status.BackgroundTransparency = 1

-- Label para mostrar resultado do debug
local debugResultado = Instance.new("TextLabel")
debugResultado.Parent = frame
debugResultado.Size = UDim2.new(1, 0, 0, 50)
debugResultado.Position = UDim2.new(0, 0, 0.65, 0)
debugResultado.Text = ""
debugResultado.TextColor3 = Color3.fromRGB(200, 200, 200)
debugResultado.TextSize = 10
debugResultado.BackgroundTransparency = 1
debugResultado.TextWrapped = true

-- Botão debug
local debugBtn = Instance.new("TextButton")
debugBtn.Parent = frame
debugBtn.Size = UDim2.new(0, 100, 0, 25)
debugBtn.Position = UDim2.new(0.5, -50, 0.85, 0)
debugBtn.Text = "🐛 LISTAR BOTÕES"
debugBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
debugBtn.TextSize = 11
debugBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
debugBtn.BorderSizePixel = 0

local debugCorner = Instance.new("UICorner")
debugCorner.Parent = debugBtn
debugCorner.CornerRadius = UDim.new(0, 5)

-- FUNÇÃO PARA ENCONTRAR O BOTÃO M1
local function encontrarBotaoM1()
    local locais = {player.PlayerGui, game.CoreGui}
    
    for _, gui in ipairs(locais) do
        if gui then
            for _, obj in ipairs(gui:GetDescendants()) do
                if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                    local texto = (obj.Text or ""):upper()
                    local nome = (obj.Name or ""):upper()
                    
                    if texto:find("M1") or nome:find("M1") or texto == "M1" or nome == "M1" then
                        return obj
                    end
                end
            end
        end
    end
    return nil
end

-- FUNÇÃO DEBUG QUE MOSTRA NA TELA
local function debugNaTela()
    local botoesEncontrados = {}
    local locais = {player.PlayerGui, game.CoreGui}
    
    for _, gui in ipairs(locais) do
        if gui then
            for _, obj in ipairs(gui:GetDescendants()) do
                if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                    local texto = obj.Text or "SEM TEXTO"
                    if #texto > 15 then texto = texto:sub(1, 12) .. "..." end
                    table.insert(botoesEncontrados, "• " .. obj.Name .. " [" .. texto .. "]")
                end
            end
        end
    end
    
    if #botoesEncontrados == 0 then
        debugResultado.Text = "❌ NENHUM BOTÃO ENCONTRADO!\nO jogo pode usar clique na tela."
    else
        local texto = "🔍 BOTÕES ENCONTRADOS (" .. #botoesEncontrados .. "):\n"
        for i = 1, math.min(4, #botoesEncontrados) do
            texto = texto .. botoesEncontrados[i] .. "\n"
        end
        if #botoesEncontrados > 4 then
            texto = texto .. "... e mais " .. (#botoesEncontrados - 4) .. " botões"
        end
        debugResultado.Text = texto
    end
    
    -- Reseta a mensagem depois de 5 segundos
    task.wait(5)
    if not ativado then
        debugResultado.Text = ""
    end
end

-- FUNÇÃO PARA CLICAR NO M1
local function clicarM1()
    if not botaoM1Encontrado then
        botaoM1Encontrado = encontrarBotaoM1()
        if botaoM1Encontrado then
            status.Text = "✅ M1 encontrado!"
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
            debugResultado.Text = "🎯 Botão M1: " .. botaoM1Encontrado.Name
            task.wait(2)
            debugResultado.Text = ""
        else
            status.Text = "❌ M1 não encontrado!"
            status.TextColor3 = Color3.fromRGB(255, 0, 0)
            return false
        end
    end
    
    local sucesso = pcall(function()
        botaoM1Encontrado:Click()
    end)
    
    return sucesso
end

-- LOOP PRINCIPAL
local function loopAtaque()
    while ativado do
        local atacou = clicarM1()
        
        if atacou then
            status.Text = "⚔️ ATACANDO!"
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
        else
            status.Text = "⚠️ Falhou..."
            status.TextColor3 = Color3.fromRGB(255, 255, 0)
            botaoM1Encontrado = nil
            task.wait(0.5)
        end
        
        task.wait(0.15)
    end
end

-- BOTÃO LIGAR/DESLIGAR
botao.MouseButton1Click:Connect(function()
    ativado = not ativado
    if ativado then
        botao.Text = "🟢 ON"
        botao.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        status.Text = "🔍 Procurando M1..."
        status.TextColor3 = Color3.fromRGB(255, 255, 0)
        botaoM1Encontrado = encontrarBotaoM1()
        if botaoM1Encontrado then
            status.Text = "✅ M1 pronto!"
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
        end
        task.spawn(loopAtaque)
    else
        botao.Text = "🔴 OFF"
        botao.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        status.Text = "⏹️ Desligado"
        status.TextColor3 = Color3.fromRGB(255, 255, 255)
        debugResultado.Text = ""
    end
end)

-- BOTÃO DEBUG
debugBtn.MouseButton1Click:Connect(function()
    debugNaTela()
end)

-- MINIMIZAR
btnMinimizar.MouseButton1Click:Connect(function()
    minimizado = not minimizado
    if minimizado then
        frame.Size = UDim2.new(0, 45, 0, 45)
        botao.Visible = false
        status.Visible = false
        debugBtn.Visible = false
        debugResultado.Visible = false
        btnMinimizar.Text = "□"
        btnMinimizar.Position = UDim2.new(0.5, -12, 0.5, -12)
    else
        frame.Size = UDim2.new(0, 200, 0, 150)
        botao.Visible = true
        status.Visible = true
        debugBtn.Visible = true
        debugResultado.Visible = true
        btnMinimizar.Text = "✖"
        btnMinimizar.Position = UDim2.new(1, -30, 0, 5)
    end
end)

print("✅ Script M1 para CELULAR carregado!")
