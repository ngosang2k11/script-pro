-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SANGIOSMenu"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Tạo nút mở/đóng menu
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0.2, 0, 0.05, 0)
toggleButton.Position = UDim2.new(0.4, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.Text = "SANG IOS"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.Parent = screenGui

-- Tạo Frame chính cho menu
local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuFrame"
menuFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
menuFrame.Position = UDim2.new(0.3, 0, 0.15, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Đen nhạt
menuFrame.Visible = false -- Ẩn menu ban đầu
menuFrame.Parent = screenGui

-- Tạo tiêu đề menu
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "SANG IOS Menu"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = menuFrame

-- Tạo nút "Random VIP" và công tắc bật/tắt
local randomVipLabel = Instance.new("TextLabel")
randomVipLabel.Name = "RandomVIPLabel"
randomVipLabel.Size = UDim2.new(0.6, 0, 0.2, 0)
randomVipLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
randomVipLabel.BackgroundTransparency = 1
randomVipLabel.Text = "Random VIP"
randomVipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
randomVipLabel.TextScaled = true
randomVipLabel.Font = Enum.Font.SourceSans
randomVipLabel.Parent = menuFrame

local switch = Instance.new("TextButton")
switch.Name = "Switch"
switch.Size = UDim2.new(0.2, 0, 0.2, 0)
switch.Position = UDim2.new(0.75, 0, 0.4, 0)
switch.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Màu đỏ khi tắt
switch.Text = "OFF"
switch.TextColor3 = Color3.fromRGB(255, 255, 255)
switch.TextScaled = true
switch.Font = Enum.Font.SourceSansBold
switch.Parent = menuFrame

-- Biến lưu trạng thái Random VIP
local isVipEnabled = false

-- Tỉ lệ mặc định và danh sách trái cây
local defaultChance = {
    ["Common"] = 50, -- Tỉ lệ 50%
    ["Rare"] = 30,   -- Tỉ lệ 30%
    ["Legendary"] = 20 -- Tỉ lệ 20%
}

-- Tăng tỉ lệ cho VIP
local function applyVipBoost(chances)
    local boostedChance = {}
    for rarity, chance in pairs(chances) do
        if rarity == "Legendary" then
            boostedChance[rarity] = chance + 80 -- Tăng thêm 80% tỉ lệ Legendary
        else
            boostedChance[rarity] = chance -- Giữ nguyên tỉ lệ cho các loại khác
        end
    end
    return boostedChance
end

-- Hàm Random dựa trên tỉ lệ
local function randomFruit(chances)
    local totalChance = 0
    for _, chance in pairs(chances) do
        totalChance = totalChance + chance
    end

    local randomValue = math.random(1, totalChance)
    local cumulativeChance = 0

    for rarity, chance in pairs(chances) do
        cumulativeChance = cumulativeChance + chance
        if randomValue <= cumulativeChance then
            return rarity
        end
    end
end

-- Chức năng Random VIP
local function randomWithVip()
    local chances = defaultChance
    if isVipEnabled then
        chances = applyVipBoost(defaultChance)
    end
    local result = randomFruit(chances)
    print("Kết quả Random:", result)
    return result
end

-- Chức năng bật/tắt Random VIP
switch.MouseButton1Click:Connect(function()
    isVipEnabled = not isVipEnabled
    if isVipEnabled then
        switch.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Màu xanh khi bật
        switch.Text = "ON"
        print("Random VIP đã bật! Tỉ lệ Legendary tăng thêm 80%")
    else
        switch.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Màu đỏ khi tắt
        switch.Text = "OFF"
        print("Random VIP đã tắt! Tỉ lệ trở về mặc định")
    end
end)

-- Chức năng mở/đóng menu
toggleButton.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)
