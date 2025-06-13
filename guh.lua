-- Roblox Extreme Teleport & Fling with 0-10000 Speed Control
-- [TARGET + FREESPIN MODES] Target fling and free spin options

-- Create the GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local StartButton = Instance.new("TextButton")
local StopButton = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local SpeedLabel = Instance.new("TextLabel")
local SpeedValue = Instance.new("TextLabel")
local SpeedSlider = Instance.new("TextButton")
local ModeButton = Instance.new("TextButton")

-- GUI Setup
ScreenGui.Name = "ExtremeFlingGUI"
ScreenGui.Parent = game:GetService("CoreGui")

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderColor3 = Color3.fromRGB(15, 15, 15)
Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
Frame.Size = UDim2.new(0, 400, 0, 350)
Frame.Active = true
Frame.Draggable = true

Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderColor3 = Color3.fromRGB(10, 10, 10)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "EXTREME FLING CONTROLLER"
Title.TextColor3 = Color3.fromRGB(255, 100, 100)
Title.TextSize = 20

TextBox.Name = "UsernameInput"
TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.BorderColor3 = Color3.fromRGB(30, 30, 30)
TextBox.Position = UDim2.new(0.1, 0, 0.2, 0)
TextBox.Size = UDim2.new(0.8, 0, 0, 35)
TextBox.Font = Enum.Font.SourceSansSemibold
TextBox.PlaceholderText = "Enter Player Username"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 16

SpeedLabel.Name = "SpeedLabel"
SpeedLabel.Parent = Frame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.1, 0, 0.35, 0)
SpeedLabel.Size = UDim2.new(0.8, 0, 0, 20)
SpeedLabel.Font = Enum.Font.SourceSansSemibold
SpeedLabel.Text = "FLING POWER (0-10000):"
SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
SpeedLabel.TextSize = 16
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

SpeedValue.Name = "SpeedValue"
SpeedValue.Parent = Frame
SpeedValue.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedValue.BorderColor3 = Color3.fromRGB(30, 30, 50)
SpeedValue.Position = UDim2.new(0.7, 0, 0.45, 0)
SpeedValue.Size = UDim2.new(0.2, 0, 0, 30)
SpeedValue.Font = Enum.Font.SourceSansBold
SpeedValue.Text = "5000"
SpeedValue.TextColor3 = Color3.fromRGB(100, 200, 255)
SpeedValue.TextSize = 18

SpeedSlider.Name = "SpeedSlider"
SpeedSlider.Parent = Frame
SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpeedSlider.BorderColor3 = Color3.fromRGB(30, 30, 40)
SpeedSlider.Position = UDim2.new(0.1, 0, 0.45, 0)
SpeedSlider.Size = UDim2.new(0.55, 0, 0, 30)
SpeedSlider.Font = Enum.Font.SourceSans
SpeedSlider.Text = ""
SpeedSlider.TextColor3 = Color3.fromRGB(0, 0, 0)
SpeedSlider.TextSize = 14

-- Slider handle
local SliderHandle = Instance.new("Frame")
SliderHandle.Name = "Handle"
SliderHandle.Parent = SpeedSlider
SliderHandle.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
SliderHandle.BorderColor3 = Color3.fromRGB(70, 110, 200)
SliderHandle.Size = UDim2.new(0, 15, 1, 0)
SliderHandle.Position = UDim2.new(0.5, -7, 0, 0)

-- Mode toggle button
ModeButton.Name = "ModeButton"
ModeButton.Parent = Frame
ModeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
ModeButton.BorderColor3 = Color3.fromRGB(50, 50, 120)
ModeButton.Position = UDim2.new(0.1, 0, 0.6, 0)
ModeButton.Size = UDim2.new(0.8, 0, 0, 30)
ModeButton.Font = Enum.Font.SourceSansBold
ModeButton.Text = "MODE: TARGET FLING"
ModeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ModeButton.TextSize = 16

StartButton.Name = "StartButton"
StartButton.Parent = Frame
StartButton.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
StartButton.BorderColor3 = Color3.fromRGB(40, 120, 50)
StartButton.Position = UDim2.new(0.1, 0, 0.7, 0)
StartButton.Size = UDim2.new(0.35, 0, 0, 40)
StartButton.Font = Enum.Font.SourceSansBold
StartButton.Text = "LAUNCH"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 18

StopButton.Name = "StopButton"
StopButton.Parent = Frame
StopButton.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
StopButton.BorderColor3 = Color3.fromRGB(120, 40, 40)
StopButton.Position = UDim2.new(0.55, 0, 0.7, 0)
StopButton.Size = UDim2.new(0.35, 0, 0, 40)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.Text = "ABORT"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.TextSize = 18
StopButton.Visible = false

-- Variables
local flingLoop = nil
local spinning = false
local currentSpeed = 5000
local sliderDragging = false
local spinAngle = 0
local currentMode = "target" -- "target" or "free"

-- Function to find player by username
local function findPlayer(username)
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player.Name:lower() == username:lower() or player.DisplayName:lower() == username:lower() then
            return player
        end
    end
    return nil
end

-- Slider functionality with 0-10000 range
local function updateSpeed(value)
    currentSpeed = math.clamp(math.floor(value), 0, 10000)
    SpeedValue.Text = tostring(currentSpeed)
    local position = currentSpeed / 10000
    SliderHandle.Position = UDim2.new(position, -7, 0, 0)
    
    -- More intense color changes based on speed
    local r = math.clamp(currentSpeed / 4000, 0, 1)
    local g = math.clamp(1 - (currentSpeed - 3000) / 7000, 0, 1)
    local b = math.clamp(1.5 - (currentSpeed / 6666), 0.5, 1)
    SpeedValue.TextColor3 = Color3.new(r, g, b)
end

SpeedSlider.MouseButton1Down:Connect(function(x)
    sliderDragging = true
    local relativeX = x - SpeedSlider.AbsolutePosition.X
    local percentage = math.clamp(relativeX / SpeedSlider.AbsoluteSize.X, 0, 1)
    updateSpeed(percentage * 10000)
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local relativeX = input.Position.X - SpeedSlider.AbsolutePosition.X
        local percentage = math.clamp(relativeX / SpeedSlider.AbsoluteSize.X, 0, 1)
        updateSpeed(percentage * 10000)
    end
end)

-- Function to stop the fling
local function stopFling()
    spinning = false
    if flingLoop then
        flingLoop:Disconnect()
        flingLoop = nil
    end
    
    local localPlayer = game:GetService("Players").LocalPlayer
    if localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
        local root = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local spinningValue = root:FindFirstChild("ExtremeSpin")
            if spinningValue then
                spinningValue:Destroy()
            end
        end
    end
    
    StopButton.Visible = false
    StartButton.Visible = true
    spinAngle = 0
end

-- Toggle between modes
ModeButton.MouseButton1Click:Connect(function()
    if currentMode == "target" then
        currentMode = "free"
        ModeButton.Text = "MODE: FREE SPIN"
        ModeButton.BackgroundColor3 = Color3.fromRGB(180, 80, 180)
        TextBox.Visible = false
    else
        currentMode = "target"
        ModeButton.Text = "MODE: TARGET FLING"
        ModeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 180)
        TextBox.Visible = true
    end
end)

-- Target fling function
local function startTargetFling(targetPlayer)
    local localPlayer = game:GetService("Players").LocalPlayer
    
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    humanoid.PlatformStand = true
    
    -- Create body velocity for spinning
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = localPlayer.Character.HumanoidRootPart
    
    spinning = true
    StopButton.Visible = true
    StartButton.Visible = false
    spinAngle = 0
    
    -- Main fling loop for target mode
    flingLoop = game:GetService("RunService").Heartbeat:Connect(function(delta)
        if not spinning then return end
        
        if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            stopFling()
            return
        end
        
        local targetCharacter = targetPlayer.Character
        if not targetCharacter or not targetCharacter:FindFirstChild("HumanoidRootPart") then
            stopFling()
            return
        end
        
        -- EXTREME speed scaling
        local speedFactor = (currentSpeed / 2000) ^ 3
        local spinSpeed = 1500 * speedFactor
        local upwardForce = 300 * speedFactor
        
        -- Hyper-spinning
        spinAngle = spinAngle + (spinSpeed * delta * 8)
        
        -- Position INSIDE the target character
        localPlayer.Character.HumanoidRootPart.CFrame = targetCharacter.HumanoidRootPart.CFrame * 
            CFrame.Angles(0, math.rad(spinAngle), 0)
        
        -- Apply forces
        local upwardVariation = math.sin(tick() * 25) * (upwardForce * 1.2)
        bodyVelocity.Velocity = Vector3.new(0, upwardForce + upwardVariation, 0)
        
        -- High-speed effects
        if currentSpeed > 3000 then
            local chaosFactor = (currentSpeed - 3000) / 7000
            bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(
                math.sin(tick() * 15 + chaosFactor) * 150 * speedFactor,
                math.cos(tick() * 8) * 80 * chaosFactor,
                math.cos(tick() * 15 + chaosFactor) * 150 * speedFactor
            )
        end
        
        -- Max speed effects
        if currentSpeed > 8000 then
            local insanityFactor = (currentSpeed - 8000) / 2000
            local insanityWave = math.sin(tick() * 40) * 300 * insanityFactor
            bodyVelocity.Velocity = bodyVelocity.Velocity * (1 + insanityFactor * 0.8)
            bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(
                insanityWave,
                math.abs(insanityWave) * 1.2,
                insanityWave * 0.9
            )
        end
    end)
end

-- Free spin function (no target, just spinning)
local function startFreeSpin()
    local localPlayer = game:GetService("Players").LocalPlayer
    
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    -- Mark that we're spinning (without affecting movement)
    local root = localPlayer.Character.HumanoidRootPart
    local spinningValue = Instance.new("BoolValue")
    spinningValue.Name = "ExtremeSpin"
    spinningValue.Parent = root
    
    spinning = true
    StopButton.Visible = true
    StartButton.Visible = false
    spinAngle = 0
    
    -- Main spin loop for free mode
    flingLoop = game:GetService("RunService").Heartbeat:Connect(function(delta)
        if not spinning then return end
        
        if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            stopFling()
            return
        end
        
        -- EXTREME speed scaling
        local speedFactor = (currentSpeed / 2000) ^ 3
        local spinSpeed = 1500 * speedFactor
        
        -- Hyper-spinning
        spinAngle = spinAngle + (spinSpeed * delta * 8)
        
        -- Apply spinning rotation while maintaining position and movement
        local currentCFrame = localPlayer.Character.HumanoidRootPart.CFrame
        local newCFrame = CFrame.new(currentCFrame.Position) * 
            CFrame.Angles(0, math.rad(spinAngle), 0)
        
        -- Only modify the rotation, keep position and other properties
        localPlayer.Character.HumanoidRootPart.CFrame = newCFrame
    end)
end

-- Connect the buttons
StartButton.MouseButton1Click:Connect(function()
    if currentMode == "target" then
        local username = TextBox.Text
        if username == "" then
            TextBox.PlaceholderText = "ENTER USERNAME FIRST!"
            task.wait(1)
            TextBox.PlaceholderText = "Enter Player Username"
            return
        end
        
        local targetPlayer = findPlayer(username)
        if not targetPlayer then
            TextBox.Text = ""
            TextBox.PlaceholderText = "PLAYER NOT FOUND!"
            task.wait(1)
            TextBox.PlaceholderText = "Enter Player Username"
            return
        end
        
        StartButton.Text = "INITIALIZING..."
        task.wait(0.3)
        
        local success = pcall(function()
            startTargetFling(targetPlayer)
        end)
        
        if not success then
            StartButton.Text = "ERROR!"
            task.wait(1)
            StartButton.Text = "LAUNCH"
        end
    else
        StartButton.Text = "INITIALIZING..."
        task.wait(0.3)
        
        local success = pcall(function()
            startFreeSpin()
        end)
        
        if not success then
            StartButton.Text = "ERROR!"
            task.wait(1)
            StartButton.Text = "LAUNCH"
        end
    end
end)

StopButton.MouseButton1Click:Connect(function()
    stopFling()
end)

-- Cleanup when GUI is removed
ScreenGui.DescendantRemoving:Connect(function()
    stopFling()
end)

-- Initialize slider and UI
updateSpeed(5000)
ModeButton.Text = "MODE: TARGET FLING"
TextBox.Visible = true
