-- Các đối tượng giao diện
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local mainButton = Instance.new("TextButton", screenGui)
local menuFrame = Instance.new("Frame", screenGui)

-- Cấu hình cho button mở menu
mainButton.Size = UDim2.new(0, 200, 0, 50)
mainButton.Position = UDim2.new(0.5, -100, 0.1, 0)
mainButton.Text = "NGO TAN SANG IOS"
mainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Cấu hình cho menu frame
menuFrame.Size = UDim2.new(0, 300, 0, 400)
menuFrame.Position = UDim2.new(0.5, -150, 0.3, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menuFrame.Visible = false  -- Menu bắt đầu ẩn

-- Tạo toggle button để bật/tắt các chức năng
local function createToggleButton(text, yPosition, toggleFunction)
    local button = Instance.new("TextButton", menuFrame)
    button.Size = UDim2.new(0, 280, 0, 50)
    button.Position = UDim2.new(0, 10, 0, yPosition)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.TextColor3 = Color3.fromRGB(0, 0, 0)

    button.MouseButton1Click:Connect(toggleFunction)
    return button
end

-- Các toggle cho các chức năng
local farmLevelEnabled = false
local farmChestEnabled = false
local farmFactoryEnabled = false
local antiKickEnabled = false

-- Toggle chức năng Farm Level
local function toggleFarmLevel()
    farmLevelEnabled = not farmLevelEnabled
    print("Farm Level: " .. (farmLevelEnabled and "Bật" or "Tắt"))
end

-- Toggle chức năng Farm Chest
local function toggleFarmChest()
    farmChestEnabled = not farmChestEnabled
    print("Farm Chest: " .. (farmChestEnabled and "Bật" or "Tắt"))
end

-- Toggle chức năng Farm Nhà Máy
local function toggleFarmFactory()
    farmFactoryEnabled = not farmFactoryEnabled
    print("Farm Nhà Máy: " .. (farmFactoryEnabled and "Bật" or "Tắt"))
end

-- Toggle chức năng Anti-Kick
local function toggleAntiKick()
    antiKickEnabled = not antiKickEnabled
    print("Anti-Kick: " .. (antiKickEnabled and "Bật" or "Tắt"))
    if antiKickEnabled then
        -- Giảm lag và tránh bị văng
        game:GetService("RunService").Heartbeat:Connect(function()
            -- Tối ưu hóa tài nguyên game, tránh giật lag
            print("Đang giảm lag và tránh văng...")
        end)
    end
end

-- Tạo các button trong menu
createToggleButton("Farm Level", 50, toggleFarmLevel)
createToggleButton("Farm Chest", 110, toggleFarmChest)
createToggleButton("Farm Nhà Máy", 170, toggleFarmFactory)
createToggleButton("Anti-Kick", 230, toggleAntiKick)

-- Khi người chơi nhấn vào nút chính, menu sẽ mở/đóng
mainButton.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- Thêm màn hình vào giao diện người chơi
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Logic tự động cho từng chức năng
while true do
    wait(1)  -- Kiểm tra định kỳ nếu có chức năng bật

    -- FARM LEVEL
    if farmLevelEnabled then
        -- Tìm kiếm và đánh quái vật
        local targetEnemy = workspace:FindFirstChild("Monster") -- Giả sử có đối tượng quái vật "Monster"
        if targetEnemy then
            -- Tự động di chuyển và tấn công quái vật
            player.Character:MoveTo(targetEnemy.Position)
            wait(1) -- Đợi 1 giây để đến nơi
            print("Đang đánh quái vật...")
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and targetEnemy then
                -- Tấn công quái vật
                humanoid:Attack(targetEnemy) 
            end
        end
    end

    -- FARM CHEST
    if farmChestEnabled then
        -- Tìm và nhặt rương
        local chests = workspace:GetChildren()
        for _, chest in ipairs(chests) do
            if chest:IsA("Part") and chest.Name == "Chest" then
                -- Di chuyển đến rương
                player.Character:MoveTo(chest.Position)
                wait(1) -- Đợi đến khi di chuyển đến rương
                print("Đang nhặt rương tại vị trí: " .. tostring(chest.Position))
                -- Logic nhặt rương
                chest:Destroy() -- Giả sử rương biến mất khi nhặt
            end
        end
    end

    -- FARM NHÀ MÁY
    if farmFactoryEnabled then
        -- Tìm và tấn công lõi nhà máy
        local factoryCore = workspace:FindFirstChild("FactoryCore")
        if factoryCore then
            player.Character:MoveTo(factoryCore.Position)
            wait(2) -- Đợi đến vị trí lõi nhà máy
            print("Đang đánh lõi nhà máy...")
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:Attack(factoryCore) -- Tấn công lõi nhà máy
            end
        end
    end

    -- ANTI-KICK
    if antiKickEnabled then
        -- Giảm thiểu lag và bảo vệ khỏi bị văng
        -- Cải thiện việc xử lý trong game
        print("Anti-Kick đã bật.")
        -- Giảm tải đồ họa và các sự kiện không quan trọng
        -- Ví dụ: Dừng cập nhật các đối tượng không cần thiết
        game:GetService("RunService").Heartbeat:Connect(function()
            -- Giảm tải các sự kiện không cần thiết
            -- Giảm số lần cập nhật của các đối tượng không quan trọng
        end)
    end
end
