
local config = { -- you can safely change these if you arent retarded but they should already have the best settings
togglekey = Enum.KeyCode.Q, -- change "Q" to another key if you want to change it for some reason
 offset = 12, -- offset of how far away you want to be from your target
 speed = 11, -- speed of how fast you want to spin around target to make it harder to hit you
 y = 1.5 -- how far above you want to be to your target

}

local x = 0
local z = math.pi / 2
local toggle = false
local target = nil
local gamestarted = false
local throw = false


function makenotif(text)
    task.spawn(function()
        local ui = Instance.new("ScreenGui")
        local notification = Instance.new("Frame")
        local UIGradient = Instance.new("UIGradient")
        local title = Instance.new("TextLabel")
        local UIGradient_2 = Instance.new("UIGradient")
        local message = Instance.new("TextLabel")
         
        ui.Name = "ui"
        ui.Parent = game.CoreGui
    
    
        notification.Name = "notification"
        notification.Parent = ui
        notification.BackgroundColor3 = Color3.fromRGB(84, 84, 84)
        notification.BorderSizePixel = 0
        notification.Position = UDim2.new(1.999, 0,0.535, 0)
        notification.Size = UDim2.new(0, 229, 0, 78)
    
        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(117, 117, 117)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(117, 117, 117))}
        UIGradient.Parent = notification
    
        title.Name = "title"
        title.Parent = notification
        title.BackgroundColor3 = Color3.fromRGB(105, 203, 255)
        title.BorderSizePixel = 0
        title.Position = UDim2.new(0, 0, -0.179487184, 0)
        title.Size = UDim2.new(0, 229, 0, 14)
        title.Font = Enum.Font.Ubuntu
        title.Text = "Assassin AutoFarm"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 14.000
    
        UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(156, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(156, 0, 0))}
        UIGradient_2.Parent = title
    
        message.Name = "message"
        message.Parent = notification
        message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        message.BackgroundTransparency = 1.000
        message.Position = UDim2.new(0.0043668123, 0, 0, 0)
        message.Size = UDim2.new(0, 228, 0, 78)
        message.Font = Enum.Font.Ubuntu
        message.Text = text
        message.TextColor3 = Color3.fromRGB(255, 255, 255)
        message.TextSize = 19.000
        message.TextWrapped = true
            
            notification:TweenPosition(UDim2.new(0.847, 0,0.535, 0))
            task.wait(3)
            notification:TweenPosition(UDim2.new(1.999, 0,0.535, 0))
            task.wait(0.3)
            notification:Destroy()
        end)
    end


game:GetService("UserInputService").InputBegan:connect(function(key,chat)
if chat then return end

if key.KeyCode == config.togglekey then
toggle = not toggle

if toggle == true then
makenotif("autofarm turned on")
        end

if toggle == false then
makenotif("autofarm turned off")
        end
    end
end)

task.spawn(function() -- this is getting overcomplicated thanks to the most retarded anticheat ive ever seen on this game but i cba to recode it
while task.wait(0.6) do
if throw == true then
pcall(function()
game.ReplicatedStorage.Remotes.ThrowKnife:FireServer(target.HumanoidRootPart.Position + Vector3.new(target.Humanoid.MoveDirection.X,0,target.Humanoid.MoveDirection.Z),0,game.Players.LocalPlayer.Character.Knife.RotateValue.Value)
            end)
        end
    end
end)

game:GetService("RunService").RenderStepped:connect(function()
if game.workspace:FindFirstChild("GameMap") and game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == true and toggle == true then
gamestarted = true
else
gamestarted = false
end

if gamestarted == true then -- start autofarming

 for _,v in pairs(game.workspace:GetChildren()) do
if v.Name == game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text and game.Players:FindFirstChild(v.Name) then
 target = v
    end
end
pcall(function()
game.Players.LocalPlayer.Character.Torso.CanCollide = false
game.Players.LocalPlayer.Character.Head.CanCollide = false
game.Players.LocalPlayer.Character["Left Arm"]:Destroy()
game.Players.LocalPlayer.Character["Left Leg"]:Destroy()
game.Players.LocalPlayer.Character["Right Leg"]:Destroy()
end)

if game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") then
game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool").Parent = game.Players.LocalPlayer.Character
end

if game.Players.LocalPlayer.Character.Humanoid.Health ~= 0 and gamestarted == true then -- stop erroring faggot
x = x + config.speed / 100
z = z + config.speed / 100
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(math.sin(x) * config.offset, config.y, math.sin(z) * config.offset)
local targmag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - target.HumanoidRootPart.Position).magnitude
if targmag < 50 then
        throw = true
else
        throw = false
            end
         end
     end
end)





makenotif("Assassin autofarm executed, made by Scartesu")
