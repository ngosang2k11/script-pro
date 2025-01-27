-- Tạo GUI tối ưu
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextButton")

-- Thiết lập giao diện
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Draggable = true
Frame.Active = true

Title.Parent = Frame
Title.Text = "NGO TAN SANG IOS"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

Title.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- Tạo chức năng toggle
local function createToggleButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Parent = Frame
    button.Text = name .. " [OFF]"
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = UDim2.new(0, 0, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    local enabled = false
    button.MouseButton1Click:Connect(function()
        enabled = not enabled
        button.Text = name .. (enabled and " [ON]" or " [OFF]")
        callback(enabled)
    end)
end

-- Hàm di chuyển mượt mà
local function smoothMove(targetCFrame)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = targetCFrame
        wait(0.2)
    end
end

-- FARM LEVEL tối ưu
createToggleButton("FARM LEVEL", 50, function(enabled)
    while enabled do
        local quest = game:GetService("Players").LocalPlayer.Quests
        if quest then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "CurrentQuest")
            wait(1)
            
            local enemies = game:GetService("Workspace").Enemies:GetChildren()
            for _, enemy in pairs(enemies) do
                if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    smoothMove(enemy.HumanoidRootPart.CFrame)
                    wait(0.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MeleeAttack")
                end
            end
        end
        wait(1)
    end
end)

-- FARM CHEST tối ưu
createToggleButton("FARM CHEST", 110, function(enabled)
    while enabled do
        for _, chest in pairs(game:GetService("Workspace"):GetChildren()) do
            if chest:IsA("Model") and chest:FindFirstChild("HumanoidRootPart") then
                smoothMove(chest.HumanoidRootPart.CFrame)
                wait(0.3)
            end
        end
        wait(2)
    end
end)

-- FARM NHÀ MÁY tối ưu
createToggleButton("FARM NHÀ MÁY", 170, function(enabled)
    while enabled do
        local factoryCore = game:GetService("Workspace"):FindFirstChild("FactoryCore")
        if factoryCore then
            smoothMove(factoryCore.CFrame)
            while factoryCore.Parent and enabled do
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MeleeAttack")
                wait(0.5)
            end
        end
        wait(3)
    end
end)

-- ANTI-KICK tối ưu
createToggleButton("ANTI-KICK", 230, function(enabled)
    if enabled then
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    end
end)
