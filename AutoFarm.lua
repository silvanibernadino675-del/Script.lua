-- Script adaptado para Delta Executor no celular (VERSÃO CORRIGIDA)
local tela = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local botaoAuto = Instance.new("TextButton")
local statusLabel = Instance.new("TextLabel")
local fecharBtn = Instance.new("TextButton")
local titulo = Instance.new("TextLabel")
local debugBtn = Instance.new("TextButton") -- Botão pra debug

tela.Parent = game.CoreGui
tela.Name = "AutoFarmGUI"

-- Frame
frame.Parent = tela
frame.Size = UDim2.new(0, 280, 0, 200)
frame.Position = UDim2.new(0.5, -140, 0.7, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.3

-- Título
titulo.Parent = frame
titulo.Size = UDim2.new(1, -40, 0, 35)
titulo.Position = UDim2.new(0, 0, 0, 0)
titulo.Text = "⚔️ AUTO FARM V2 ⚔️"
titulo.TextColor3 = Color3.fromRGB(255, 215, 0)
titulo.BackgroundTransparency = 1
titulo.TextSize = 16

-- Botão Fechar
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
statusLabel.Size = UDim2.new(0, 260, 0, 30)
statusLabel.Position = UDim2.new(0.5, -130, 0, 40)
statusLabel.Text = "📱 Status: Parado"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.BackgroundTransparency = 1
statusLabel.TextSize = 12

-- Botão liga/desliga
botaoAuto.Parent = frame
botaoAuto.Size = UDim2.new(0, 200, 0, 45)
botaoAuto.Position = UDim2.new(0.5, -100, 0, 75)
botaoAuto.Text = "🔴 DESLIGADO"
botaoAuto.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
botaoAuto.TextColor3 = Color3.fromRGB(255, 255, 255)
botaoAuto.TextSize = 14

-- Botão Debug (mostra botões encontrados)
debugBtn.Parent = frame
debugBtn.Size = UDim2.new(0, 200, 0, 30)
debugBtn.Position = UDim2.new(0.5, -100, 0, 125)
debugBtn.Text = "🐛 DEBUG (Listar Botões)"
debugBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
debugBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
debugBtn.TextSize = 12

-- Fechar
fecharBtn.MouseButton1Click:Connect(function()
    tela:Destroy()
    ativado = false
end)

local ativado = false
local player = game.Players.LocalPlayer

-- FUNÇÃO DEBUG: Lista todos os botões da tela
debugBtn.MouseButton1Click:Connect(function()
    print("========== BOTÕES ENCONTRADOS ==========")
    local cont = 0
    for _, botao in ipairs(player.PlayerGui:GetDescendants()) do
        if botao:IsA("TextButton") then
            cont = cont + 1
            print(cont .. " - Texto: '" .. botao.Text .. "' | Nome: " .. botao.Name)
        end
    end
    if cont == 0 then
        print("❌ Nenhum botão TextButton encontrado!")
    end
    print("=========================================")
    statusLabel.Text = "🐛 Debug: " .. cont .. " botões listados (ver F9)"
end)

-- FUNÇÃO UNIVERSAL DE ATAQUE
local function atacarM1()
    for _, botao in ipairs(player.PlayerGui:GetDescendants()) do
        if botao:IsA("TextButton") then
            local texto = (botao.Text or ""):lower()
            local nome = (botao.Name or ""):lower()
            
            -- Lista de palavras pra ataque (qualquer jogo)
            if texto:find("m1") or texto:find("ataque") or texto:find("attack") or 
               texto:find("soco") or texto:find("punho") or texto:find("hit") or
               texto:find("bater") or texto:find("fight") or texto:find("lutar") or
               nome:find("m1") or nome:find("ataque") or nome:find("attack") or
               nome:find("soco") or nome:find("hit") then
                botao:Click()
                return true
            end
        end
    end
    return false
end

-- FUNÇÃO UNIVERSAL DE DESPERTAR
local function clicarDespertar()
    for _, botao in ipairs(player.PlayerGui:GetDescendants()) do
        if botao:IsA("TextButton") then
            local texto = (botao.Text or ""):lower()
            local nome = (botao.Name or ""):lower()
            
            -- Lista de palavras pra despertar
            if texto:find("despertar") or texto:find("awaken") or texto:find("rage") or
               texto:find("ult") or texto:find("desbloquear") or texto:find("transform") or
               texto:find("ativar") or texto:find("poder") or texto:find("especial") or
               nome:find("despertar") or nome:find("awaken") or nome:find("rage") then
                botao:Click()
                return true
            end
        end
    end
    return false
end

-- FUNÇÃO DA BARRA DE DESPERTAR
local function valorBarraDespertar()
    -- Procura por texto com porcentagem
    for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            local texto = obj.Text or ""
            local percentual = texto:match("(%d+)%%")
            if percentual then
                return tonumber(percentual)
            end
        end
        -- Procura por barra vermelha (Frame)
        if obj:IsA("Frame") and obj.BackgroundColor3.R > 0.7 then
            local escala = obj.Size.X.Scale
            if escala > 0 then
                return math.floor(escala * 100)
            end
        end
        -- Procura por ImageLabel vermelha
        if obj:IsA("ImageLabel") and obj.BackgroundColor3.R > 0.7 then
            local escala = obj.Size.X.Scale
            if escala > 0 then
                return math.floor(escala * 100)
            end
        end
    end
    return 0
end

-- LOOP PRINCIPAL
local function iniciarFarm()
    local semAtaque = 0
    while ativado do
        -- 1. Tentar atacar
        local atacou = atacarM1()
        
        -- 2. Verificar despertar
        local valor = valorBarraDespertar()
        statusLabel.Text = "📊 Despertar: " .. valor .. "% | Ataque: " .. (atacou and "✓" or "✗")
        
        if valor >= 100 then
            statusLabel.Text = "⚡ DESPERTANDO!"
            clicarDespertar()
            task.wait(1)
        end
        
        -- Se não atacou por 10 vezes seguidas, mostra aviso
        if not atacou then
            semAtaque = semAtaque + 1
            if semAtaque >= 10 then
                statusLabel.Text = "⚠️ Não achou botão de ataque! Use DEBUG"
                semAtaque = 0
            end
        else
            semAtaque = 0
        end
        
        task.wait(0.2)
    end
end

-- BOTÃO LIGA/DESLIGA
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

print("✅ Script Delta Mobile V2 carregado!")
print("📱 Auto M1 + Despertar + Debug")
