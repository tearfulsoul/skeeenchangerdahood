--anticheat bypass
repeat wait() until game:IsLoaded()

game:GetService("CorePackages").Packages:Destroy()

assert(getrawmetatable)
grm = getrawmetatable(game)
setreadonly(grm, false)
old = grm.__namecall
grm.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if tostring(args[1]) == "TeleportDetect" then
        return
    elseif tostring(args[1]) == "CHECKER_1" then
        return
    elseif tostring(args[1]) == "CHECKER" then
        return
    elseif tostring(args[1]) == "GUI_CHECK" then
        return
    elseif tostring(args[1]) == "OneMoreTime" then
        return
    elseif tostring(args[1]) == "checkingSPEED" then
        print('bypassing[3/4]..')
        return
    elseif tostring(args[1]) == "BANREMOTE" then
        return
    elseif tostring(args[1]) == "PERMAIDBAN" then
        return
    elseif tostring(args[1]) == "KICKREMOTE" then
        return
    elseif tostring(args[1]) == "BR_KICKPC" then
        return
    elseif tostring(args[1]) == "BR_KICKMOBILE" then
        return
    end
    return old(self, ...)
end)




local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local playerName = localPlayer.Name
-- Create the ScreenGui to display the UI bars and text
local VelocityIndicator = Instance.new("ScreenGui")
VelocityIndicator.Parent = game.Players.LocalPlayer.PlayerGui
VelocityIndicator.Enabled = false
-- Create the outer bar
local outerBarFrame = Instance.new("Frame")
outerBarFrame.Size = UDim2.new(0, 220, 0, 10) -- Adjust size as needed
outerBarFrame.Position = UDim2.new(0.05, 0, 0.5, -10) -- Adjust position to center left
outerBarFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
outerBarFrame.BorderSizePixel = 2
outerBarFrame.BorderColor3 = Color3.new(0, 0, 0) -- Black outline
outerBarFrame.Parent = VelocityIndicator

-- Create a TextLabel for displaying "Current Velocity:"
local velocityTextLabel = Instance.new("TextLabel")
velocityTextLabel.Size = UDim2.new(0, 120, 0, 20)
velocityTextLabel.Position = UDim2.new(0, 5, 0, -30)
velocityTextLabel.Text = "{ Current Velocity:"
velocityTextLabel.TextColor3 = Color3.new(1, 1, 1)
velocityTextLabel.TextSize = 12 -- Smaller text size
velocityTextLabel.BackgroundTransparency = 1
velocityTextLabel.Parent = outerBarFrame
velocityTextLabel.TextStrokeTransparency = 0
velocityTextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)

-- Create a TextLabel for displaying the velocity value
local velocityValueTextLabel = Instance.new("TextLabel")
velocityValueTextLabel.Size = UDim2.new(0, 50, 0, 20)
velocityValueTextLabel.Position = UDim2.new(0, 180, 0, -30)
velocityValueTextLabel.Text = ""
velocityValueTextLabel.TextColor3 = Color3.new(1, 1, 1)
velocityValueTextLabel.TextSize = 12 -- Smaller text size
velocityValueTextLabel.BackgroundTransparency = 1
velocityValueTextLabel.Parent = outerBarFrame
velocityValueTextLabel.TextStrokeTransparency = 0
velocityValueTextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)

-- Create the inner bar
local innerBarFrame = Instance.new("Frame")
innerBarFrame.Size = UDim2.new(0, 0, 1, 0) -- Inner bar starts at 0 width
innerBarFrame.Position = UDim2.new(0, 0, 0, 0) -- Starts from the left
innerBarFrame.BackgroundColor3 = Color3.new(0.3, 0.5, 0.7) -- Blue color for inner bar
innerBarFrame.BorderSizePixel = 0
innerBarFrame.Parent = outerBarFrame

-- Function to update the inner bar size and velocity text
local function updateInnerBar()
    while humanoid and humanoid.Parent do
        local velocity = humanoid.RootPart.Velocity
        local speed = velocity.Magnitude
        local barSize = math.min(speed, 21) * 10
        innerBarFrame.Size = UDim2.new(0, barSize, 1, 0)
        velocityValueTextLabel.Text = tostring(math.floor(speed)) .. " }"
        task.wait()
    end
end

-- Function to continuously check for the existence of humanoid
local function checkHumanoid()
    while true do
        if not humanoid or not humanoid.Parent then
            humanoid = character:WaitForChild("Humanoid")
            if humanoid then
                spawn(updateInnerBar) -- Restart the update loop if humanoid is found
            end
        end
        task.wait(1) -- Check every second
    end
end

function Alive(Player)
    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player.Character:FindFirstChild("Humanoid") ~= nil and Player.Character:FindFirstChild("Head") ~= nil then
        return true
    end
    return false
end

-- Create the ScreenGui to display the ping and FPS UI
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Create the ScreenGui to display the UI bars and text
local PerFormanceIndi = Instance.new("ScreenGui")
PerFormanceIndi.Parent = game.Players.LocalPlayer.PlayerGui
PerFormanceIndi.Enabled = false -- Initially enabled

-- Function to create a UI bar with text
local function createBar(name, position, color)
    local outerBarFrame = Instance.new("Frame")
    outerBarFrame.Name = name
    outerBarFrame.Size = UDim2.new(0, 220, 0, 10)
    outerBarFrame.Position = position
    outerBarFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    outerBarFrame.BorderSizePixel = 2
    outerBarFrame.BorderColor3 = Color3.new(0, 0, 0)
    outerBarFrame.Parent = PerFormanceIndi

    local innerBarFrame = Instance.new("Frame")
    innerBarFrame.Name = "InnerBar"
    innerBarFrame.Size = UDim2.new(0, 0, 1, 0)
    innerBarFrame.BackgroundColor3 = color
    innerBarFrame.BorderSizePixel = 0
    innerBarFrame.Parent = outerBarFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ValueText"
    textLabel.Size = UDim2.new(0, 200, 0, 20)
    textLabel.Position = UDim2.new(0, 5, 0, -30) -- Adjusted position to the top-left corner, outside the bar
    textLabel.Text = ""
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextSize = 12
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = outerBarFrame
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)

    return innerBarFrame, textLabel
end

-- Create bars for ping and FPS
local pingBar, pingText = createBar("PingBar", UDim2.new(0.05, 0, 0.6, -10), Color3.new(0.3, 0.7, 0.3))
local fpsBar, fpsText = createBar("FPSBar", UDim2.new(0.05, 0, 0.7, -10), Color3.new(0.7, 0.3, 0.3))

-- Function to update the bars
local function updateBars()
    while true do
        -- Update ping bar
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
        local pingSize = math.min(ping / 300, 1) * 220
        pingBar.Size = UDim2.new(0, pingSize, 1, 0)
        pingText.Text = "{ Ping: "  ..  "                          " ..  string.format("%.0f", ping) .. " }"

        -- Update FPS bar
        local fps = 1 / game:GetService("RunService").RenderStepped:Wait()
        local fpsSize = math.min(fps / 500, 1) * 220
        fpsBar.Size = UDim2.new(0, fpsSize, 1, 0)
        fpsText.Text = "{ FPS: " ..  "                          " .. tostring(math.floor(fps)) .. " }"

        task.wait(0.01) -- Update rate
    end
end

-- Start updating the bars








-- Game services
local Players = game:GetService('Players')
local heartbeat = game:GetService("RunService").Heartbeat
local renderstepped = game:GetService("RunService").RenderStepped
local stepped = game:GetService("RunService").Stepped
local Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local CurrentCamera = game:GetService "Workspace".CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local Players = game:GetService('Players')
local Plr = game.Players.LocalPlayer
local Line = Drawing.new("Line")
local Inset = game:GetService("GuiService"):GetGuiInset().Y
local UserInputService = game:GetService("UserInputService")
local colorcorrection = Instance.new("ColorCorrectionEffect")
colorcorrection.Parent = game.Lighting








local worldvis = {
    WorldVisuals = {
        MapBrightness = 0,
        MapContrast = 0,
        MapTintColor = Color3.new(1, 1, 1),

    }
}
game:GetService("RunService").RenderStepped:Connect(function()

    if colorcorrection.Brightness ~= worldvis.WorldVisuals.MapBrightness then
        colorcorrection.Brightness = worldvis.WorldVisuals.MapBrightness
    end

    if colorcorrection.Contrast ~= worldvis.WorldVisuals.MapContrast then
        colorcorrection.Contrast = worldvis.WorldVisuals.MapContrast
    end

    if colorcorrection.TintColor ~= worldvis.WorldVisuals.MapTintColor then
        colorcorrection.TintColor = worldvis.WorldVisuals.MapTintColor
    end
end)


---- Dahod moderator ids
local dickface = {
    1830168970,
    29242182,
    4690110040,
    439942262,
    3944434729,
    67819707,
    4545223,
    155627580,
    3520967,
    89473551,
    2395613299,
    244844600,
    808962546,
    201454243,
    28357488,
    822999,
    93101606,
    163721789,
    8195210,
  
 
}


-- BOOTING ESP
local Sense = loadstring(game:HttpGet('https://sirius.menu/sense'))()

--LOAD ESP 
Sense.Load()

ZekeTriggerBot = {
    Enabled = false,
    DelayAmount = 0
}

------------------------- AIMBOT -----------------------------

getgenv().Settings = {
    Main = {
        Enable = true,
 
        HoldKey = false,
        ToggleKey = true,
 
        UseKeyBoardKey = true,
        KeyBoardKey = Enum.KeyCode.Q, -- https://create.roblox.com/docs/reference/engine/enums/KeyCode
 
        UseMouseKey = false,
        ThirdPerson = true,
        FirstPerson = true,
 
        AutoPingSets = false,
 
        UseCircleRadius = false,
        DisableOutSideCircle = false,
 
        UseShake = false,
        ShakePower = 1,
 
        CheckForWalls = false
    },
    Check = {
        CheckIfKo = false, -- This Is For Da Hood
        DisableOnTargetDeath = false,
        DisableOnPlayerDeath = false
    },
    Horizontal = {
        PredictMovement = false,
        PredictionVelocity = 0.17221418
    },
    Smooth = {
        Smoothness = true,
        SmoothnessAmount = 1,
        SmoothMethod = Enum.EasingStyle.Circular,
        SmoothMethodV2 = Enum.EasingDirection.InOut
    },
    Part = {
        AimPart = "Head",
        CheckIfJumpedAimPart = "HumanoidRootPart",
        CheckIfJumped = false,
        GetClosestPart = false
    },
    Resolver = {
        UnderGround = false,
        DetectDesync = false,
        Detection = 75
    },
    Visual = {
        Fov = false,
        FovTransparency = 1,
        FovThickness = 1,
        FovColor = Color3.fromRGB(255, 185, 0),
        FovRadius = 360
    }
}
 

------------- end of aimbot table

local new = { 
    main = { 
        ZekeTargetLock = false,
        Prediction = 0.13,
        Part = "HumanoidRootPart", -- Head, UpperTorso, HumanoidRootPart, LowerTorso, RightFoot, LeftFoot, RightArm, LeftArm 
        Key = Enum.KeyCode.E, -- Using Enum.KeyCode for key
        Notifications = false,
        AirshotFunc = false,
        Orbit = false, -- Added orbit feature
        OrbitDistance = 10, -- Default orbit distance
        OrbitSpeed = 50 -- Default orbit speed (in degrees per second)
    },
    Tracer = { 
        TracerThickness = 3.5,
        TracerTransparency = 1,
        TracerColor = Color3.fromRGB(153, 50, 204)
    }
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CurrentCamera = game.Workspace.CurrentCamera
local Plr = Players.LocalPlayer
local Line = Drawing.new("Line")
local Inset = game:GetService("GuiService"):GetGuiInset().Y

local delta = 0
local duration = 5

local lockedTarget = nil

local function FindClosestUser()
    local closestPlayer
    local shortestDistance = math.huge

    -- If there's a locked target, prioritize it
    if new.main.ZekeTargetLock == true and lockedTarget then
        return lockedTarget
    end

    -- Otherwise, find the closest player
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Plr and player.Character and player.Character:FindFirstChild("Humanoid") and
            player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = CurrentCamera:WorldToViewportPoint(player.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = player
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

local function SpinAroundTarget(target)
    local targetPosition = target.Character.HumanoidRootPart.Position
    local spinRadius = new.main.OrbitDistance
    local spinSpeed = new.main.OrbitSpeed

    local angle = math.rad(workspace.DistributedGameTime * spinSpeed)
    local offsetX = math.cos(angle) * spinRadius
    local offsetZ = math.sin(angle) * spinRadius

    local newPosition = targetPosition + Vector3.new(offsetX, 0, offsetZ)
    local lookAt = (targetPosition - newPosition).unit
    local rotation = CFrame.new(newPosition, newPosition + lookAt)

    Plr.Character.HumanoidRootPart.CFrame = rotation
end

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == new.main.Key then
        if new.main.ZekeTargetLock == true then
            new.main.ZekeTargetLock = false
            if new.main.Notifications == true then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "ZekeHub",
                    Text = "No longer locked on"
                })
            end
        else
            local target = FindClosestUser()
            if target then
                lockedTarget = target
                new.main.ZekeTargetLock = true
                if new.main.Notifications == true then
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "ZekeHub",
                        Text = "Locked on to:" .. tostring(lockedTarget.Character.Humanoid.DisplayName)
                    })
                end
            end
        end
    end
end)

RunService.Stepped:Connect(function(a, b)
    if new.main.ZekeTargetLock == true and lockedTarget then
        if new.main.Orbit == true then
            SpinAroundTarget(lockedTarget)
        end

        local Vector = CurrentCamera:WorldToViewportPoint(lockedTarget.Character[new.main.Part].Position +
                                                              (lockedTarget.Character.HumanoidRootPart.Velocity *
                                                                  new.main.Prediction))
        Line.Color = new.Tracer.TracerColor
        Line.Thickness = new.Tracer.TracerThickness
        Line.Transparency = new.Tracer.TracerTransparency

        Line.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y + Inset)
        Line.To = Vector2.new(Vector.X, Vector.Y)
        Line.Visible = true
    else
        Line.Visible = false
    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if new.main.ZekeTargetLock and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
        args[3] = lockedTarget.Character[new.main.Part].Position +
                      (lockedTarget.Character[new.main.Part].Velocity * new.main.Prediction)
        return old(unpack(args))
    end
    return old(...)
end)

if new.main.AirshotFunc == true then
    if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
        new.main.Part = "RightFoot"
    else
        Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old,new)
            if new == Enum.HumanoidStateType.Freefall then
                new.main.Part = "RightFoot"
            else
                new.main.Part = "LowerTorso"
            end
        end)
    end
end










----end of silent aim











----- ANTI SLOW Table
local SlowSettings = {
    AntiSlowEnabled = nil,
}


---ANTI AFK LOAD

local isAntiAFKEnabled = false
local bb = game:GetService('VirtualUser')
local idledConnection

local function enableAntiAFK()
    if isAntiAFKEnabled then return end
    isAntiAFKEnabled = true
    idledConnection = game:GetService('Players').LocalPlayer.Idled:Connect(function()
        bb:CaptureController()
        bb:ClickButton2(Vector2.new())
        wait(2)
    end)
end

local function disableAntiAFK()
    if not isAntiAFKEnabled then return end
    isAntiAFKEnabled = false
    if idledConnection then
        idledConnection:Disconnect()
    end
end

local function toggleAntiAFK()
    if isAntiAFKEnabled then
        disableAntiAFK()
    else
        enableAntiAFK()
    end
end

local AntiAfkToggle = false 


--LOCAL chams toggle
local LOCALCHAM = {
    Chams = {
        Enabled = false, -- Whether the chams effect is enabled
        Rainbow = false, -- Whether the chams effect color is rainbow
        Material = Enum.Material.ForceField, -- Default material for chams effect
        Color = Color3.fromRGB(255, 105, 180) -- Default color for chams effect (pink)
    }
}
---


----enemy chams



---



local HoldingSpace = nil
--- NJC Table
local Settings2 = {
    NoJumpCooldownEnabled = nil,
}

-------- BOOTING NOJUMP



local monkeyNJC = {
    RemoveJumpCooldown = false
}

local TimeTick
TimeTick =
    hookfunction(
    wait,
    function(JumpCooldown)
        if JumpCooldown == 1.5 and monkeyNJC.RemoveJumpCooldown then
            return TimeTick()
        end
        return TimeTick(JumpCooldown)
    end
)

local ZekeHubSpeed = {
    CframeSpeed = {
		Enabled = false,
		Bhop = false,
		Keybind = Enum.KeyCode.Z,
		Speed = 1
    }
}




---crosshair initialization
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local crosshair_cfg = {
    Visible = false,
    Size = 50,  -- This represents the length of the crosshair
    SpinSpeed = 1,
    SpinAnimation = true,
    Position = Vector2.new(0, 0),
    Color = Color3.new(1, 0, 1),
    Thickness = 1.5
}

local lineSets = {
    {count = crosshair_cfg.Size, thickness = crosshair_cfg.Thickness, direction = 0, visible = crosshair_cfg.Visible},   -- Bottom
    {count = crosshair_cfg.Size, thickness = crosshair_cfg.Thickness, direction = 90, visible = crosshair_cfg.Visible},  -- Top
    {count = crosshair_cfg.Size, thickness = crosshair_cfg.Thickness, direction = 180, visible = crosshair_cfg.Visible}, -- Right
    {count = crosshair_cfg.Size, thickness = crosshair_cfg.Thickness, direction = 270, visible = crosshair_cfg.Visible}  -- Left
}
local drawings = {}

local watermark = Drawing.new("Text")
watermark.Text = "ZekeHub"
watermark.Size = 20
watermark.Color = Color3.new(1, 1, 1) -- White text color
watermark.Center = true
watermark.Outline = true -- Enable outline
watermark.OutlineColor = Color3.new(0, 0, 0) -- Black outline

local extensionText = Drawing.new("Text")
extensionText.Text = ".lua"
extensionText.Size = 20
extensionText.Center = true
extensionText.Outline = true -- Enable outline
extensionText.OutlineColor = Color3.new(0, 0, 0) -- Black outline

local function updateLines(cursorPosition)
    -- Update watermark visibility
    watermark.Visible = crosshair_cfg.Visible
    extensionText.Visible = crosshair_cfg.Visible

    -- Update watermark position below the crosshair
    watermark.Position = Vector2.new(cursorPosition.X, cursorPosition.Y + 20) -- Adjust the Y position as needed
    extensionText.Position = Vector2.new(cursorPosition.X + watermark.TextBounds.X / 2 + extensionText.TextBounds.X / 2 + 2, cursorPosition.Y + 20) -- Adjust the X position based on text bounds

    for setIndex, set in ipairs(lineSets) do
        for i, line in ipairs(drawings[setIndex]) do
            local alpha = 0.1 + (i / set.count) * 0.8 
            local angle = math.rad(set.direction)
            local xOffset = math.cos(angle) * (i * 5)
            local yOffset = math.sin(angle) * (i * 5)    
            local fromX = cursorPosition.X + xOffset + crosshair_cfg.Position.X
            local fromY = cursorPosition.Y + yOffset + crosshair_cfg.Position.Y
            local toX = cursorPosition.X + xOffset * 2 + crosshair_cfg.Position.X
            local toY = cursorPosition.Y + yOffset * 2 + crosshair_cfg.Position.Y
            line.From = Vector2.new(fromX, fromY)
            line.To = Vector2.new(toX, toY)
            line.Color = crosshair_cfg.Color
            line.Thickness = crosshair_cfg.Thickness
            line.Transparency = 1 - alpha
            line.Visible = set.visible
        end
    end
end

for setIndex, set in ipairs(lineSets) do
    drawings[setIndex] = {}
    for i = 1, set.count do
        local line = Drawing.new('Line')
        line.ZIndex = 2
        line.Thickness = set.thickness
        drawings[setIndex][i] = line
    end
end

RunService.RenderStepped:Connect(function()
    if crosshair_cfg.SpinAnimation then 
        for setIndex, set in ipairs(lineSets) do
            set.direction = set.direction + crosshair_cfg.SpinSpeed
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local cursorPosition = UserInputService:GetMouseLocation()
    updateLines(cursorPosition)
end)

local function recenterCrosshair()
    lineSets[1].direction = 0  -- Bottom
    lineSets[2].direction = 90 -- Top
    lineSets[3].direction = 180 -- Right
    lineSets[4].direction = 270 -- Left
end
-- If spin feature is disabled, recenter the crosshair

if not crosshair_cfg.SpinAnimation then
    recenterCrosshair()
end

---crosshair initialization






local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
-- Load necessary libraries
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Load UI notification library
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

-- Notify injection success
Notification:Notify(
    { Title = "Zeke Hub", Description = "Zeke Hub Successfully Injected" },
    { OutlineColor = Color3.fromRGB(80, 80, 80), Time = 3, Type = "image" },
    { Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84) }
)

-- Create the main window
local Window = Library:CreateWindow({
    Title = 'Zeke Hub | Dahood Rewrite',
    Center = true,
    AutoShow = true,
    TabPadding = 3,
    MenuFadeTime = 0.2
})

-- Add tabs
local Tabs = {
    Aimbot = Window:AddTab('Aimbot'),
    AntiAimTab = Window:AddTab('Anti-Aim'),
    Visuals = Window:AddTab('Visuals'),
    Movement = Window:AddTab('Movement'),
    ExtraTab = Window:AddTab('Extras'),
    PlayerlistTab = Window:AddTab('PlayerList'),
    ['UI Settings'] = Window:AddTab('Config'),
}


-----////// START OF CAMLOCK TAB

local CamlockTab = Tabs.Aimbot:AddLeftGroupbox('Camlock')


CamlockTab:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'Q', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Camlock Keybind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        print('[cb] Keybind clicked!', Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        getgenv().Settings.Main.KeyBoardKey = New
        print('[cb] Keybind changed!', New)
    end
})

CamlockTab:AddToggle('MyToggle', {
    Text = 'Auto Prediction',
    Default = false, 
    Tooltip = 'Aimbot MasterKey',

    Callback = function(Value)
		getgenv().Settings.Main.AutoPingSets = Value
        print('[cb] MyToggle changed to:', Value)
    end
})


CamlockTab:AddToggle('MyToggle', {
    Text = 'Prediction',
    Default = false, 
    Tooltip = 'Prediction MasterKey',

    Callback = function(Value)
		getgenv().Settings.Horizontal.PredictMovement = Value
        print('[cb] MyToggle changed to:', Value)
    end
})


CamlockTab:AddSlider('MySlider', {
    Text = 'Prediction Amount',
    Default = 0.129,
    Min = 0,
    Max = 2,
    Rounding = 4,
    Compact = true,

    Callback = function(Value)
		getgenv().Settings.Horizontal.PredictionVelocity = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})

CamlockTab:AddToggle('MyToggle', {
    Text = 'Smoothness',
    Default = false, 
    Tooltip = 'Aimbot Smoothness',

    Callback = function(Value)
		getgenv().Settings.Smooth.Smoothness = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

CamlockTab:AddSlider('MySlider', {
    Text = 'Smoothness Amount',
    Default = 0.015,
    Min = 0,
    Max = 1,
    Rounding = 4,
    Compact = true,

    Callback = function(Value)
        getgenv().Settings.Smooth.SmoothnessAmount = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})

CamlockTab:AddToggle('MyToggle', {
    Text = 'Shake',
    Default = false, 
    Tooltip = 'Shake MasterKey',

    Callback = function(Value)
		getgenv().Settings.Main.UseShake = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

CamlockTab:AddSlider('MySlider', {
    Text = 'Shake Amount',
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
        getgenv().Settings.Main.ShakePower = Value * 3
        print('[cb] MySlider was changed! New value:', Value)
    end
})

CamlockTab:AddDropdown('MyDropdown', {
    Values = { 'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Hitbox Selection',
    Tooltip = 'Select a Hitbox to Aim at', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        getgenv().Settings.Part.AimPart = Value
        print('[cb] Dropdown got changed. New value:', Value)
    end
})

CamlockTab:AddToggle('MyToggle', {
    Text = 'Different Jump Hitbox',
    Default = false, 
    Tooltip = 'Different Jump Hitbox',

    Callback = function(Value)
		getgenv().Settings.Part.CheckIfJumped = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

CamlockTab:AddDropdown('MyDropdown', {
    Values = { 'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso' },
    Default = 3, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Jumped Hitbox Selection',
    Tooltip = 'Select a Hitbox to Aim at If Jumped', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        getgenv().Settings.Part.CheckIfJumpedAimPart = Value
        print('[cb] Dropdown got changed. New value:', Value)
    end
})



CamlockTab:AddToggle('MyToggle', {
    Text = 'Resolver',
    Default = false, 
    Tooltip = 'Resolver',

    Callback = function(Value)
        if Value then
		RunService.Heartbeat:Connect(function()
            pcall(function()
                for i,v in pairs(game.Players:GetChildren()) do
                    if v.Name ~= game.Players.LocalPlayer.Name then
                        local hrp = v.Character.HumanoidRootPart
                        hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
                        hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
                    end
                end
            end)
        end)
    end
        print('[cb] MyToggle changed to:', Value)
    end
})

CamlockTab:AddToggle('MyToggle', {
    Text = 'Underground Resolver',
    Default = false, 
    Tooltip = 'Resolver',

    Callback = function(Value)
        getgenv().Settings.Resolver.UnderGround = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

CamlockTab:AddToggle('MyToggle', {
    Text = 'Detect Desync',
    Default = false, 
    Tooltip = 'Resolver',

    Callback = function(Value)
        getgenv().Settings.Resolver.DetectDesync = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

CamlockTab:AddSlider('MySlider', {
    Text = 'Detection Value',
    Default = 50,
    Min = 40,
    Max = 250,
    Rounding = 0,
    Compact = true,

    Callback = function(Value)
		getgenv().Settings.Resolver.Detection = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})




----////  TAB FOR CAMLOCK

local FOVTab = Tabs.Aimbot:AddRightGroupbox('FOV Settings')

FOVTab:AddToggle('MyToggle', {
    Text = 'FOV Enabled',
    Default = false, 
    Tooltip = 'FOV MasterKey',

    Callback = function(Value)
		getgenv().Settings.Visual.Fov = Value
        getgenv().Settings.Main.UseCircleRadius = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

FOVTab:AddSlider('MySlider', {
    Text = 'FOV Radius',
    Default = 50,
    Min = 0,
    Max = 1000,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		getgenv().Settings.Visual.FovRadius = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})

FOVTab:AddSlider('MySlider', {
    Text = 'FOV Thickness',
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		getgenv().Settings.Visual.FovThickness = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})

FOVTab:AddSlider('MySlider', {
    Text = 'FOV Transparency',
    Default = 1,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		getgenv().Settings.Visual.FovTransparency = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})

FOVTab:AddLabel('FOV Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(1, 1, 1), 
    Title = 'FOV Color', 
    Transparency = 0, 

    Callback = function(Value)
		getgenv().Settings.Visual.FovColor = Value
        print('[cb] Color changed!', Value)
    end
})






local ChecksTab = Tabs.Aimbot:AddRightGroupbox('Checks')

ChecksTab:AddToggle('MyToggle', {
    Text = 'Wall Check',
    Default = false, 
    Tooltip = 'Knock Check',

    Callback = function(Value)
		getgenv().Settings.Main.CheckForWalls = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

ChecksTab:AddToggle('MyToggle', {
    Text = 'Knock Check',
    Default = false, 
    Tooltip = 'Knock Check',

    Callback = function(Value)
		getgenv().Settings.Check.CheckIfKo = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

ChecksTab:AddToggle('MyToggle', {
    Text = 'Dead Check',
    Default = false, 
    Tooltip = 'Knock Check',

    Callback = function(Value)
		getgenv().Settings.Check.DisableOnTargetDeath = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

ChecksTab:AddToggle('MyToggle', {
    Text = 'Unlock On Death',
    Default = false, 
    Tooltip = 'Knock Check',

    Callback = function(Value)
		getgenv().Settings.Check.DisableOnPlayerDeath = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

ChecksTab:AddToggle('MyToggle', {
    Text = 'Unlock Outside of FOV Circle',
    Default = false, 
    Tooltip = 'Knock Check',

    Callback = function(Value)
		getgenv().Settings.Main.DisableOutSideCircle = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

local TargetAim = Tabs.Aimbot:AddRightGroupbox('TargetAim')

TargetAim:AddToggle('MyToggle', {
    Text = 'Enabled',
    Default = false, 
    Tooltip = 'Disable/Enable TargetAim',

    Callback = function(Value)
        new.main.ZekeTargetLock = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

TargetAim:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'E', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Target Aim Bind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        new.main.WishAim = Value
        print('[cb] Keybind clicked!', Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New) 
        new.main.Key = New
        print('[cb] Keybind changed!', New)
    end
})


TargetAim:AddInput('MyTextbox', {
    Default = '0.12954',
    Numeric = true, -- true / false, only allows numbers
    Finished = true, -- true / false, only calls callback when you press enter

    Text = 'Prediction Value',
    Tooltip = 'Please Enter A Prediction Value', -- Information shown when you hover over the textbox

    Placeholder = 'Prediction Value', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text

    Callback = function(Value)
        print('[cb] Text updated. New text:', Value)
    end
})


TargetAim:AddDropdown('MyDropdown', {
    Values = { 'Head', 'UpperTorso', 'HumanoidRootPart', 'LowerTorso', 'RightFoot', 'LeftFoot', 'RightArm', 'LeftArm' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Hitbox Selection',
    Tooltip = 'Select a hitbox to Target', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        new.main.Part = Value
        print('[cb] Dropdown got changed. New value:', Value)
    end
})


TargetAim:AddToggle('MyToggle', {
    Text = 'Compensate for inAir',
    Default = false, 
    Tooltip = 'Disable/Enable Shoot for Air',

    Callback = function(Value)
        new.main.AirshotFunc = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

TargetAim:AddToggle('MyToggle', {
    Text = 'LookAt',
    Default = false, 
    Tooltip = 'Enable/Disable LookAt',

    Callback = function(Value)
        new.main.LookAtTarget = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

TargetAim:AddToggle('MyToggle', {
    Text = 'Notification',
    Default = false, 
    Tooltip = 'Enable/Disable notifications',

    Callback = function(Value)
        new.main.Notifications = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

TargetAim:AddLabel('-----Orbit-----')


TargetAim:AddToggle('MyToggle', {
    Text = 'Orbit',
    Default = false, 
    Tooltip = 'Enable/Disable notifications',

    Callback = function(Value)
        new.main.Orbit = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

TargetAim:AddSlider('MySlider', {
    Text = 'Orbit Distance',
    Default = 5,
    Min = 0,
    Max = 50,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.main.OrbitDistance = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})

TargetAim:AddSlider('MySlider', {
    Text = 'Orbit Speed',
    Default = 3,
    Min = 0,
    Max = 10,
    Rounding = 2,
    Compact = true,

    Callback = function(Value)
		new.main.OrbitSpeed = Value * 100
        print('[cb] MySlider was changed! New value:', Value)
    end
})


TargetAim:AddLabel('-----Tracer-----')

TargetAim:AddSlider('MySlider', {
    Text = 'TargetAim Tracer Transparency',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.Tracer.TracerTransparency = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})


TargetAim:AddSlider('MySlider', {
    Text = 'TargetAim Tracer Thickness',
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		new.Tracer.TracerThickness = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})

TargetAim:AddLabel('TargetTracer Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(1, 1, 1), 
    Title = 'Target Tracer Color', 
    Transparency = 0, 

    Callback = function(Value)
        new.Tracer.TracerColor = Value
        print('[cb] Color changed!', Value)
    end
})



local TriggerBotSec = Tabs.Aimbot:AddLeftGroupbox('Triggerbot')

TriggerBotSec:AddToggle('MyToggle', {
    Text = 'Trigger Bot',
    Default = false, 
    Tooltip = 'Triggerbot enabled/disable',

    Callback = function(Value)
		ZekeTriggerBot.Enabled = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

TriggerBotSec:AddSlider('MySlider', {
    Text = 'Triggerboy Delay',
    Default = 50,
    Min = 0,
    Max = 60,
    Suffix = "s",
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
		ZekeTriggerBot.DelayAmount = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})
game:GetService("RunService").Heartbeat:Connect(function()
        if ZekeTriggerBot.Enabled then
        for i, v in next, Players:GetPlayers() do 
            if Alive(v) then 
                if Mouse.Target:IsDescendantOf(v.Character) and ZekeTriggerBot.Enabled == true then 
                    mouse1press()
                    wait()
                    mouse1release()
                    wait(ZekeTriggerBot.DelayAmount)
                end 
            end
        end
        end -- tb
    end)
------------------- AIMBOT LOADER

---------------------------- NOW BOOTING AIMBOT FUNCS

-- // Locals
 
local Players, Uis, RService, CurrentCamera = 
game:GetService("Players"), 
game:GetService("UserInputService"), 
game:GetService("RunService"),
game:GetService("Workspace").CurrentCamera
 
local Client = Players.LocalPlayer;
 
local Mouse, Camera = Client:GetMouse(), workspace.CurrentCamera
 
local Circle = Drawing.new("Circle")
 
local CF, RNew, Vec3, Vec2 = CFrame.new, Ray.new, Vector3.new, Vector2.new
 
local OldAimPart = getgenv().Settings.Part.AimPart
 
local AimlockTarget, MousePressed, CanNotify = nil, false, false
 
getgenv().UpdateFOV = function()
    if (not Circle) then
        return (Circle)
    end
    Circle.Color = Settings.Visual.FovColor
    Circle.Visible = Settings.Visual.Fov
    Circle.Radius = Settings.Visual.FovRadius
    Circle.Thickness = Settings.Visual.FovThickness
    Circle.Position = Vec2(Mouse.X, Mouse.Y + Inset)
    return (Circle)
end
 
RService.Heartbeat:Connect(UpdateFOV)
 
-- // Functions
 
getgenv().WallCheck = function(destination, ignore)
    local Origin = Camera.CFrame.p
    local CheckRay = RNew(Origin, destination - Origin)
    local Hit = game.workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
    return Hit == nil
end
 
getgenv().WTS = function(Object)
    local ObjectVector = Camera:WorldToScreenPoint(Object.Position)
    return Vec2(ObjectVector.X, ObjectVector.Y)
end
 
getgenv().IsOnScreen = function(Object)
    local IsOnScreen = Camera:WorldToScreenPoint(Object.Position)
    return IsOnScreen
end
 
getgenv().FilterObjs = function(Object)
    if string.find(Object.Name, "Gun") then
        return
    end
    if table.find({"Part", "MeshPart", "BasePart"}, Object.ClassName) then
        return true
    end
end
 
getgenv().GetClosestBodyPart = function(character)
    local ClosestDistance = 1 / 0
    local BodyPart = nil
    if (character and character:GetChildren()) then
        for _, x in next, character:GetChildren() do
            if FilterObjs(x) and IsOnScreen(x) then
                local Distance = (WTS(x) - Vec2(Mouse.X, Mouse.Y)).Magnitude
                if (Circle.Radius > Distance and Distance < ClosestDistance) then
                    ClosestDistance = Distance
                    BodyPart = x
                end
            end
        end
    end
    return BodyPart
end
 
getgenv().WorldToViewportPoint = function(P)
    return Camera:WorldToViewportPoint(P)
end
 
getgenv().WorldToScreenPoint = function(P)
    return Camera.WorldToScreenPoint(Camera, P)
end
 
getgenv().GetObscuringObjects = function(T)
    if T and T:FindFirstChild(getgenv().Settings.Part.AimPart) and Client and Client.Character:FindFirstChild("Head") then
        local RayPos =
            workspace:FindPartOnRay(RNew(T[getgenv().Settings.Part.AimPart].Position, Client.Character.Head.Position))
        if RayPos then
            return RayPos:IsDescendantOf(T)
        end
    end
end
 
getgenv().GetNearestTarget = function()
    local AimlockTarget, Closest = nil, 1 / 0
 
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
            local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            local Distance = (Vec2(Position.X, Position.Y) - Vec2(Mouse.X, Mouse.Y)).Magnitude
            if Settings.Main.CheckForWalls then
                if
                    (Circle.Radius > Distance and Distance < Closest and OnScreen and
                        getgenv().WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}))
                 then
                    Closest = Distance
                    AimlockTarget = v
                end
            elseif Settings.Main.UseCircleRadius then
                if
                    (Circle.Radius > Distance and Distance < Closest and OnScreen and
                        getgenv().WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}))
                 then
                    Closest = Distance
                    AimlockTarget = v
                end
            else
                if (Circle.Radius > Distance and Distance < Closest and OnScreen) then
                    Closest = Distance
                    AimlockTarget = v
                end
            end
        end
    end
    return AimlockTarget
end
 
-- // Use KeyBoardKey Function
 
Uis.InputBegan:connect(
    function(input)
        if
            input.KeyCode == Settings.Main.KeyBoardKey and Settings.Main.UseKeyBoardKey == true and
                getgenv().Settings.Main.Enable == true and
                AimlockTarget == nil and
                getgenv().Settings.Main.HoldKey == true
         then
            pcall(
                function()
                    MousePressed = true
                    AimlockTarget = GetNearestTarget()
                end
            )
        end
    end
)Uis.InputEnded:connect(
    function(input)
        if
            input.KeyCode == Settings.Main.KeyBoardKey and getgenv().Settings.Main.HoldKey == true and
                Settings.Main.UseKeyBoardKey == true and
                getgenv().Settings.Main.Enable == true and
                AimlockTarget ~= nil
         then
            AimlockTarget = nil
            MousePressed = false
        end
    end
)
 
Uis.InputBegan:Connect(
    function(keyinput, stupid)
        if
            keyinput.KeyCode == Settings.Main.KeyBoardKey and Settings.Main.UseKeyBoardKey == true and
                getgenv().Settings.Main.Enable == true and
                AimlockTarget == nil and
                getgenv().Settings.Main.ToggleKey == true
         then
            pcall(
                function()
                    MousePressed = true
                    AimlockTarget = GetNearestTarget()
                end
            )
        elseif
            keyinput.KeyCode == Settings.Main.KeyBoardKey and Settings.Main.UseKeyBoardKey == true and
                getgenv().Settings.Main.Enable == true and
                AimlockTarget ~= nil
         then
            AimlockTarget = nil
            MousePressed = false
        end
    end
)
 
-- // Use MouseKey Function
 
Uis.InputBegan:connect(
    function(input)
        if
            input.UserInputType == Settings.Main.MouseKey and Settings.Main.UseMouseKey == true and
                getgenv().Settings.Main.Enable == true and
                AimlockTarget == nil and
                getgenv().Settings.Main.HoldKey == true
         then
            pcall(
                function()
                    MousePressed = true
                    AimlockTarget = GetNearestTarget()
                end
            )
        end
    end
)Uis.InputEnded:connect(
    function(input)
        if
            input.UserInputType == Settings.Main.MouseKey and getgenv().Settings.Main.HoldKey == true and
                Settings.Main.UseMouseKey == true and
                getgenv().Settings.Main.Enable == true and
                AimlockTarget ~= nil
         then
            AimlockTarget = nil
            MousePressed = false
        end
    end
)
 
Uis.InputBegan:Connect(
    function(keyinput, stupid)
        if
            keyinput.UserInputType == Settings.Main.MouseKey and Settings.Main.UseMouseKey == true and
                getgenv().Settings.Main.Enable == true and
                AimlockTarget == nil and
                getgenv().Settings.Main.ToggleKey == true
         then
            pcall(
                function()
                    MousePressed = true
                    AimlockTarget = GetNearestTarget()
                end
            )
        elseif
            keyinput.UserInputType == Settings.Main.MouseKey and Settings.Main.UseMouseKey == true and
                getgenv().Settings.Main.Enable == true and
                AimlockTarget ~= nil
         then
            AimlockTarget = nil
            MousePressed = false
        end
    end
)
 
-- // Main Functions. RunService HeartBeat.
 
task.spawn(
    function()
        while task.wait() do
            if MousePressed == true and getgenv().Settings.Main.Enable == true then
                if AimlockTarget and AimlockTarget.Character then
                    if getgenv().Settings.Part.GetClosestPart == true then
                        getgenv().Settings.Part.AimPart = tostring(GetClosestBodyPart(AimlockTarget.Character))
                    end
                end
                if getgenv().Settings.Main.DisableOutSideCircle == true and AimlockTarget and AimlockTarget.Character then
                    if
                        Circle.Radius <
                            (Vec2(
                                Camera:WorldToScreenPoint(AimlockTarget.Character.HumanoidRootPart.Position).X,
                                Camera:WorldToScreenPoint(AimlockTarget.Character.HumanoidRootPart.Position).Y
                            ) - Vec2(Mouse.X, Mouse.Y)).Magnitude
                     then
                        AimlockTarget = nil
                    end
                end
            end
        end
    end
)
 
RService.Heartbeat:Connect(
    function()
        if getgenv().Settings.Main.Enable == true and MousePressed == true then
            if getgenv().Settings.Main.UseShake == true and AimlockTarget and AimlockTarget.Character then
                pcall(
                    function()
                        local TargetVelv1 = AimlockTarget.Character[getgenv().Settings.Part.AimPart]
                        TargetVelv1.Velocity =
                            Vec3(TargetVelv1.Velocity.X, TargetVelv1.Velocity.Y, TargetVelv1.Velocity.Z) +
                            Vec3(
                                math.random(-getgenv().Settings.Main.ShakePower, getgenv().Settings.Main.ShakePower),
                                math.random(-getgenv().Settings.Main.ShakePower, getgenv().Settings.Main.ShakePower),
                                math.random(-getgenv().Settings.Main.ShakePower, getgenv().Settings.Main.ShakePower)
                            ) *
                                0.1
                        TargetVelv1.AssemblyLinearVelocity =
                            Vec3(TargetVelv1.Velocity.X, TargetVelv1.Velocity.Y, TargetVelv1.Velocity.Z) +
                            Vec3(
                                math.random(-getgenv().Settings.Main.ShakePower, getgenv().Settings.Main.ShakePower),
                                math.random(-getgenv().Settings.Main.ShakePower, getgenv().Settings.Main.ShakePower),
                                math.random(-getgenv().Settings.Main.ShakePower, getgenv().Settings.Main.ShakePower)
                            ) *
                                0.1
                    end
                )
            end
            if getgenv().Settings.Resolver.UnderGround == true and AimlockTarget and AimlockTarget.Character then
                pcall(
                    function()
                        local TargetVelv2 = AimlockTarget.Character[getgenv().Settings.Part.AimPart]
                        TargetVelv2.Velocity = Vec3(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                        TargetVelv2.AssemblyLinearVelocity = Vec3(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                    end
                )
            end
            if
                getgenv().Settings.Resolver.DetectDesync == true and AimlockTarget and AimlockTarget.Character and
                    AimlockTarget.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude >
                        getgenv().Settings.Resolver.Detection
             then
                pcall(
                    function()
                        local TargetVel = AimlockTarget.Character[getgenv().Settings.Part.AimPart]
                        TargetVel.Velocity = Vec3(0, 0, 0)
                        TargetVel.AssemblyLinearVelocity = Vec3(0, 0, 0)
                    end
                )
            end
            if getgenv().Settings.Main.ThirdPerson == true and getgenv().Settings.Main.FirstPerson == true then
                if
                    (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or
                        (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1
                 then
                    CanNotify = true
                else
                    CanNotify = false
                end
            elseif getgenv().Settings.Main.ThirdPerson == true and getgenv().Settings.Main.FirstPerson == false then
                if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then
                    CanNotify = true
                else
                    CanNotify = false
                end
            elseif getgenv().Settings.Main.ThirdPerson == false and getgenv().Settings.Main.FirstPerson == true then
                if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then
                    CanNotify = true
                else
                    CanNotify = false
                end
            end
            if getgenv().Settings.Main.AutoPingSets == true and getgenv().Settings.Horizontal.PredictionVelocity then
                local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
                local split = string.split(pingvalue, "(")
                local ping = tonumber(split[1])
                if ping > 190 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.206547
                elseif ping > 180 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.19284
                elseif ping > 170 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.1923111
                elseif ping > 160 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.1823111
                elseif ping > 150 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.171
                elseif ping > 140 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.165773
                elseif ping > 130 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.1223333
                elseif ping > 120 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.143765
                elseif ping > 110 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.1455
                elseif ping > 100 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.130340
                elseif ping > 90 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.136
                elseif ping > 80 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.1347
                elseif ping > 70 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.119
                elseif ping > 60 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.12731
                elseif ping > 50 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.127668
                elseif ping > 40 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.125
                elseif ping > 30 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.11
                elseif ping > 20 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.12588
                elseif ping > 10 then
                    getgenv().Settings.Horizontal.PredictionVelocity = 0.9
                end
            end
            if getgenv().Settings.Check.CheckIfKo == true and AimlockTarget and AimlockTarget.Character then
                local KOd = AimlockTarget.Character:WaitForChild("BodyEffects")["K.O"].Value
                local Grabbed = AimlockTarget.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
                if AimlockTarget.Character.Humanoid.health < 1 or KOd or Grabbed then
                    if MousePressed == true then
                        AimlockTarget = nil
                        MousePressed = false
                    end
                end
            end
            if
                getgenv().Settings.Check.DisableOnTargetDeath == true and AimlockTarget and
                    AimlockTarget.Character:FindFirstChild("Humanoid")
             then
                if AimlockTarget.Character.Humanoid.health < 1 then
                    if MousePressed == true then
                        AimlockTarget = nil
                        MousePressed = false
                    end
                end
            end
            if
                getgenv().Settings.Check.DisableOnPlayerDeath == true and Client.Character and
                    Client.Character:FindFirstChild("Humanoid") and
                    Client.Character.Humanoid.health < 1
             then
                if MousePressed == true then
                    AimlockTarget = nil
                    MousePressed = false
                end
            end
            if getgenv().Settings.Part.CheckIfJumped == true and getgenv().Settings.Part.GetClosestPart == false then
                if AimlockTarget and AimlockTarget.Character then
                    if AimlockTarget.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                        getgenv().Settings.Part.AimPart = getgenv().Settings.Part.CheckIfJumpedAimPart
                    else
                        getgenv().Settings.Part.AimPart = OldAimPart
                    end
                end
            end
            if
                AimlockTarget and AimlockTarget.Character and
                    AimlockTarget.Character:FindFirstChild(getgenv().Settings.Part.AimPart)
             then
                if getgenv().Settings.Main.FirstPerson == true then
                    if CanNotify == true then
                        if getgenv().Settings.Horizontal.PredictMovement == true then
                            if getgenv().Settings.Smooth.Smoothness == true then
                                local Main =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Settings.Part.AimPart].Position +
                                        AimlockTarget.Character[getgenv().Settings.Part.AimPart].Velocity *
                                            getgenv().Settings.Horizontal.PredictionVelocity
                                )
 
                                Camera.CFrame =
                                    Camera.CFrame:Lerp(
                                    Main,
                                    getgenv().Settings.Smooth.SmoothnessAmount,
                                    Enum.EasingStyle.Elastic,
                                    Enum.EasingDirection.InOut
                                )
                            else
                                Camera.CFrame =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Settings.Part.AimPart].Position +
                                        AimlockTarget.Character[getgenv().Settings.Part.AimPart].Velocity *
                                            getgenv().Settings.Horizontal.PredictionVelocity + Vector3
                                )
                            end
                        elseif getgenv().Settings.Horizontal.PredictMovement == false then
                            if getgenv().Settings.Smooth.Smoothness == true then
                                local Main =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Settings.Part.AimPart].Position
                                )
                                Camera.CFrame =
                                    Camera.CFrame:Lerp(
                                    Main,
                                    getgenv().Settings.Smooth.SmoothnessAmount,
                                    getgenv().Settings.Smooth.SmoothMethod,
                                    getgenv().Settings.Smooth.SmoothMethodV2
                                )
                            else
                                Camera.CFrame =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Settings.Part.AimPart].Position
                                )
                            end
                        end
                    end
                end
            end
        end
    end
)


----------------------------------------------- END OF AIMBOT




---- START FOR ANTI AIM TAB

local FakeLagTab = Tabs.AntiAimTab:AddLeftGroupbox('Fake-Lag')

local FakeLag = false

FakeLagTab:AddToggle('MyToggle', {
    Text = 'FakeLag',
    Default = false, 
    Tooltip = 'Enable/Disable FakeLag',
    Callback = function(e)
        FakeLag = false
        getgenv().FakeLagSpeed = 0.000001
        if e then
            FakeLag = true
            while FakeLag == true do
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Anchored = true
                wait(getgenv().FakeLagSpeed)
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Anchored = false
                wait()
            end
        else
            FakeLag = false
        end
end
})


FakeLagTab:AddSlider('Size', {
    Text = 'Amount',
    Default = 1,  -- Length of the crosshair
    Min = 0,
    Max = 10,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        getgenv().FakeLagSpeed = Value / 10
    end
})





--- START FOR VISUALS TAB
local LeftGroupBox = Tabs.Visuals:AddLeftGroupbox('Main')
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Enable',
    Default = false, 
    Tooltip = 'ESP MasterKey',

    Callback = function(Value)
		Sense.teamSettings.enemy.enabled = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Name',
    Default = false, 
    Tooltip = 'Name', 

    Callback = function(Value)
		Sense.teamSettings.enemy.name = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Box',
    Default = false,
    Tooltip = 'Box', 

    Callback = function(Value)
		Sense.teamSettings.enemy.box = Value
        print('[cb] MyToggle changed to:', Value)
    end
})



LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Box Outline',
    Default = false,
    Tooltip = 'Box Outline', 

    Callback = function(Value)
		Sense.teamSettings.enemy.boxOutline = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Box Fill',
    Default = false, 
    Tooltip = 'Box Fill', 

    Callback = function(Value)
		Sense.teamSettings.enemy.boxFill = Value
        print('[cb] MyToggle changed to:', Value)
    end
})


LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Health Bar',
    Default = false, 
    Tooltip = 'Health Bar', 

    Callback = function(Value)
		Sense.teamSettings.enemy.healthBar = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Health Bar Outline',
    Default = false,
    Tooltip = 'Health Bar Outline', 

    Callback = function(Value)
		Sense.teamSettings.enemy.healthBarOutline = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Health Bar Text',
    Default = false, 
    Tooltip = 'Health Bar Text', 

    Callback = function(Value)
		Sense.teamSettings.enemy.healthText = Value
        print('[cb] MyToggle changed to:', Value)
    end
})


LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Distance',
    Default = false,
    Tooltip = 'Distance', 

    Callback = function(Value)
		Sense.teamSettings.enemy.distance = Value
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Tracers',
    Default = false, 
    Tooltip = 'Tracers', 
    Callback = function(Value)
		Sense.teamSettings.enemy.tracer = Value
        print('[cb] MyToggle changed to:', Value)
    end
})



------//// COLOR TAB
local TabBox = Tabs.Visuals:AddRightTabbox()
local Tab1 = TabBox:AddTab('Colors')
local Tab2 = TabBox:AddTab('Custom Crosshair')


Tab1:AddLabel('Name Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(1, 1, 1), 
    Title = 'Name Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.nameColor = { Value, 1 }
        print('[cb] Color changed!', Value)
    end
})

Tab1:AddLabel('Box Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(1, 1, 1), 
    Title = 'Box Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.boxColor[1] = Value
        print('[cb] Color changed!', Value)
    end
})

Tab1:AddLabel('Box Fill Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(1, 1, 1), -- White
    Title = 'Box Fill Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.boxFillColor = { Value, 0.5 }
        print('[cb] Color changed!', Value)
    end
})


Tab1:AddLabel('Tracer Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(1, 1, 1), -- White
    Title = 'Tracer Color', 
    Transparency = 0, 

    Callback = function(Value)
		Sense.teamSettings.enemy.tracerColor = { Value, 0.5 }
        print('[cb] Color changed!', Value)
    end
})




-- custom crosshair

Tab2:AddToggle('Enabled', {
    Text = 'Enabled',
    Default = crosshair_cfg.Visible,
    Callback = function(Value)
        crosshair_cfg.Visible = Value
        for _, set in ipairs(lineSets) do
            set.visible = Value
        end
    end
})

Tab2:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = crosshair_cfg.Color,
    Title = 'Crosshair Color',
    Transparency = 0,
    Callback = function(Value)
        crosshair_cfg.Color = Value
        extensionText.Color = Value
    end
})

Tab2:AddSlider('Size', {
    Text = 'Size',
    Default = crosshair_cfg.Size,  -- Length of the crosshair
    Min = 1,
    Max = 50,
    Rounding = 1,
    Compact = false,
    Callback = function(Value)
        crosshair_cfg.Size = Value
        -- Update the count of the lineSets according to the new size
        for _, set in ipairs(lineSets) do
            set.count = Value
        end
    end
})

Tab2:AddSlider('Thickness', {
    Text = 'Thickness',
    Default = crosshair_cfg.Thickness,
    Min = 0.1,
    Max = 10,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        crosshair_cfg.Thickness = Value
    end
})

Tab2:AddToggle('Spin', {
    Text = 'Spin',
    Default = crosshair_cfg.SpinAnimation,
    Callback = function(Value)
        crosshair_cfg.SpinAnimation = Value
    end
})

Tab2:AddSlider('Speed', {
    Text = 'Speed',
    Default = crosshair_cfg.SpinSpeed,
    Min = 0,
    Max = 10,
    Rounding = 2,
    Compact = false,
    Callback = function(Value)
        crosshair_cfg.SpinSpeed = Value
    end
})


local RecenterXHair = Tab2:AddButton({
    Text = 'Recenter Crosshair',
    Func = function()
        recenterCrosshair()
    end,
    DoubleClick = false,
    Tooltip = 'Recenter Crosshair'
})

---
local TabBox2 = Tabs.Visuals:AddRightTabbox()
local TTab1 = TabBox2:AddTab('Local Chams')
local TTab2 = TabBox2:AddTab('Enemy Chams')


TTab1:AddToggle('Enabled', {
    Text = 'Enable Chams',
    Default = crosshair_cfg.Visible,
    Callback = function(Value)
        LOCALCHAM.Chams.Enabled = Value
    end
})

TTab1:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.fromRGB(1, 1, 1),
    Title = 'Chams Color',
    Transparency = 0,
    Callback = function(Value)
        LOCALCHAM.Chams.Color = Value
    end
})

TTab1:AddToggle('Enabled', {
    Text = 'Rainbow Chams',
    Default = crosshair_cfg.Visible,
    Callback = function(Value)
        LOCALCHAM.Chams.Rainbow = Value
    end
})



local function toggleChams()
    LOCALCHAM.Chams.Enabled = not LOCALCHAM.Chams.Enabled
end

local function updateChams()
    while true do
        if LOCALCHAM.Chams.Enabled then
            for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    if LOCALCHAM.Chams.Rainbow then
                        local t = tick() * 6
                        local r = math.sin(t) * 0.5 + 0.5
                        local g = math.sin(t + 2 * math.pi / 3) * 0.5 + 0.5
                        local b = math.sin(t + 4 * math.pi / 3) * 0.5 + 0.5
                        part.Color = Color3.fromRGB(r * 255, g * 255, b * 255)
                    else
                        part.Color = LOCALCHAM.Chams.Color
                    end
                    part.Material = LOCALCHAM.Chams.Material
                end
            end
        else
            -- If chams are disabled, set material to Plastic and color to white
            for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Material = Enum.Material.Plastic
                    part.Color = Color3.new(1, 1, 1) -- White color
                end
            end
        end
        wait()
    end
end

-- Start the coroutine to update chams
spawn(updateChams)




---start of enemy chams

TTab2:AddToggle('Enabled', {
    Text = 'Enable Enemy Chams',
    Default = false,
    Callback = function(Value)
        Sense.teamSettings.enemy.chams = Value
    end
})

TTab2:AddToggle('Enabled', {
    Text = 'Enable Enemy Chams Visible Only',
    Default = false,
    Callback = function(Value)
        Sense.teamSettings.enemy.chamsVisibleOnly = Value
    end
})

TTab2:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.fromRGB(1, 0, 1),
    Title = 'Chams Enemy Outline Color',
    Transparency = 0,
    Callback = function(Value)
        Sense.teamSettings.enemy.chamsOutlineColor = { Value, 0 }
    end
})

TTab2:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.fromRGB(1, 0, 1),
    Title = 'Chams Enemy Fill Color',
    Transparency = 0,
    Callback = function(Value)
        Sense.teamSettings.enemy.chamsFillColor = { Value, 0.5 }
    end
})






local IndicatorsTab = Tabs.Visuals:AddLeftGroupbox('Indicators')

-- Add a toggle for the velocity indicator
IndicatorsTab:AddToggle('Velocity Indicator', {
    Text = 'Velocity Indicator',
    Default = false,
    Callback = function(Value)
        VelocityIndicator.Enabled = Value -- Update UI visibility
        if Value then
        spawn(updateInnerBar)
        spawn(checkHumanoid)
        end
    end
})

-- Add a toggle for the velocity indicator
IndicatorsTab:AddToggle('Velocity Indicator', {
    Text = 'Performance Indicator',
    Default = false,
    Callback = function(Value)
        PerFormanceIndi.Enabled = Value -- Update UI visibility
        if Value then
            spawn(updateBars)
        end
    end
})


-----//// world visual tab

local WorldVisTab = Tabs.Visuals:AddRightGroupbox('World')

WorldVisTab:AddLabel('World Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(1, 1, 1), 
    Title = 'World Color', 
    Transparency = 0, 

    Callback = function(Value)
		worldvis.WorldVisuals.MapTintColor = Value
        print('[cb] Color changed!', Value)
    end
})

WorldVisTab:AddSlider('MySlider', {
    Text = 'Saturation',
    Default = 1, -- Default to 50 instead of 1, as slider value is in percentage
    Min = 0,
    Max = 50, -- Max is set to 400 to match the 4x multiplier
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
        colorcorrection.Saturation = Value
        print('[cb] MySlider was changed! New value:', Value)
    end
})

WorldVisTab:AddSlider('MySlider', {
    Text = 'Brightness',
    Default = 1, -- Default to 50 instead of 1, as slider value is in percentage
    Min = 0,
    Max = 50, -- Max is set to 400 to match the 4x multiplier
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
        worldvis.WorldVisuals.MapBrightness = Value / 100
        print('[cb] MySlider was changed! New value:', Value)
    end
})

WorldVisTab:AddSlider('MySlider', {
    Text = 'Contrast',
    Default = 1, -- Default to 50 instead of 1, as slider value is in percentage
    Min = 0,
    Max = 50, -- Max is set to 400 to match the 4x multiplier
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
        worldvis.WorldVisuals.MapContrast = Value / 100
        print('[cb] MySlider was changed! New value:', Value)
    end
})


local player = game.Players.LocalPlayer
local flyEnabled = false
local flySpeed = 10
local playerSpeed = 16 -- Default Roblox player speed
local BodyGyro, BodyVelocity
local flyKey = Enum.KeyCode.C -- Default keybind for fly toggle




-- Function to start flying
local function startFly()
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    humanoid.PlatformStand = true
    repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local rootPart = player.Character.HumanoidRootPart
    BodyGyro = Instance.new("BodyGyro", rootPart)
    BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.CFrame = rootPart.CFrame
    BodyVelocity = Instance.new("BodyVelocity", rootPart)
    BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)

    while flyEnabled do
        wait()
        local camCFrame = workspace.CurrentCamera.CoordinateFrame
        local direction = Vector3.new(0, 0, 0)

        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            direction = direction + (camCFrame.lookVector * flySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            direction = direction - (camCFrame.lookVector * flySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            direction = direction - (camCFrame.rightVector * flySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            direction = direction + (camCFrame.rightVector * flySpeed)
        end
        BodyVelocity.Velocity = direction
        BodyGyro.CFrame = camCFrame
    end
end

-- Function to stop flying
local function stopFly()
    if BodyGyro then BodyGyro:Destroy() end
    if BodyVelocity then BodyVelocity:Destroy() end
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character.Humanoid.PlatformStand = false
    end
end

-- Function to handle key input for toggling fly
local function handleFlyToggleInput(input)
    if input.KeyCode == flyKey then
        flyEnabled = not flyEnabled
        if flyEnabled then
            startFly() -- Start flying
        else
            stopFly() -- Stop flying
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(handleFlyToggleInput)



getgenv().CFSpeed = false


-- GUI Setup
local MovementTab = Tabs.Movement:AddLeftGroupbox('Modifiers')

-- Speed Control Toggle
MovementTab:AddToggle('SpeedToggle', {
    Text = 'Enable Custom Speed',
    Default = false,
    Tooltip = 'Toggle custom speed control',
    Callback = function(value)
        ZekeHubSpeed.CframeSpeed.Enabled = value
    end  -- Pass the function directly as the callback
})

-- Speed Slider
MovementTab:AddSlider('SpeedSlider', {
    Text = 'Speed Value',
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,
    Callback = function(value)
        ZekeHubSpeed.CframeSpeed.Speed = value / 10
    end
})


MovementTab:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'Z', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'CFrame Speed Keybind', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function(Value)
        print('[cb] Keybind clicked!', Value)
    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New) 
        ZekeHubSpeed.CframeSpeed.Keybind = New
        print('[cb] Keybind changed!', New)
    end
})


game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end
	if Key.KeyCode == ZekeHubSpeed.CframeSpeed.Keybind and ZekeHubSpeed.CframeSpeed.Enabled == true then
		getgenv().CFSpeed = not getgenv().CFSpeed
	end
end)
game:GetService("RunService").Heartbeat:Connect(function()
if getgenv().CFSpeed then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * ZekeHubSpeed.CframeSpeed.Speed
end -- cfspeed
end)
    

MovementTab:AddToggle('FlyToggle', {
    Text = 'Enable Fly',
    Default = false,
    Tooltip = 'Enable Fly Modifier',
    Callback = function(value)
        flyEnabled = value
        if flyEnabled == false then
            value = false
        end
        if flyEnabled then
            startFly()
        else
            stopFly()
        end
    end
})

MovementTab:AddSlider('FlySlider', {
    Text = 'Fly Value',
    Default = 10,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Compact = true,
    Callback = function(value)
        flySpeed = value * 10
        if flyEnabled then
            -- Update fly speed in real time if already flying
            BodyVelocity.Velocity = BodyVelocity.Velocity.unit * flySpeed
        end
    end
})

MovementTab:AddLabel('Keybind'):AddKeyPicker('FlyToggleKeyPicker', {
    Default = flyKey.Name,
    SyncToggleState = false,
    Mode = 'Toggle',
    Text = 'Fly Toggle Keybind',
    NoUI = false,
    Callback = function(value)
        flyKey = Enum.KeyCode[value]
    end,
    ChangedCallback = function(newKey)
        flyKey = Enum.KeyCode[newKey]
    end
})



-- Add groupbox for player list
local playerlist = Tabs.PlayerlistTab:AddLeftGroupbox('Player Information')

getgenv().SelectedTargetUser = "" -- Initialize the variable to store the selected player

-- Add the dropdown for player selection
local playerDropdown = playerlist:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'Select Player',
    Tooltip = 'Select a player from the list',
    Default = 1,
    Multi = false,
    Callback = function(Value)
        getgenv().SelectedTargetUser = Value -- Update the global variable with the selected player
    end
})

-- Function to get player by name
local function GetPlayerByName(playerName)
    return Players:FindFirstChild(playerName)
end

-- Function to update position label with target player's position
local function UpdatePositionLabel(player)
    local positionLabel = playerlist:GetLabelByIndex(#playerlist:GetChildren()) -- Get the last label
    if positionLabel then
        if player then
            local character = player.Character
            if character then
                local primaryPart = character.PrimaryPart
                if primaryPart then
                    positionLabel:SetText(('Position:\nX: %s\nY: %s\nZ: %s'):format(
                        tostring(primaryPart.Position.X),
                        tostring(primaryPart.Position.Y),
                        tostring(primaryPart.Position.Z)
                    ))
                    return
                end
            end
        end
        -- If player or their character is not found, display N/A
        positionLabel:SetText('Position:\nX: N/A\nY: N/A\nZ: N/A')
    end
end

-- Function for teleporting to the targeted player
local function TeleportToPlayer()
    local playerName = getgenv().SelectedTargetUser
    if playerName and playerName ~= "" then
        local player = GetPlayerByName(playerName)
        if player then
            local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
            local humanoid = game.Players.LocalPlayer.Character.Humanoid
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.1)
            pl.CFrame = player.Character.HumanoidRootPart.CFrame
            UpdatePositionLabel(player) -- Update position label
        else
            print("Player not found:", playerName)
        end
    else
        print("No player selected for teleportation.")
    end
end

-- Function for spectating the targeted player
local function SpectatePlayer()
    local playerName = getgenv().SelectedTargetUser
    if playerName and playerName ~= "" then
        local player = GetPlayerByName(playerName)
        if player then
            if not getgenv().spectating then
                -- Set the flag to indicate that we're spectating
                getgenv().spectating = true
                
                -- Store the original camera CFrame
                getgenv().originalCameraCFrame = game.Workspace.CurrentCamera.CFrame
                
                -- Set the camera to focus on the player
                game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            else
                -- Set the flag to indicate that we're no longer spectating
                getgenv().spectating = false
                
                -- Restore the original camera CFrame
                game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            end
            UpdatePositionLabel(player) -- Update position label
        else
            print('Player not found:', playerName)
        end
    else
        print("No player selected for spectating.")
    end
end

-- Variable to track if the player is currently being flung
local isFlinging = false
local Loop
-- Function to start flinging
local function StartFlinging()
    local OldFlingPos = player.Character.HumanoidRootPart.Position
    local Loop
    Loop = game:GetService("RunService").Heartbeat:Connect(function()
        local success, err = pcall(function()
            local FlingEnemy = Players:FindFirstChild(getgenv().SelectedTargetUser)
            if FlingEnemy and player.Character then
                local FlingTorso = FlingEnemy.Character:FindFirstChild("UpperTorso")
                if FlingTorso then
                    local dis = 3.85
                    local increase = 6
                    local xchange, zchange = 0, 0
                    if FlingEnemy.Character.Humanoid.MoveDirection.X < 0 then
                        xchange = -increase
                    elseif FlingEnemy.Character.Humanoid.MoveDirection.X > 0 then
                        xchange = increase
                    end
                    if FlingEnemy.Character.Humanoid.MoveDirection.Z < 0 then
                        zchange = -increase
                    elseif FlingEnemy.Character.Humanoid.MoveDirection.Z > 0 then
                        zchange = increase
                    end
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(FlingTorso.Position.X + math.random(-dis, dis) + xchange, FlingTorso.Position.Y, FlingTorso.Position.Z + math.random(-dis, dis) + zchange) * CFrame.Angles(math.rad(player.Character.HumanoidRootPart.Orientation.X + 350), math.rad(player.Character.HumanoidRootPart.Orientation.Y + 200), math.rad(player.Character.HumanoidRootPart.Orientation.Z + 240))
                    player.Character.HumanoidRootPart.Velocity = Vector3.new(500000, 500000, 500000)
                end
            end
        end)
        if err then
            print('fling error : ' .. err)
        end
    end)
    getgenv().isFlinging = true
    getgenv().flingLoop = Loop
end

-- Function to stop flinging
local function StopFlinging()
    if getgenv().flingLoop then
        getgenv().flingLoop:Disconnect()
    end
    local vectorZero = Vector3.new(0, 0, 0)
    player.Character.PrimaryPart.Velocity = vectorZero
    player.Character.PrimaryPart.RotVelocity = vectorZero
    getgenv().isFlinging = false
end

-- Function to toggle between flinging and unflinging
local function ToggleFling()
    if getgenv().isFlinging then
        -- If already flinging, stop the fling
        StopFlinging()
    else
        -- If not flinging, start the fling
        StartFlinging()
    end
end




-- Add buttons for actions
playerlist:AddButton({
    Text = 'Teleport',
    DoubleClick = false,
    Tooltip = 'Teleport to the selected player',
    Func = TeleportToPlayer
})

playerlist:AddButton({
    Text = 'Spectate',
    DoubleClick = false,
    Tooltip = 'Spectate the selected player',
    Func = SpectatePlayer
})

playerlist:AddButton({
    Text = 'Fling',
    DoubleClick = false,
    Tooltip = 'Fling the selected player',
    Func = ToggleFling -- Assign the ToggleFling function as the Func parameter
})




-- Add labels for player information
playerlist:AddLabel(' ')
local positionLabel = playerlist:AddLabel('Position:\nX: N/A\nY: N/A\nZ: N/A')
playerlist:AddLabel(' ')

-- Function to get player by name
local function GetPlayerByName(playerName)
    return Players:FindFirstChild(playerName)
end

-- Function to update position label with target player's position
local function UpdatePositionLabel(player)
    if player then
        local character = player.Character
        if character then
            local primaryPart = character.PrimaryPart
            if primaryPart then
                positionLabel:SetText(('Position:\nX: %s\nY: %s\nZ: %s'):format(
                    tostring(primaryPart.Position.X),
                    tostring(primaryPart.Position.Y),
                    tostring(primaryPart.Position.Z)
                ))
                return
            end
        end
    end
    -- If player or their character is not found, display N/A
    positionLabel:SetText('Position:\nX: N/A\nY: N/A\nZ: N/A')
end

-- Function to update position label periodically
local function UpdatePositionLabelPeriodically()
    while true do
        local playerName = getgenv().SelectedTargetUser
        local player = GetPlayerByName(playerName)
        if player then
            UpdatePositionLabel(player) -- Update position label for the specified player
        else
            -- If player is not found, clear position label
            positionLabel:SetText('Position:\nX: N/A\nY: N/A\nZ: N/A')
        end
        task.wait() -- Wait for 1.5 seconds before checking again
    end
end

coroutine.wrap(UpdatePositionLabelPeriodically)()




local extraTab = Tabs.ExtraTab:AddLeftGroupbox("Teleports")

extraTab:AddButton({
    Text = 'Revolver',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-665.529846, 50.0065956, -141.750793, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Rev'
})

extraTab:AddButton({
    Text = 'Revolver Mountain',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-696.847717, 167.674957, -41.0118256, 0.626992583, 7.53169349e-09, -0.779025197, -1.29610933e-09, 1, 8.62493632e-09, 0.779025197, -4.39806902e-09, 0.626992583)    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Rev Mountain'
})

extraTab:AddButton({
    Text = 'Bank Roof',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-428.754517, 39.3525352, -284.244873, -1.13248825e-05, 0.660138607, 0.751143754, 4.29153442e-06, 0.751143813, -0.660138607, -0.99999994, -4.29153442e-06, -1.13248825e-05)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Rev Bank Roof'
})
extraTab:AddButton({
    Text = 'LMG',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-620.882263, 20.2999878, -305.339264, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to LMG'
})
extraTab:AddButton({
    Text = 'RPG',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.815933, -22.9016266, -136.737762, 0.0339428484, -7.90177737e-08, 0.999423802, -4.7851227e-08, 1, 8.06884728e-08, -0.999423802, -5.0562452e-08, 0.0339428484)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to RPG'
})

extraTab:AddButton({
    Text = 'Drum Guns',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1177.78003, 25.5800095, -530.259949, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Drum Guns'
})

extraTab:AddButton({
    Text = 'Down Hill Guns',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-584.377258, 18.3279209, -724.957031, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to DownHill Guns'
})
extraTab:AddButton({
    Text = 'Up Hill Guns',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(470.412354, 58.0836449, -626.227051, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Uphill Guns'
})
extraTab:AddButton({
    Text = 'Military',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(36.6331787, 27.1796074, -824.074402, -0.984812617, 0, -0.173621148, 0, 1, 0, 0.173621148, 0, -0.984812617)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to DownHill Guns'
})
extraTab:AddButton({
    Text = 'Up Hill Taco Roof',
    Func = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(590.725708, 75.1874542, -513.107605, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    end,
    DoubleClick = false,
    Tooltip = 'Teleport to Uphill Guns'
})


local extraTab2 = Tabs.ExtraTab:AddRightGroupbox("Shop")


extraTab2:AddDropdown('MyDropdown', {
    Values = { "None", "Revolver", "DB", "AK-47", "LMG", "DrumGun", "Drum-Shotgu", "RPG", "Flamethrower", "Taser" },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Guns',
    Tooltip = 'AutoBuy Weapon Of your Choice', -- Information shown when you hover over the dropdown

    Callback = function(State)
        if State == "Revolver" then
            plr = game:GetService "Players".LocalPlayer
            local gunName = "[Revolver] - $1379"
            local k = game.Workspace.Ignored.Shop[gunName]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop[gunName].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop[gunName].ClickDetector)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "DB" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[Double-Barrel SG] - $1485"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[Double-Barrel SG] - $1485"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[Double-Barrel SG] - $1485"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "AK-47" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[AK47] - $2387"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[AK47] - $2387"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[AK47] - $2387"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "LMG" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[LMG] - $3978"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[LMG] - $3978"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[LMG] - $3978"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "DrumGun" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[DrumGun] - $3183"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[DrumGun] - $3183"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[DrumGun] - $3183"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "Drum-Shotgun" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[Drum-Shotgun] - $1167"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[Drum-Shotgun] - $1167"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[Drum-Shotgun] - $1167"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "RPG" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[RPG] - $21218"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[RPG] - $21218"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[RPG] - $21218"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "Flamethrower" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[Flamethrower] - $15914"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[Flamethrower] - $15914"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[Flamethrower] - $15914"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        elseif State == "Taser" then
            plr = game:GetService "Players".LocalPlayer
            local k = game.Workspace.Ignored.Shop["[Taser] - $1061"]
            local savedsilencerpos = plr.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = k.Head.CFrame + Vector3.new(0, 3, 0)
            wait(0.5)
            fireclickdetector(game.Workspace.Ignored.Shop["[Taser] - $1061"].ClickDetector)
            fireclickdetector(game.Workspace.Ignored.Shop["[Taser] - $1061"].ClickDetector)

            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedsilencerpos)
        end
    end
})


local selectedAmmo = "Revolver" -- Default selected ammo

local function OnDropdownChanged(value)
    selectedAmmo = value
end

local function BuyAmmo()
    if selectedAmmo then
        local plr = game:GetService("Players").LocalPlayer
        local ammoShop = game.Workspace.Ignored.Shop
        local ammoName = ""

        -- Determine the ammo name based on the selected type
        if selectedAmmo == "Revolver Ammo" then
            ammoName = "12 [Revolver Ammo] - $80"
        elseif selectedAmmo == "DB Ammo" then
            ammoName = "18 [Double-Barrel SG Ammo] - $53"
        elseif selectedAmmo == "AK-47 Ammo" then
            ammoName = "90 [AK47 Ammo] - $85"
        elseif selectedAmmo == "LMG Ammo" then
            ammoName = "200 [LMG Ammo] - $318"
        elseif selectedAmmo == "DrumGun Ammo" then
            ammoName = "100 [DrumGun Ammo] - $212"
        elseif selectedAmmo == "Drum-Shotgun Ammo" then
            ammoName = "18 [Drum-Shotgun Ammo] - $69"
        elseif selectedAmmo == "RPG Ammo" then
            ammoName = "5 [RPG Ammo] - $1061"
        elseif selectedAmmo == "Flamethrower Ammo" then
            ammoName = "140 [Flamethrower Ammo] - $1644"
        end

        if ammoName ~= "" then
            local ammoClickDetector = ammoShop[ammoName].ClickDetector
            if ammoClickDetector then
                -- Save the original position before teleporting
                local savedPosition = plr.Character.HumanoidRootPart.Position

                -- Teleport to the ammo shop and buy the selected ammo
                plr.Character.HumanoidRootPart.CFrame = ammoShop[ammoName].Head.CFrame + Vector3.new(0, 3, 0)
                wait(0.5)
                fireclickdetector(ammoClickDetector)
                fireclickdetector(ammoClickDetector)

                -- Restore the original position after buying ammo
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
            else
                print("ClickDetector for ammo not found.")
            end
        else
            print("Invalid ammo selection.")
        end
    else
        print("No ammo selected.")
    end
end

extraTab2:AddDropdown('MyDropdown', {
    Values = { "Revolver Ammo", "DB Ammo", "AK-47 Ammo", "LMG Ammo", "DrumGun Ammo", "Drum-Shotgun Ammo", "RPG Ammo", "Flamethrower Ammo" },
    Default = 1,
    Multi = false,
    Text = 'Ammo',
    Tooltip = 'AutoBuy Ammo Of your Choice',
    Callback = OnDropdownChanged -- Call the function when the dropdown value changes
})

extraTab2:AddButton({
    Text = 'Buy Ammo',
    DoubleClick = false,
    Tooltip = 'Buy Selected Ammo',
    Func = BuyAmmo
})


local selectedFood = "HotDog" -- Default selected food

local function OnDropdownChanged(value)
    selectedFood = value
end

local function BuyFood()
    if selectedFood then
        local plr = game:GetService("Players").LocalPlayer
        local foodShop = game.Workspace.Ignored.Shop

        local foodName = ""
        -- Determine the food name based on the selected type
        if selectedFood == "HotDog" then
            foodName = "[HotDog] - $8"
        elseif selectedFood == "Meat" then
            foodName = "[Meat] - $13"
        elseif selectedFood == "Popcorn" then
            foodName = "[Popcorn] - $7"
        elseif selectedFood == "Pizza" then
            foodName = "[Pizza] - $10"
        elseif selectedFood == "Taco" then
            foodName = "[Taco] - $2"
        else
            print("Invalid food selection.")
            return
        end

        if foodName ~= "" then
            local foodClickDetector = foodShop[foodName].ClickDetector
            if foodClickDetector then
                -- Save the original position before teleporting
                local savedPosition = plr.Character.HumanoidRootPart.Position

                -- Teleport to the food shop and buy the selected food
                plr.Character.HumanoidRootPart.CFrame = foodShop[foodName].Head.CFrame + Vector3.new(0, 3, 0)
                wait(0.5)
                fireclickdetector(foodClickDetector)
                fireclickdetector(foodClickDetector)

                -- Restore the original position after buying food
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
            else
                print("ClickDetector for food not found.")
            end
        else
            print("Invalid food selection.")
        end
    else
        print("No food selected.")
    end
end

extraTab2:AddDropdown('MyDropdown', {
    Values = { "HotDog", "Meat", "Popcorn", "Pizza", "Taco" },
    Default = 1,
    Multi = false,
    Text = 'Food',
    Tooltip = 'Auto Buy Food Of Your Choice',
    Callback = OnDropdownChanged -- Call the function when the dropdown value changes
})

extraTab2:AddButton({
    Text = 'Buy Food',
    DoubleClick = false,
    Tooltip = 'Buy Selected Food',
    Func = BuyFood
})

local selectedDrink = "[Starblox Latte] - $5" -- Default selected drink

local function OnDropdownChanged(value)
    selectedDrink = value
end

local function BuyDrink()
    if selectedDrink then
        local plr = game:GetService("Players").LocalPlayer
        local drinkShop = game.Workspace.Ignored.Shop

        local drinkName = ""

        -- Determine the drink name based on the selected type
        if selectedDrink == "[Starblox Latte] - $5" then
            drinkName = "[Starblox Latte] - $5"
        elseif selectedDrink == "[CranBerry] - $3" then
            drinkName = drinkShop:GetChildren()[130].Name
        elseif selectedDrink == "[Da Milk] - $7" then
            drinkName = "[Da Milk] - $7"
        end

        if drinkName ~= "" then
            local drinkClickDetector = drinkShop[drinkName].ClickDetector
            if drinkClickDetector then
                -- Save the original position before teleporting
                local savedPosition = plr.Character.HumanoidRootPart.Position

                -- Teleport to the drink shop and buy the selected drink
                plr.Character.HumanoidRootPart.CFrame = drinkShop[drinkName].Head.CFrame + Vector3.new(0, 3, 0)
                wait(0.5)
                fireclickdetector(drinkClickDetector)
                fireclickdetector(drinkClickDetector)

                -- Restore the original position after buying the drink
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
            else
                print("ClickDetector for drink not found.")
            end
        else
            print("Invalid drink selection.")
        end
    else
        print("No drink selected.")
    end
end

extraTab2:AddDropdown('MyDropdown', {
    Values = { "[Starblox Latte] - $5", "[CranBerry] - $3", "[Da Milk] - $7" },
    Default = 1,
    Multi = false,
    Text = 'Drink',
    Tooltip = 'Auto Buy Drink Of your Choice',
    Callback = OnDropdownChanged -- Call the function when the dropdown value changes
})

extraTab2:AddButton({
    Text = 'Buy Drink',
    DoubleClick = false,
    Tooltip = 'Buy Selected Drink',
    Func = BuyDrink
})




local extraTab3 = Tabs.ExtraTab:AddLeftGroupbox("Automations")
getgenv().autoStompEnabled = false
getgenv().autoArmorEnabled = false
getgenv().autoFireArmorEnabled = false
getgenv().autoPickupCashEnabled = false

-- cashier farm
local autoFarming = false
local humanoid = game.Players.LocalPlayer.Character.Humanoid
local tool = game.Players.LocalPlayer.Backpack.Combat
local function getMoneyAroundMe() 
    wait(0.5)
    for i, money in ipairs(game.Workspace.Ignored.Drop:GetChildren()) do
        if money.Name == "MoneyDrop" and (money.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 20 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = money.CFrame
            fireclickdetector(money.ClickDetector)
            wait(0.5)
        end  
    end
end

local function startAutoFarm() 
    while autoFarming do
        humanoid:EquipTool(tool)
        for i, v in ipairs(game.Workspace.Cashiers:GetChildren()) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Open.CFrame * CFrame.new(0, 0, 2)
            for i = 0, 15 do
                wait(0.5)
                tool:Activate()
            end
            getMoneyAroundMe()
        end
        wait(0.5)
    end
end
-- end of cashier farm



local function runAutoStomp()
    coroutine.wrap(function()
        while getgenv().autoStompEnabled do
            game.ReplicatedStorage.MainEvent:FireServer("Stomp")
            wait(0.1)
        end
    end)()
end

local function runAutoArmor()
    coroutine.wrap(function()
        while getgenv().autoArmorEnabled do
             local armorValue = workspace.Players[game.Players.LocalPlayer.Name].BodyEffects.Armor.Value
            if armorValue <= 0 then
                local plr = game.Players.LocalPlayer
                local armorShop = workspace.Ignored.Shop
                local armorClickDetector = armorShop["[High-Medium Armor] - $2440"].ClickDetector

                if armorClickDetector then
                    local savedPosition = plr.Character.HumanoidRootPart.Position
                    plr.Character.HumanoidRootPart.CFrame = armorShop["[High-Medium Armor] - $2440"].Head.CFrame + Vector3.new(0, 3, 0)
                    wait(0.5)
                    fireclickdetector(armorClickDetector)
                    fireclickdetector(armorClickDetector)
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                end
            end
            wait(0.1)
        end
    end)()
end

local function runAutoFireArmor()
    coroutine.wrap(function()
        while getgenv().autoFireArmorEnabled do
            local fireArmorValue = workspace.Players[game.Players.LocalPlayer.Name].BodyEffects.FireArmor.Value
            if fireArmorValue <= 0 then
                local plr = game.Players.LocalPlayer
                local armorShop = workspace.Ignored.Shop
                local armorClickDetector = armorShop["[Fire Armor] - $2546"].ClickDetector

                if armorClickDetector then
                    local savedPosition = plr.Character.HumanoidRootPart.Position
                    plr.Character.HumanoidRootPart.CFrame = armorShop["[Fire Armor] - $2546"].Head.CFrame + Vector3.new(0, 3, 0)
                    wait(0.5)
                    fireclickdetector(armorClickDetector)
                    fireclickdetector(armorClickDetector)
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(savedPosition)
                end
            end
            wait(0.1)
            wait(0.1)
        end
    end)()
end

local function runAutoPickupCash()
    coroutine.wrap(function()
        while getgenv().autoPickupCashEnabled do
            for _, v in pairs(workspace.Ignored.Drop:GetChildren()) do
                if v.Name == "MoneyDrop" and (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 25 then
                    fireclickdetector(v.ClickDetector)
                end
            end
            wait(0.1)
        end
    end)()
end



extraTab3:AddToggle('ToggleAutoStomp', {
    Text = 'Auto Stomp',
    Default = false,
    Callback = function(value)
        getgenv().autoStompEnabled = value
        if value then runAutoStomp() end
    end
})

extraTab3:AddToggle('ToggleAutoArmor', {
    Text = 'Auto Armor',
    Default = false,
    Callback = function(value)
        getgenv().autoArmorEnabled = value
        if value then runAutoArmor() end
    end
})

extraTab3:AddToggle('ToggleAutoFireArmor', {
    Text = 'Auto Fire Armor',
    Default = false,
    Callback = function(value)
        getgenv().autoFireArmorEnabled = value
        if value then runAutoFireArmor() end
    end
})

extraTab3:AddToggle('ToggleAutoPickupCash', {
    Text = 'Auto Pickup Cash',
    Default = false,
    Callback = function(value)
        getgenv().autoPickupCashEnabled = value
        if value then runAutoPickupCash() end
    end
})


extraTab3:AddButton({
    Text = 'ATM/Cashier AutoFarm',
    Func = startAutoFarm,
    Tooltip = 'NOTE: YOU CANNOT STOP THE AUTOFARM AFTERWARDS'
})



extraTab3:AddToggle('ToggleAutoPickupCash', {
    Text = 'Auto Farm Hospital',
    Default = false,
    Callback = function(value)
        local function TeleportPlayerToPart()
            local player = game.Players.LocalPlayer
            local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local targetPart = workspace.MAP.Map.Hospital.Model.Hospital:GetChildren()[91]

            if humanoidRootPart and targetPart then
                humanoidRootPart.CFrame = targetPart.CFrame
            else
                print("Failed to teleport: Player or target part not found.")
            end
        end

        if value then
            TeleportPlayerToPart()
            -- Continuously check and interact with NPCs while the toggle is on
            while value do
                task.wait(1) -- Wait for 1 second before rechecking
                for _, npcModel in pairs(workspace.Ignored.HospitalJob:GetChildren()) do
                    if npcModel:IsA("Model") then
                        local npcName = npcModel.Name
                        local color = npcName:match("(%a+)%s+bottle$") -- Extract color from NPC's name

                        local clickDetectorToFire = nil

                        if color == "Green" then
                            clickDetectorToFire = workspace.Ignored.HospitalJob.Green.ClickDetector
                        elseif color == "Blue" then
                            clickDetectorToFire = workspace.Ignored.HospitalJob.Blue.ClickDetector
                        elseif color == "Red" then
                            clickDetectorToFire = workspace.Ignored.HospitalJob.Red.ClickDetector
                        else
                            -- Handle the case where the color doesn't match the expected pattern
                            print("Color does not match the expected pattern.")
                        end

                        if clickDetectorToFire then
                            fireclickdetector(clickDetectorToFire) -- Fire the appropriate ClickDetector
                            fireclickdetector(npcModel.ClickDetector) -- Fire the NPC's ClickDetector
                        end
                    end
                end
            end
        end
    end
})




local extraTab4 = Tabs.ExtraTab:AddRightGroupbox("Exploits")


extraTab4:AddToggle('NoclipToggle', {
    Text = 'Kick on Mod Join',
    Default = false,
    Callback = function(value)
        if value then
        for l, c in pairs(game.Players:GetChildren()) do
            for i, v in pairs(dickface) do
            if c.UserId == v then
            local Vanis = game.Players.LocalPlayer
            Vanis:Kick("Retard Detected")
            end
            end
            end
            game.Players.PlayerAdded:Connect(function(plr)
            for i, v in pairs(dickface) do
            if plr.UserId == v then
            local Vanis = game.Players.LocalPlayer
            Vanis:Kick("Retard Detected")
            end
            end
            end)
        end
        
    end
})

extraTab4:AddToggle('MyToggle', {
    Text = 'Anti-AFK',
    Default = false,
    Tooltip = 'Enable or disable anti-AFK',

    Callback = function(Value)
        AntiAfkToggle = Value
        if AntiAfkToggle then
            enableAntiAFK()
            print('Anti-AFK Enabled')
        else
            disableAntiAFK()
            print('Anti-AFK Disabled')
        end
    end
})



extraTab4:AddToggle('MyToggle', {
    Text = 'Anti-Slowdown',
    Default = false,
    Tooltip = 'Enable/Disable Anti-Slow',

    Callback = function(Value)
        SlowSettings.AntiSlowEnabled = Value
    end
})




extraTab4:AddToggle('MyToggle', {
    Text = 'Infinite Stamina',
    Default = false,
    Tooltip = 'Enable/Disable No Jump Cooldown',

    Callback = function(Value)
        monkeyNJC.RemoveJumpCooldown = Value
    end
})

extraTab4:AddToggle('MyToggle', {
    Text = 'Anti-Stomp',
    Default = false,
    Tooltip = 'Enable/Disable No Jump Cooldown',

    Callback = function(Value)
        while Value do
            task.wait()
            if player.Character.BodyEffects['K.O'].Value == true then player.Character:Destroy() end
        end
    end
})


local player = game.Players.LocalPlayer
local noclipEnabled = false

-- Function to apply the noclip state
local function ApplyNoclip()
    if player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA('BasePart') then
                part.CanCollide = not noclipEnabled
            end
        end
    end
end

-- Function to toggle noclip
local function ToggleNoclip(value)
    noclipEnabled = value
    ApplyNoclip()
end

-- Continuous check to maintain the noclip state
game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled then
        ApplyNoclip()
    end
end)

-- GUI toggle setup
extraTab4:AddToggle('NoclipToggle', {
    Text = 'Noclip',
    Default = false,
    Callback = function(value)
        ToggleNoclip(value)
    end
})



----- booting anti SLOW
local function toggleAntiSlow()
    SlowSettings.AntiSlowEnabled = not SlowSettings.AntiSlowEnabled
end

local function handleAntiSlow()
    local deletePart = game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('NoJumping') or
                      game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('ReduceWalk') or
                      game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('NoWalkSpeed')
    if deletePart then
        deletePart:Destroy()
    end
    if game.Players.LocalPlayer.Character.BodyEffects.Reload.Value == true then
        game.Players.LocalPlayer.Character.BodyEffects.Reload.Value = false
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if SlowSettings.AntiSlowEnabled then
        handleAntiSlow()
    end
end)





local extraTab5= Tabs.ExtraTab:AddLeftGroupbox("Server")


-- Rejoin Button
extraTab5:AddButton({
    Text = 'Rejoin',
    Func = function()
        local placeId = game.PlaceId
        local playerId = game.Players.LocalPlayer.UserId
        -- Attempt to teleport the player to the same game
        game:GetService("TeleportService"):Teleport(placeId, game.Players.LocalPlayer)
        print('Attempting to rejoin...')
    end,
    Tooltip = 'Click to rejoin the current game'
})

-- Server Hop Button (Standard)
extraTab5:AddButton({
    Text = 'Server Hop',
    Func = function()
        -- This is a naive server hop implementation
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        print('Attempting to server hop...')
    end,
    Tooltip = 'Click to attempt to join a different server'
})

-- Server Hop to Lowest Server Button
extraTab5:AddButton({
    Text = 'Server Hop to Lowest',
    Func = function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        
        local _place = game.PlaceId
        local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"
        local function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
            return Http:JSONDecode(Raw)
        end
        
        local Server, Next; repeat
            local Servers = ListServers(Next)
            Server = Servers.data[1]
            Next = Servers.nextPageCursor
        until Server
        
        if Server then
            TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
            print('Attempting to hop to the lowest server...')
        else
            print('No server found to hop to.')
        end
    end,
    Tooltip = 'Click to hop to the server with the lowest player count'
})



local extraTab6 = Tabs.ExtraTab:AddRightGroupbox("Other")

local TrashTalk = false
local TrashTalkConnection

extraTab6:AddToggle('MyToggle', {
    Text = 'Trash Talk',
    Default = false,
    Tooltip = 'Enable/Disable No Jump Cooldown',

    Callback = function(Value)
        TrashTalk = Value
        
        -- If TrashTalk is enabled, start trash-talking in a separate coroutine
        if TrashTalk then
            -- If there's already a connection, disconnect it to avoid multiple connections
            if TrashTalkConnection then
                TrashTalkConnection:Disconnect()
            end
            
            -- Start a new coroutine for trash-talking
            TrashTalkConnection = coroutine.create(function()
                while TrashTalk do
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "ZEKEHUB RUNS YOU",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "ZEKEHUB VS THE WORLD",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "You just got Slammed by ZekeHub",
                        "All"
                    )
                    wait(0.6)
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        "ZekeHub > You",
                        "All"
                    )
                end
            end)
            
            -- Resume the coroutine
            coroutine.resume(TrashTalkConnection)
        else
            -- If TrashTalk is disabled, disconnect the connection if it exists
            if TrashTalkConnection then
                TrashTalkConnection:Disconnect()
            end
        end
    end
})


extraTab6:AddToggle('MyToggle', {
    Text = 'Remove Effects',
    Default = false,
    Tooltip = 'Enable/Disable Effects',

    Callback = function(Value)
        if Value then
            player.PlayerGui.Framework.FBAnimation.Name = 'yea'
            local Loop
            local loopFunction = function()
                local Particle = player.Character.UpperTorso:FindFirstChild('ElectricuteParticle') or player.Character.UpperTorso:FindFirstChild('FlamethrowerFireParticle')
                if Particle then Particle:Destroy() end
                for i,v in pairs(player.Character:FindFirstChildWhichIsA('Humanoid'):GetPlayingAnimationTracks()) do
                    if v.Animation.AnimationId == 'rbxassetid://5641749824' then
                    v:Stop() 
                    end
                end
            end;
            local Start = function()
                Loop = game:GetService("RunService").Heartbeat:Connect(loopFunction);
            end;
            local Pause = function()
                Loop:Disconnect()
            end;
            Start()	
            repeat wait() until Value == false
            Pause()
        end
    end
})



-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)
local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('Zeke Hub | build : dahood rewrite | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library.KeybindFrame.Visible = false; -- todo: add a function for this

Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })


Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu



-- Addons:
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('ZekeHub')
SaveManager:SetFolder('ZekeHub/DahoodConfigs')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()






local InventoryChanger = { Functions = {}, Selected = {}, Skins = {}, Owned = {} };

do
    local Utilities = {};

    function cout(watermark, message)
        if not LPH_OBFUSCATED then
            return print('['..watermark..']', message);
        end;
    end;

    cout('Inventory Changer', 'Executor initialization test message')

    if not getgenv().InventoryConnections then
        getgenv().InventoryConnections = {};
    end;

    local players = game:GetService('Players');
    local client = players.LocalPlayer;

    local tween_service = game:GetService('TweenService');

    Utilities.AddConnection = function(signal, func)
        local connect = signal:Connect(func);

        table.insert(getgenv().InventoryConnections, { signal = signal, func = func, connect = connect });
        return connect;
    end;

    Utilities.Unload = function()
        for _, tbl in ipairs(getgenv().InventoryConnections) do
            if type(tbl) ~= 'table' then 
                tbl:Disconnect();
            end
        end;

        getgenv().InventoryConnections = {};
    end;

    Utilities.Unload();

    Utilities.Tween = function(args)
        local obj = args.obj or args.object;
        local prop = args.prop or args.properties;
        local duration = args.duration or args.time;
        local info = args.info or args.tween_info;
        local callback = args.callback;

        local tween = tween_service:Create(obj, duration and TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) or info and TweenInfo.new(unpack(info)), prop);
        tween:Play();

        if callback then
            tween.Completed:Connect(callback);
        end;
    end;

    repeat task.wait() until client.Character:FindFirstChild('FULLY_LOADED_CHAR');

    local player_gui = client.PlayerGui;

    local main_gui = player_gui:WaitForChild('MainScreenGui');
    local crew = main_gui:WaitForChild('Crew');
    local bottom_left = crew:WaitForChild('BottomLeft').Frame;
    local skins_button = bottom_left:WaitForChild('Skins');

    local replicated_storage = game:GetService('ReplicatedStorage');
    local skin_modules = replicated_storage:WaitForChild('SkinModules');
    local meshes = skin_modules:WaitForChild('Meshes');

    local weapon_skins_gui = main_gui:WaitForChild('WeaponSkinsGUI');
    local gui_body_wrapper = weapon_skins_gui:WaitForChild('Body');
    local body_wrapper = gui_body_wrapper:WaitForChild('Wrapper');
    local skin_view = body_wrapper:WaitForChild('SkinView');
    local skin_view_frame = skin_view:WaitForChild('Frame');

    local guns = skin_view_frame:WaitForChild('Guns').Contents;
    local entries = skin_view_frame:WaitForChild('Skins').Contents.Entries;

    local Ignored = workspace.Ignored;
    local Siren = Ignored.Siren;
    local Radius = Siren.Radius;

    local regex = '%[(.-)%]';

    local newColorSequence = ColorSequence.new;
    local Color3fromRGB = Color3.fromRGB;
    local newCFrame = CFrame.new;
    local newColorSequenceKeypoint = ColorSequenceKeypoint.new;

    InventoryChanger.Skins = {
        ['Mystical'] = {
            tween_duration = 0.65,
            beam_width = 0.125,
            color = newColorSequence(Color3fromRGB(255, 39, 24)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Mystical.Revolver,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14489866118',
                    C0 = newCFrame(-0.015838623, -0.0802496076, 0.00772094727, 1, 0, 4.37113883e-08, 0, 1, 0, -4.37113883e-08, 0, 1)
                }
            }
        },
        ['CyanPack'] = {
            mesh_location = meshes.CyanPack,
            guns = {
                ['[TacticalShotgun]'] = {
                    location = meshes.CyanPack.Cloud,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14056055126',
                    C0 = newCFrame(0.0441589355, -0.0269355774, -0.000701904297, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.CyanPack.DB,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14056053588',
                    C0 = newCFrame(-0.00828552246, 0.417651355, -0.00537109375, 4.18358377e-06, -1.62920685e-07, 1, 3.4104116e-13, 1, 1.62920685e-07, -1, 3.41041052e-13, -4.18358377e-06)
                },
                ['[Revolver]'] = {
                    location = meshes.CyanPack.Devil,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14056056444',
                    C0 = newCFrame(0.0185699463, 0.293397784, -0.00256347656, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Cartoon'] = {
            guns = {
                ['[Flamethrower]'] = {
                    location = meshes.Cartoon.CartoonFT,
                    equipped = false,
                    C0 = newCFrame(-0.272186279, 0.197086751, 0.0440063477, -1, 4.8018768e-07, 8.7078952e-08, 4.80187623e-07, 1, -3.54779985e-07, -8.70791226e-08, -3.54779957e-07, -1)
                },
                ['[Revolver]'] = {
                    location = meshes.Cartoon.CartoonRev,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14221101923',
                    C0 = newCFrame(-0.015411377, 0.0135096312, 0.00338745117, 1.00000095, 3.41326549e-13, 2.84217399e-14, 3.41326549e-13, 1.00000191, -9.89490712e-10, 2.84217399e-14, -9.89490712e-10, 1.00000191)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Cartoon.DBCartoon,
                    equipped = false,
                    shoot_sound = 'rbxassetid://14220912852',
                    C0 = newCFrame(0.00927734375, -0.00691050291, 0.000732421875, -1, -2.79396772e-08, -9.31322797e-10, -2.79396772e-08, 1, 1.42607872e-08, 9.31322575e-10, 1.42607872e-08, -1)
                },
                ['[RPG]'] = {
                    location = meshes.Cartoon.RPGCartoon,
                    equipped = false,
                    C0 = newCFrame(-0.0201721191, 0.289476752, -0.0727844238, 4.37113883e-08, 6.58276836e-37, 1, -5.72632016e-14, 1, 2.50305399e-21, -1, 5.72632016e-14, 4.37113883e-08)
                },
            }
        },
        ['Dragon'] = {
            color = newColorSequence(Color3.new(1, 0, 0)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Dragon.DragonRev,
                    equipped = false,
                    C0 = newCFrame(0.0384216309, 0.0450432301, -0.000671386719, 1.87045402e-31, 4.21188801e-16, -0.99999994, 1.77635684e-15, 1, -4.21188827e-16, 1, 1.77635684e-15, -1.87045413e-31)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Dragon.DBDragon,
                    equipped = false,
                    C0 = newCFrame(-0.123794556, 0.0481165648, 0.00048828125, 7.14693442e-07, 3.13283705e-10, 1, -4.56658222e-09, 1, -3.13281678e-10, -1, -4.56658533e-09, 7.14693442e-07)
                }
            }
        },
        ['Tact'] = {
            tween_duration = 1.25,
            beam_width = 0.125,
            color = newColorSequence(Color3.new(1, 0.3725490196, 0.3725490196)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Tact.Rev,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13850086195',
                    C0 = newCFrame(-0.318634033, -0.055095911, 0.00491333008, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Tact.DB,
                    equipped = false,
                    C0 = newCFrame(-0.0701141357, -0.0506889224, -0.0826416016, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.Tact.Tact,
                    equipped = false,
                    C0 = newCFrame(-0.0687713623, -0.0684046745, 0.12701416, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[SMG]'] = {
                    location = meshes.Tact.Uzi,
                    equipped = false,
                    C0 = newCFrame(0.0408782959, 0.0827783346, -0.0423583984, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[Shotgun]'] = {
                    location = meshes.Tact.Shotgun,
                    equipped = false,
                    C0 = newCFrame(-0.0610046387, 0.171100497, -0.00495910645, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Silencer]'] = {
                    location = meshes.Tact.Silencer,
                    equipped = false,
                    C0 = newCFrame(0.0766601562, -0.0350288749, -0.648864746, 1, 0, -4.37113883e-08, 0, 1, 0, 4.37113883e-08, 0, 1)
                }
            }
        },
        ['Shadow'] = {
            color = newColorSequence(Color3.new(0.560784, 0.470588, 1), Color3.new(0.576471, 0.380392, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Shadow.RevolverGhost,
                    equipped = false,
                    C0 = newCFrame(1.52587891e-05, 0, 0, 1, 0, 8.74227766e-08, 0, 1, 0, -8.74227766e-08, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Shadow.DoubleBGhost,
                    equipped = false,
                    C0 = newCFrame(0.0250015259, -0.077037394, 0, 1, 0, 0, 0, 0.999998331, 0, 0, 0, 1)
                },
                ['[AK47]'] = {
                    location = meshes.Shadow.AK47Ghost,
                    equipped = false,
                    C0 = newCFrame(-0.750015259, 4.76837158e-07, -3.05175781e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[SilencerAR]'] = {
                    location = meshes.Shadow.ARGhost,
                    equipped = false,
                    C0 = newCFrame(0.116256714, 0.0750004649, 6.10351562e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[AUG]'] = {
                    location = meshes.Shadow.AUGGhost,
                    equipped = false,
                    C0 = newCFrame(-7.62939453e-06, 0.0499991775, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[DrumGun]'] = {
                    location = meshes.Shadow.DrumgunGhost,
                    equipped = false,
                    C0 = newCFrame(1.14440918e-05, 0, 0, 1, 0, 8.74227766e-08, 0, 1, 0, -8.74227766e-08, 0, 1)
                },
                ['[Flamethrower]'] = {
                    location = meshes.Shadow.FlamethrowerGhost,
                    equipped = false,
                    C0 = newCFrame(-0.219947815, 0.339559376, 0.000274658203, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Glock]'] = {
                    location = meshes.Shadow.GlockGhost,
                    equipped = false,
                    C0 = newCFrame(0, 0, -0.200004578, 1, 0, 4.37113883e-08, 0, 1, 0, -4.37113883e-08, 0, 1)
                },
                ['[LMG]'] = {
                    location = meshes.Shadow.LMGGhost,
                    equipped = false,
                    C0 = newCFrame(0.374502182, -0.25, -0.25, -1, 0, -1.31134158e-07, 0, 1, 0, 1.31134158e-07, 0, -1)
                },
                ['[P90]'] = {
                    location = meshes.Shadow.P90Ghost,
                    equipped = false,
                    C0 = newCFrame(6.86645508e-05, 0.000218153, 3.05175781e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[RPG]'] = {
                    location = meshes.Shadow.RPGGhost,
                    equipped = false,
                    C0 = newCFrame(0.000122070312, 0.0625389814, 0.00672149658, 1, 0, -8.74227766e-08, 5.00610797e-21, 1, 5.72632016e-14, 8.74227766e-08, 5.72632016e-14, 1)
                },
                ['[Rifle]'] = {
                    location = meshes.Shadow.RifleGhost,
                    equipped = false,
                    C0 = newCFrame(0.000244140625, -0.100267321, -9.15527344e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[SMG]'] = {
                    location = meshes.Shadow.SMGGhost,
                    equipped = false,
                    C0 = newCFrame(-1.14440918e-05, 1.78813934e-07, -0.0263671875, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    location = meshes.Shadow.ShotgunGhost,
                    equipped = false,
                    C0 = newCFrame(3.05175781e-05, 0.199999928, 3.81469727e-06, -1, 0, -4.37113883e-08, 0, 1, 0, 4.37113883e-08, 0, -1)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.Shadow.TacticalShotgunGhost,
                    equipped = false,
                    C0 = newCFrame(-0.148262024, 0, 0, 1, 0, 8.74227766e-08, 0, 1, 0, -8.74227766e-08, 0, 1)
                }
            }
        },
        ['Golden Age'] = {
            tween_duration = 1.25,
            beam_width = 0.125,
            color = newColorSequence(Color3.fromHSV(0.89166666666, 0.24, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.GoldenAge.Revolver,
                    equipped = false,
                    C0 = newCFrame(0.0295257568, 0.0725820661, -0.000946044922, 1, -4.89858741e-16, -7.98081238e-23, 4.89858741e-16, 1, 3.2584137e-07, -7.98081238e-23, -3.2584137e-07, 1),
                    shoot_sound = 'rbxassetid://1898322396'
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.GoldenAge['Double Barrel'],
                    equipped = false,
                    shoot_sound = 'rbxassetid://4915503055',
                    C0 = newCFrame(-0.00664520264, 0.0538104773, 0.0124816895, -1, 4.89858741e-16, 7.98081238e-23, 4.89858741e-16, 1, 3.2584137e-07, 7.98081238e-23, 3.2584137e-07, -1)
                }
            }
        },
        ['Red Skull'] = {
            color = newColorSequence(Color3.new(0.917647, 0, 0)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.RedSkull.RedSkullRev,
                    equipped = false,
                    C0 = newCFrame(-0.0043258667, 0.0084195137, -0.00238037109, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Shotgun]'] = {
                    location = meshes.RedSkull.RedSkullRev,
                    equipped = false,
                    C0 = newCFrame(-0.00326538086, 0.0239292979, -0.039352417, -4.37113883e-08, 0, -1, 0, 1, 0, 1, 0, -4.37113883e-08)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.RedSkull.RedSkullRev,
                    equipped = false,
                    C0 = newCFrame(-0.0143432617, -0.151709318, 0.00820922852, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[RPG]'] = {
                    location = meshes.RedSkull.RedSkullRev,
                    equipped = false,
                    C0 = newCFrame(-0.00149536133, 0.254377961, 0.804840088, -1, 0, 4.37113883e-08, -2.50305399e-21, 1, -5.72632016e-14, -4.37113883e-08, 5.72632016e-14, -1)
                }
            }
        },
        --[[['Galaxy'] = {
            border_color = newColorSequence(Color3.new(0, 0, 1)),
            particle = {
                properties = {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.new(0.419608, 0.376471, 1)),
                        ColorSequenceKeypoint.new(1, Color3.new(0.419608, 0.376471, 1))
                    }),
                    Name = 'Galaxy',
                    Size = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.5),
                        NumberSequenceKeypoint.new(0.496, 1.2),
                        NumberSequenceKeypoint.new(1, 0.5)
                    }),
                    Squash = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.173364, 0.525),
                        NumberSequenceKeypoint.new(0.584386, -1.7625),
                        NumberSequenceKeypoint.new(0.98163, 0.0749998),
                        NumberSequenceKeypoint.new(1, 0)
                    }),
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(0.107922, 1),
                        NumberSequenceKeypoint.new(0.391504, 0.25),
                        NumberSequenceKeypoint.new(0.670494, 0.78125),
                        NumberSequenceKeypoint.new(0.845006, 0),
                        NumberSequenceKeypoint.new(1, 1)
                    }),
                    Texture = 'rbxassetid://7422600824',
                    ZOffset = 1,
                    LightEmission = 0.7,
                    Lifetime = NumberRange.new(1, 1),
                    Rate = 3,
                    Rotation = NumberRange.new(0, 360),
                    RotSpeed = NumberRange.new(0, 15),
                    Speed = NumberRange.new(1, 1),
                    SpreadAngle = Vector2.new(-45, 45)
                }
            },
            guns = {
                ['[Revolver]'] = {
                    texture = 'rbxassetid://9370936730'
                },
                ['[TacticalShotgun]'] = {
                    texture = 'rbxassetid://9402279010'
                }
            }
        },]]
        ['Kitty'] = {
            tween_duration = 1,
            beam_width = 0.125,
            color = newColorSequence(Color3.new(1, 0.690196, 0.882353), Color3.new(1, 0.929412, 0.964706)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Kitty.KittyRevolver,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13483022860',
                    C0 = newCFrame(0.0310440063, 0.0737591386, 0.0226745605, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Flamethrower]'] = {
                    location = meshes.Kitty.KittyFT,
                    equipped = false,
                    C0 = newCFrame(-0.265670776, 0.115545571, 0.00997924805, -1, 9.74078034e-21, 5.47124086e-13, 9.74092898e-21, 1, 3.12638804e-13, -5.47126309e-13, 3.12638804e-13, -1)
                },
                ['[RPG]'] = {
                    location = meshes.Kitty.KittyRPG,
                    equipped = false,
                    C0 = newCFrame(0.0268554688, 0.0252066851, 0.117408752, -1, 2.51111284e-40, 4.37113883e-08, -3.7545812e-20, 1, -8.58948004e-13, -4.37113883e-08, 8.58948004e-13, -1)
                },
                ['[Shotgun]'] = {
                    location = meshes.Kitty.KittyShotgun,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13483035672',
                    C0 = newCFrame(0.0233459473, 0.223892093, -0.0213623047, 4.37118963e-08, -6.53699317e-13, 1, 3.47284736e-20, 1, 7.38964445e-13, -0.999997139, 8.69506734e-21, 4.37119354e-08)
                }
            }
        },
        ['Toy'] = {
            mesh_location = meshes.Toy,
            tween_duration = 1.25,
            color = newColorSequence({newColorSequenceKeypoint(0, Color3.new(0, 1, 0)), ColorSequenceKeypoint.new(0.5, Color3.new(0.666667, 0.333333, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.666667, 0))}),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Toy.RevolverTOY,
                    equipped = false,
                    C0 = newCFrame(-0.0250854492, -0.144362092, -0.00266647339, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[LMG]'] = {
                    location = meshes.Toy.LMGTOY,
                    equipped = false,
                    C0 = newCFrame(-0.285247803, -0.0942560434, -0.270412445, 1, 0, 4.37113883e-08, 0, 1, 0, -4.37113883e-08, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Toy.DBToy,
                    equipped = false,
                    C0 = newCFrame(-0.0484313965, -0.00164616108, -0.0190467834, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[RPG]'] = {
                    location = meshes.Toy.RPGToy,
                    equipped = false,
                    C0 = newCFrame(0.00121307373, 0.261434197, -0.318969727, 1, 2.5768439e-12, -4.37113883e-08, 2.57684412e-12, 1, 6.29895225e-12, 4.37113883e-08, 6.29895225e-12, 1)
                }
            }
        },
        ['Galactic'] = {
            mesh_location = meshes.Galactic,
            tween_duration = 1.25,
            color = newColorSequence(Color3.new(1, 0, 0)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Galactic.galacticRev,
                    equipped = false,
                    C0 = newCFrame(-0.049041748, 0.0399398208, -0.00772094727, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.Galactic.TacticalGalactic,
                    equipped = false,
                    C0 = newCFrame(-0.0411682129, -0.0281000137, 0.00103759766, 0, 5.68434189e-14, 1, -1.91456822e-13, 1, 5.68434189e-14, -1, 1.91456822e-13, 0)
                }
            }
        },
        ['Water'] = {
            tween_duration = 1.25,
            tween_type = 'Both',
            beam_width = 0.125,
            color = newColorSequence(Color3.new(0, 1, 1), Color3.new(0.666667, 1, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Water.WaterGunRevolver,
                    equipped = false,
                    C0 = newCFrame(-0.0440063477, 0.028675437, -0.00469970703, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.Water.TactWater,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13814991449',
                    C0 = newCFrame(0.0238037109, -0.00912904739, 0.00485229492, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Water.DBWater,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13814990235',
                    C0 = newCFrame(-0.0710754395, 0.00169920921, -0.0888671875, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                },
                ['[Flamethrower]'] = {
                    location = meshes.Water.FTWater,
                    equipped = false,
                    C0 = newCFrame(0.0941314697, 0.593509138, 0.0191040039, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                }
            }
        },
        ['GPO'] = {
            color = newColorSequence(Color3.new(1, 0.666667, 0)),
            guns = {
                ['[RPG]'] = {
                    location = meshes.GPO.Bazooka,
                    equipped = false,
                    C0 = newCFrame(-0.0184631348, 0.0707798004, 0.219360352, 4.37113883e-08, 1.07062025e-23, 1, -5.75081297e-14, 1, 1.14251725e-36, -1, 5.70182736e-14, 4.37113883e-08)
                },
                ['[TacticalShotgun]'] = {
                    location = meshes.GPO.MaguTact,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13998711419',
                    C0 = newCFrame(-0.282501221, 0.0472121239, -0.0065612793, -6.60624482e-06, 1.5649757e-08, -1, -5.68434189e-14, 1, -1.56486806e-08, 1, 5.68434189e-14, -6.60624482e-06)
                },
                ['[Rifle]'] = {
                    location = meshes.GPO.Rifle,
                    equipped = false,
                    C0 = newCFrame(-0.208007812, 0.185256913, 0.000610351562, -3.37081539e-14, 1.62803403e-07, -1.00000012, -8.74227695e-08, 0.999999881, 1.63036205e-07, 1, 8.74227766e-08, -1.94552524e-14)
                }
            }
        },
        ['BIT8'] = {
            tween_duration = 1.25,
            tween_type = 'Width',
            beam_width = 0.125,
            color = newColorSequence(Color3.fromHSV(0.5, 0.9, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.BIT8.RPixel,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13326584088',
                    C0 = newCFrame(0.0261230469, -0.042888701, 0.00260925293, -1, 1.355249e-20, -3.55271071e-15, 1.355249e-20, 1, -1.81903294e-27, 3.55271071e-15, -1.81903294e-27, -1)
                },
                ['[Flamethrower]'] = {
                    location = meshes.BIT8.FTPixel,
                    equipped = false,
                    C0 = newCFrame(-0.0906066895, -0.0161985159, -0.0117645264, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.BIT8.DBPixel,
                    equipped = false,
                    shoot_sound = 'rbxassetid://13326578563',
                    C0 = newCFrame(-0.240386963, -0.127295256, -0.00776672363, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[RPG]'] = {
                    location = meshes.BIT8.RPGPixel,
                    equipped = false,
                    C0 = newCFrame(0.0102081299, 0.0659624338, 0.362945557, 4.37113883e-08, 0, 1, -5.72632016e-14, 1, 2.50305399e-21, -1, 5.72632016e-14, 4.37113883e-08)
                }
            }
        },
        ['Electric'] = {
            color = newColorSequence(Color3.new(0, 1, 1), Color3.new(0.666667, 1, 1)),
            guns = {
                ['[Revolver]'] = {
                    location = meshes.Electric.ElectricRevolver,
                    equipped = false,
                    C0 = newCFrame(0.185462952, 0.0312761068, 0.000610351562, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[DrumGun]'] = {
                    location = meshes.Electric.ElectricDrum,
                    equipped = false,
                    C0 = newCFrame(-0.471969604, 0.184426308, 0.075378418, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[SMG]'] = {
                    location = meshes.Electric.ElectricSMG,
                    equipped = false,
                    C0 = newCFrame(-0.0620956421, 0.109580457, 0.00729370117, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    location = meshes.Electric.ElectricShotgun,
                    equipped = false,
                    C0 = newCFrame(6.10351562e-05, 0.180232108, -0.624732971, 1, 0, -4.37113883e-08, 0, 1, 0, 4.37113883e-08, 0, 1)
                },
                ['[Rifle]'] = {
                    location = meshes.Electric.ElectricRifle,
                    equipped = false,
                    C0 = newCFrame(0.181793213, -0.0415201783, 0.00421142578, 1.8189894e-12, 6.6174449e-24, 1, 7.27595761e-12, 1, 6.6174449e-24, -1, -7.27595761e-12, -1.8189894e-12)
                },
                ['[P90]'] = {
                    location = meshes.Electric.ElectricP90,
                    equipped = false,
                    C0 = newCFrame(0.166191101, -0.225557804, -0.0075378418, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[LMG]'] = {
                    location = meshes.Electric.ElectricLMG,
                    equipped = false,
                    C0 = newCFrame(0.142379761, 0.104723871, -0.303771973, -1, 0, -4.37113883e-08, 0, 1, 0, 4.37113883e-08, 0, -1)
                },
                ['[Flamethrower]'] = {
                    location = meshes.Electric.ElectricFT,
                    equipped = false,
                    C0 = newCFrame(-0.158782959, 0.173444271, 0.00640869141, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Double-Barrel SG]'] = {
                    location = meshes.Electric.ElectricDB,
                    equipped = false,
                    C0 = newCFrame(0.0755996704, -0.0420352221, 0.00543212891, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Glock]'] = {
                    location = meshes.Electric.ElectricGlock,
                    equipped = false,
                    C0 = newCFrame(-0.00207519531, 0.0318723917, 0.0401077271, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[AUG]'] = {
                    location = meshes.Electric.ElectricAUG,
                    equipped = false,
                    C0 = newCFrame(0.331085205, -0.0117390156, 0.00155639648, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[SilencerAR]'] = {
                    location = meshes.Electric.ElectricAR,
                    equipped = false,
                    C0 = newCFrame(-0.16942215, 0.0508521795, 0.0669250488, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[AK47]'] = {
                    location = meshes.Electric.ElectricAK,
                    equipped = false,
                    C0 = newCFrame(0.155792236, 0.18423444, 0.00140380859, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                }
            }
        },
        --[[['Shadow'] = {
            Color = ColorSequence.new(Color3.new(0.560784, 0.470588, 1), Color3.new(0.576471, 0.380392, 1)),
            ['Rifle'] = {
                Equipped = false
            },
            ['Shotgun'] = {
                Equipped = false,
                Location = meshes.Shadow.ShotgunGhost,
                CFrame = CFrame.new(3.05175781e-05, 0.199999928, 3.81469727e-06, -1, 0, -4.37113883e-08, 0, 1, 0, 4.37113883e-08, 0, -1)
            },
            ['Revolver'] = {
                Equipped = false,
                Location = meshes.Shadow.RevolverGhost,
                CFrame = CFrame.new(1.52587891e-05, 0, 0, 1, 0, 8.74227766e-08, 0, 1, 0, -8.74227766e-08, 0, 1)
            }
        }]]
        ['Halloween23'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Halloween.Rev,
                    shoot_sound = 'rbxassetid://14924285721',
                    C0 = newCFrame(-0.0257873535, -0.0117108226, -0.00671386719, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Halloween.DB,
                    shoot_sound = 'rbxassetid://14924282919',
                    C0 = newCFrame(-0.00271606445, -0.0485508144, 0.000732421875, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                },
                ['[Shotgun]'] = {
                    equipped = false,
                    location = meshes.Halloween.SG,
                    shoot_sound = 'rbxassetid://14924268000',
                    C0 = newCFrame(0.00573730469, 0.294590235, -0.115814209, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Halloween.Tact,
                    shoot_sound = 'rbxassetid://14924256223',
                    C0 = newCFrame(-0.0715637207, -0.0843618512, 0.00582885742, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                }
            }
        },
        ['Soul'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Soul.rev,
                    shoot_sound = 'rbxassetid://14909152822',
                    C0 = newCFrame(-0.0646362305, 0.2725088, -0.00242614746, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Soul.db,
                    shoot_sound = 'rbxassetid://14909164664',
                    C0 = newCFrame(0.405822754, 0.0975035429, -0.00506591797, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Soul.tact,
                    shoot_sound = 'rbxassetid://14918188609',
                    C0 = newCFrame(-0.347473145, 0.0268714428, 0.00553894043, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                }
            }
        },
        ['Heaven'] = {
            color = newColorSequence(Color3.new(1, 1, 1)),
            tween_duration = 1.25,
            easing_style = Enum.EasingStyle.Quad,
            easing_direction = Enum.EasingDirection.Out,
            beam_width = 0.13,
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Heaven.Revolver,
                    C0 = newCFrame(-0.0829315186, -0.0831851959, -0.00296020508, -0.999999881, 2.94089277e-17, 8.27179774e-25, -2.94089277e-17, 0.999999881, 6.85215614e-16, 8.27179922e-25, -6.85215667e-16, -1)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Heaven.DB,
                    shoot_sound = 'rbxassetid://14489852879',
                    C0 = newCFrame(-0.0303955078, 0.022110641, 0.00296020508, -0.999997139, -7.05812226e-16, 7.85568618e-30, 7.05812226e-16, 0.999997139, -2.06501178e-14, 6.44518474e-30, 2.06501042e-14, -0.999999046)
                }
            }
        },
        ['Void'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Void.rev,
                    C0 = newCFrame(-0.00503540039, 0.0082899332, -0.00164794922, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[TacticalShotgun]'] = {
                    equipped = false,
                    location = meshes.Void.tact,
                    C0 = newCFrame(0.0505371094, -0.0487936139, 0.00158691406, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                }
            }
        },
        ['DH-Stars II'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Popular.STARSREV,
                    C0 = newCFrame(0.0578613281, -0.0479719043, -0.00115966797, -1.00000405, 1.15596135e-16, 1.64267286e-30, -1.15596135e-16, 1, 2.99751983e-14, 1.66683049e-30, -2.99751983e-14, -1.00000405)
                }
            }
        },
        ['DH-Verified'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Popular.VERIFIEDREV,
                    C0 = newCFrame(0.049407959, -0.0454721451, 0.00158691406, -1, 0, 0, 0, 1, 2.22044605e-15, 0, -2.22044605e-15, -1)
                }
            }
        },
        ['Candy'] = {
            guns = {
                ['[Revolver]'] = {
                    equipped = false,
                    location = meshes.Candy.RevolverCandy,
                    C0 = newCFrame(-0.106658936, -0.0681198835, 0.00198364258, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                },
                ['[Double-Barrel SG]'] = {
                    equipped = false,
                    location = meshes.Candy.DBCandy,
                    C0 = newCFrame(0.0430603027, -0.0375298262, -0.00198364258, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                }
            }
        }
    };

    mkelement = function(class, parent, props)
        local obj = Instance.new(class);

        for i, v in next, props do
            obj[i] = v;
        end;

        obj.Parent = parent;
        return obj;
    end;

    find_gun = (function(gun_name, instance)
        for i, v in next, instance:GetChildren() do
            if v:IsA('Tool') then
                if (v.Name == gun_name) then
                    return v
                end
            end
        end
    end);

    InventoryChanger.Functions.GameEquip = function(gun, skin)
        return replicated_storage.MainEvent:FireServer('EquipWeaponSkins', gun, skin);
    end;

    InventoryChanger.Functions.AddOwnedSkins = function()
        for _, v in ipairs(entries:GetChildren()) do
            local ext_name = v.Name:match('%[(.-)%]');
            local skin_name, _ = v.Name:gsub('%[.-%]', '');
            if 
                ext_name 
                and skin_name 
                and InventoryChanger.Skins[skin_name] 
                and InventoryChanger.Skins[skin_name].guns 
                and InventoryChanger.Skins[skin_name].guns['[' .. ext_name .. ']']
            then
                local Preview = v:FindFirstChild('Preview');

                if Preview and Preview:FindFirstChild('Equipped') and Preview.Equipped.Visible then
                    table.insert(InventoryChanger.Owned, { frame = v, gun = '[' .. ext_name .. ']' })
                end;
            end;
        end;
    end;

    InventoryChanger.Functions.UnequipGameSkins = function()
        for _, v in ipairs(InventoryChanger.Owned) do
            local SkinInfo = v.frame.SkinInfo;
            local Container = SkinInfo.Container;
            local SkinName = Container.SkinName.Text;

            InventoryChanger.Functions.GameEquip(v.gun, SkinName)
        end;
    end;

    InventoryChanger.Functions.Unload = function()
        return Utilities.Unload();
    end;

    InventoryChanger.Functions.Reload = function()
        local function wait_for_child(parent, child)
            local child = parent:WaitForChild(child);
            while not child do
                child = parent:WaitForChild(child);
            end;
            return child;
        end;
        
        client = players.LocalPlayer;
        player_gui = client.PlayerGui;

        repeat task.wait() until player_gui;

        main_gui = wait_for_child(player_gui, 'MainScreenGui');
        crew = wait_for_child(main_gui, 'Crew');

        bottom_left = wait_for_child(crew, 'BottomLeft');
        bottom_left = bottom_left.Frame;

        skins_button = wait_for_child(bottom_left, 'Skins');

        weapon_skins_gui = wait_for_child(main_gui, 'WeaponSkinsGUI');
        
        gui_body_wrapper = wait_for_child(weapon_skins_gui, 'Body');
        body_wrapper = wait_for_child(gui_body_wrapper, 'Wrapper');
        
        skin_view = wait_for_child(body_wrapper, 'SkinView');
        skin_view_frame = wait_for_child(skin_view, 'Frame');

        guns = wait_for_child(skin_view_frame, 'Guns').Contents;
        entries = wait_for_child(skin_view_frame, 'Skins').Contents.Entries;

        InventoryChanger.Functions.Unload();

        cout('Reload', 'Script successfully reloaded!');
        cout('Reload', 'Waiting for skins to load...');

        wait_for_child(entries, '[Revolver]Golden Age');

        cout('Reload', 'Skins successfully loaded.');
        InventoryChanger.Functions.AddOwnedSkins();
        InventoryChanger.Functions.UnequipGameSkins();

        for i, v in next, guns:GetChildren() do
            if v:IsA('Frame') and v.Name ~= 'GunEntry' and v.Name ~= 'Trading' and v.Name ~= '[Mask]' then
                Utilities.AddConnection(v.Button.MouseButton1Click, function()
                    local extracted_name = v.Name:match(regex);
                    if extracted_name then
                        InventoryChanger.Functions.Start(extracted_name);
                    end;
                end);
            end;
        end;
    end;

    InventoryChanger.Functions.Equip = function(gun_name, skin_name)
        print('[DEBUG]', 'Equip function has been invoked.', gun_name, skin_name or 'Default')
        local gun = find_gun(gun_name, client.Backpack) or find_gun(gun_name, client.Character);
        if not skin_name then
            if gun and gun.Name == gun_name then
                for _, v in next, gun.Default:GetChildren() do v:Destroy() end;
                
                gun.Default.Transparency = 0;
                --if InventoryChanger.Selected[gun.Name] and not InventoryChanger.Skins[InventoryChanger.Selected[gun.Name]].Location then
                    --gun.Default.TextureID = 'rbxassetid://8117372147';
                --end;
                
                if gun.Name == '[Silencer]' or gun.Name == '[SilencerAR]' then
                    gun:FindFirstChild('Part').Transparency = 0;
                end;

                local skin_name = InventoryChanger.Selected[gun.Name];

                if skin_name and InventoryChanger.Skins[skin_name] and InventoryChanger.Skins[skin_name].guns and InventoryChanger.Skins[skin_name].guns[gun.Name] then
                    if InventoryChanger.Skins[skin_name].guns[gun.Name].TracerLoop then
                        InventoryChanger.Skins[skin_name].guns[gun.Name].TracerLoop:Disconnect();
                        InventoryChanger.Skins[skin_name].guns[gun.Name].TracerLoop = nil;
                    end;

                    if InventoryChanger.Skins[skin_name].guns[gun.Name].shoot_sound_loop then
                        InventoryChanger.Skins[skin_name].guns[gun.Name].shoot_sound_loop:Disconnect();
                        InventoryChanger.Skins[skin_name].guns[gun.Name].shoot_sound_loop = nil;
                    end;
                end;
            end;

            return;
        end;
        
        if gun and gun.Name == gun_name and skin_name then
            cout('DEBUG', 'Has skin name');
            local skin_pack = InventoryChanger.Skins[skin_name];
            local guns = skin_pack.guns;
            if skin_pack and guns and not skin_pack.texture then
                cout('DEBUG', 'Changing skin assets');
                for _, x in next, gun.Default:GetChildren() do x:Destroy() end;
                
                local clone = guns[gun_name].location:Clone();
                clone.Name = 'Mesh';
                clone.Parent = gun.Default;
                
                local weld = Instance.new('Weld', clone);
                weld.Part0 = gun.Default;
                weld.Part1 = clone;
                weld.C0 = guns[gun_name].C0;
                
                gun.Default.Transparency = 1;

                if guns[gun_name].shoot_sound then
                    if guns[gun_name].shoot_sound_loop then
                        guns[gun_name].shoot_sound_loop:Disconnect();
                        guns[gun_name].shoot_sound_loop = nil;
                    end;
                    gun.Handle.ShootSound.SoundId = guns[gun_name].shoot_sound;
                    guns[gun_name].shoot_sound_loop = gun.Handle.ChildAdded:Connect(function(child)
                        if child:IsA('Sound') and child.Name == 'ShootSound' then
                            child.SoundId = guns[gun_name].shoot_sound;
                        end;
                    end);
                end;
            end;
        end;
    end;

    InventoryChanger.Functions.Start = function(name)
        for i, v in next, entries:GetChildren() do
            local skin_name, _ = v.Name:gsub('%[.-%]', '');

            if string.find(v.Name, name, 1, true) and InventoryChanger.Skins[skin_name] and InventoryChanger.Skins[skin_name].guns and InventoryChanger.Skins[skin_name].guns['['..name..']'] and InventoryChanger.Skins[skin_name].guns['['..name..']'].location then
                local Preview = v:FindFirstChild('Preview');
                local Button = v:FindFirstChild('Button');
                local skinInfo = v:FindFirstChild('SkinInfo');

                if Preview and Button and skinInfo then
                    local Label = Preview:FindFirstChild('LockImageLabel');
                    local AmountValue = Preview:FindFirstChild('AmountValue');
                    local Equipped = Preview:FindFirstChild('Equipped');
                    local container = skinInfo:FindFirstChild('Container');

                    local extracted_name = v.Name:match(regex);

                    if Equipped and extracted_name then
                        Equipped.Visible = InventoryChanger.Skins[skin_name] and InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'] and InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped or false;
                        InventoryChanger.Functions.Equip('['..extracted_name..']', InventoryChanger.Selected['['..extracted_name..']'])

                        if Label then
                            Label.Visible = false;
                        end;

                        if container and container.SellButton then
                            container.SellButton.Visible = true;
                        end;
                    
                        if AmountValue then
                            AmountValue.Visible = true;
                            AmountValue.Text = 'x1';
                        end;
                    
                        if getgenv().InventoryConnections[v.Name] then
                            getgenv().InventoryConnections[v.Name]:Disconnect();
                            getgenv().InventoryConnections[v.Name] = nil;
                        end;

                        v.Button:Destroy();
                        local props = { Text = '',BackgroundTransparency = 1,Size = UDim2.new(1, 0, 0.7, 0),ZIndex = 5,Name = 'Button',Position = UDim2.new(0, 0, 0, 0)};
                        local new_btn = mkelement('TextButton', v, props);

                        getgenv().InventoryConnections[v.Name] = new_btn.MouseButton1Click:Connect(function()
                            InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped = not InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped;
                            InventoryChanger.Selected['['..extracted_name..']'] = InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped and skin_name or nil;
                            Equipped.Visible = InventoryChanger.Skins[skin_name].guns['['..extracted_name..']'].equipped;

                            for k, x in ipairs(entries:GetChildren()) do
                                if x.Name:match(regex) == extracted_name and x ~= v then
                                    x.Preview.Equipped.Visible = false;

                                    for _, l in next, InventoryChanger.Skins do
                                        if _ ~= skin_name and l['['..extracted_name..']'] and l['['..extracted_name..']'].equipped then
                                            l[extracted_name].equipped = false
                                        end;
                                    end;
                                end;
                                
                                if x ~= v and string.find(x.Name, name, 1, true) and InventoryChanger.Skins[skin_name] and InventoryChanger.Skins[skin_name].guns and InventoryChanger.Skins[skin_name].guns['['..name..']'] and InventoryChanger.Skins[skin_name].guns['['..name..']'].location then
                                    local Preview = v:FindFirstChild('Preview');
                                    local Button = v:FindFirstChild('Button');
                                    local skinInfo = v:FindFirstChild('SkinInfo');
                                    
                                    if Preview and Button and skinInfo then
                                        local Label = Preview:FindFirstChild('LockImageLabel');
                                        local AmountValue = Preview:FindFirstChild('AmountValue');
                                        local Equipped = Preview:FindFirstChild('Equipped');
                                        local container = skinInfo:FindFirstChild('Container');
                                        
                                        if Label then
                                            Label.Visible = false;
                                        end;
                        
                                        if container and container.SellButton then
                                            container.SellButton.Visible = true;
                                        end;
                                        
                                        if AmountValue then
                                            AmountValue.Visible = true;
                                            AmountValue.Text = 'x1';
                                        end;
                                    end;

                                    InventoryChanger.Owned = {};
                                    InventoryChanger.Functions.AddOwnedSkins();
                                    InventoryChanger.Functions.UnequipGameSkins();
                                end;
                            end;
                        end);
                    end;
                end;
            end;
        end;
    end;

    InventoryChanger.Functions.CharacterAdded = function(character)
        if getgenv().InventoryConnections.ChildAdded then
            getgenv().InventoryConnections.ChildAdded:Disconnect();
            getgenv().InventoryConnections.ChildAdded = nil;
        end;

        if getgenv().InventoryConnections.ChildRemoved then
            getgenv().InventoryConnections.ChildRemoved:Disconnect();
            getgenv().InventoryConnections.ChildRemoved = nil;
        end;

        getgenv().InventoryConnections.ChildAdded = character.ChildAdded:Connect(function(child)
            if child:IsA('Tool') and child:FindFirstChild('GunScript') then
                InventoryChanger.Functions.Equip(child.Name, InventoryChanger.Selected[child.Name]);
                local skin_name = InventoryChanger.Selected[child.Name];
                
                if skin_name then
                    if InventoryChanger.Skins[skin_name].color and InventoryChanger.Skins[skin_name].guns[child.Name].equipped then
                        if InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop then
                            InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop:Disconnect();
                            InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop = nil;
                        end;

                        InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop = Ignored.DescendantAdded:Connect(function(descendant)
                            local gun = find_gun(child.Name, client.Character) or nil;

                            if gun and descendant:IsDescendantOf(siren) and descendant:IsA('Beam') then
                                local pos1 = (descendant.Attachment0.WorldCFrame.Position.X > gun.Handle.CFrame.Position.X) and descendant.Attachment0.WorldCFrame.Position or gun.Handle.CFrame.Position;
                                local pos2 = (descendant.Attachment0.WorldCFrame.Position.X < gun.Handle.CFrame.Position.X) and descendant.Attachment0.WorldCFrame.Position or gun.Handle.CFrame.Position;

                                if math.abs(client.Character.HumanoidRootPart.Velocity.X) < 22 and (pos1 - pos2).Magnitude < 5 or (pos1 - pos2).Magnitude < 20 then
                                    local skin_pack = InventoryChanger.Skins[skin_name];
                                    local guns = skin_pack and skin_pack.guns or nil
                                    local tween_duration = skin_pack and (skin_pack.tween_duration or guns and guns[gun.Name] and guns[gun.Name].tween_duration) or nil;
                                    local width = skin_pack and (skin_pack.beam_width or guns and guns[gun.Name] and guns[gun.Name].beam_width) or nil;
                                    local color = skin_pack and (skin_pack.color or guns and guns[gun.Name] and guns[gun.Name].color) or nil;
                                    local easing_direction = skin_pack and (skin_pack.easing_direction or guns and guns[gun.Name] and guns[gun.Name].easing_direction) or nil;
                                    local easing_style = skin_pack and (skin_pack.easing_style or guns and guns[gun.Name] and guns[gun.Name].easing_style) or nil;

                                    if skin_pack and tween_duration and color then
                                        local clonedParent = descendant.Parent:Clone();

                                        clonedParent.Parent = workspace.Vehicles;
                                        descendant.Parent:Destroy();
                                        if width then
                                            clonedParent:FindFirstChild('GunBeam').Width1 = width;
                                        end;
                                        clonedParent:FindFirstChild('GunBeam').Color = color;
                                        Utilities.Tween({
                                            object = clonedParent:FindFirstChild('GunBeam'),
                                            info = { tween_duration, easing_style, easing_direction },
                                            properties = { Width1 = 0 },
                                            callback = function()
                                                clonedParent:Destroy();
                                            end
                                        })
                                    elseif color then
                                        descendant.Color = color;
                                    end;
                                end;
                            end;
                        end);
                    else
                        if InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop then
                            InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop:Disconnect();
                            InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop = nil;
                        end;
                    end;
                end;
            end;
        end);

        getgenv().InventoryConnections.ChildRemoved = character.ChildRemoved:Connect(function(child)
            if child:IsA('Tool') and child:FindFirstChild('GunScript') then
                InventoryChanger.Functions.Equip(child.Name, false);

                local skin_name = InventoryChanger.Selected[child.Name];

                if skin_name then
                    if InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop then
                        InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop:Disconnect();
                        InventoryChanger.Skins[skin_name].guns[child.Name].TracerLoop = nil;
                    end;
                end;
            end;
        end);
        
        InventoryChanger.Functions.Reload();
    end;

    if getgenv().InventoryConnections.CharacterAdded then
        getgenv().InventoryConnections.CharacterAdded:Disconnect();
        getgenv().InventoryConnections.CharacterAdded = nil;
    end;
    getgenv().InventoryConnections.CharacterAdded = client.CharacterAdded:Connect(InventoryChanger.Functions.CharacterAdded);    InventoryChanger.Functions.CharacterAdded(client.Character);end;
