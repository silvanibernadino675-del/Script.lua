-- Script adaptado para Delta Executor no celular
local tela = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local botaoAuto = Instance.new("TextButton")
local statusLabel = Instance.new("TextLabel")
local fecharBtn = Instance.new("TextButton")
local titulo = Instance.new("TextLabel")

tela.Parent = game.CoreGui
tela.Name = "AutoFarmGUI"

-- Frame (sem Draggable no mobile pra evitar bugs)
frame.Parent = tela
frame.Size = UDim2.new(0, 260, 0, 160)
frame.Position = UDim2.new(0.5, -130, 0.7, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.3
-- frame.Active = true  -- comentado
-- frame.Draggable = true  -- desativado no mobile

-- Título
titulo.Parent = frame
titulo.Size = UDim2.new(1, -40, 0, 35)
titulo.Position = UDim2.new(0, 0, 0, 0)
titulo.Text = "⚔️ AUTO FARM ⚔️"
titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
titulo.BackgroundTransparency = 1
titulo.TextSize = 16

-- Botão Fechar (X)
fecharBtn.Parent = frame
fecharBtn.Size = UDim2.new(0, 40, 0, 30)
fecharBtn.Position = UDim2.new(1, -42, 0, 2)
fecharBtn.Text = "❌"
fecharBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
fecharBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fecharBtn.TextSize = 16
fecharBtn.BorderSizePixel = 0

-- Status
statusLabel.Parent = frame
statusLabel.Size = UDim2.new(0, 240, 0, 30)
statusLabel.Position = UDim2.new(0.5, -120, 0, 40)
statusLabel.Text = "📱 Status: Parado"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.BackgroundTransparency = 1
statusLabel.TextSize = 13

-- Botão liga/desliga
botaoAuto.Parent = frame
botaoAuto.Size = UDim2.new(0, 200, 0, 50)
botaoAuto.Position = UDim2.new(0.5, -100, 0, 80)
botaoAuto.Text = "🔴 DESLIGADO"
botaoAuto.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
botaoAuto.TextColor3 = Color3.fromRGB(255, 255, 255)
botaoAuto.TextSize = 15

-- Fechar
fecharBtn.MouseButton1Click:Connect(function()
    tela:Destroy()
    ativado = false
end)

local ativado = false
local player = game.Players.LocalPlayer

-- Função para clicar no M1 (mais simples)
local function atacarM1()
    for _, botao in ipairs(player.PlayerGui:GetDescendants()) do
        if botao:IsA("TextButton") and (botao.Text == "M1" or botao.Name == "M1") then
            botao:Click()
            return true
        end
    end
    return false
end

-- Função para encontrar e clicar no despertar
local function clicarDespertar()
    for _, botao in ipairs(player.PlayerGui:GetDescendants()) do
        if botao:IsA("TextButton") then
            local texto = (botao.Text or ""):lower()
            if texto:find("despertar") or texto:find("awaken") or texto:find("rage") then
                botao:Click()
                return true
            end
        end
    end
    return false
end

-- Função pra achar a barra vermelha
local function valorBarraDespertar()
    for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
        -- Procura por texto com porcentagem ex: "85%"
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            local texto = obj.Text or ""
            local percentual = texto:match("(%d+)%%")
            if percentual then
                return tonumber(percentual)
            end
        end
        -- Procura por barra vermelha (Frame)
        if obj:IsA("Frame") and obj.BackgroundColor3.R > 0.7 then
            -- Tenta pegar o tamanho da barra
            local escala = obj.Size.X.Scale
            if escala > 0 then
                return math.floor(escala * 100)
            end
        end
    end
    return 0
end

-- Loop principal
local function iniciarFarm()
    while ativado do
        -- 1. Atacar M1
        atacarM1()
        
        -- 2. Verificar despertar
        local valor = valorBarraDespertar()
        statusLabel.Text = "📊 Despertar: " .. valor .. "%"
        
        if valor >= 100 then
            statusLabel.Text = "⚡ DESPERTANDO!"
            clicarDespertar()
            task.wait(1)
        end
        
        task.wait(0.2) -- ataque rápido
    end
end

-- Botão liga/desliga
botaoAuto.MouseButton1Click:Connect(function()
    ativado = not ativado
    if ativado then
        botaoAuto.Text = "🟢 LIGADO"
        botaoAuto.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusLabel.Text = "✅ Auto Farm Ligado!"
        task.spawn(iniciarFarm)
    else
        botaoAuto.Text = "🔴 DESLIGADO"
        botaoAuto.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        statusLabel.Text = "⏹️ Desligado"
    end
end)

print("✅ Script Delta Mobile carregado!")
print("📱 Auto M1 + Despertar Automático")
