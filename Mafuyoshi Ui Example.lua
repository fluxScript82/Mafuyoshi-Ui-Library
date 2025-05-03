-- Example usage of the Mafuyoshi UI Library

-- Load the library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/username/MafuyoshiLib/main/source.lua"))()

-- Create a window
local Window = Library:CreateWindow("Mafuyoshi Script", "Midnight")

-- Create tabs
local MainTab = Window:CreateTab("Main", "🏠")
local PlayerTab = Window:CreateTab("Player", "👤")
local VisualTab = Window:CreateTab("Visuals", "👁️")
local SettingsTab = Window:CreateTab("Settings", "⚙️")

-- Main Tab
MainTab:CreateLabel("Welcome to Mafuyoshi Script!")

MainTab:CreateButton("Kill All", function()
    Window:ShowNotification("Feature", "Kill All feature activated!", "info", 3)
    -- Your kill all code here
end)

MainTab:CreateButton("Teleport to Lobby", function()
    Window:ShowNotification("Teleporting", "Teleporting to lobby...", "info", 3)
    -- Your teleport code here
end)

MainTab:CreateToggle("Auto Farm", false, function(value)
    Window:ShowNotification("Auto Farm", "Auto Farm has been " .. (value and "enabled" or "disabled"), value and "success" or "info", 3)
    -- Your auto farm code here
end)

-- Player Tab
PlayerTab:CreateLabel("Player Modifications")

PlayerTab:CreateSlider("Walk Speed", 16, 500, 16, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

PlayerTab:CreateSlider("Jump Power", 50, 500, 50, function(value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

PlayerTab:CreateToggle("Infinite Jump", false, function(value)
    -- Your infinite jump code here
    Window:ShowNotification("Player", "Infinite Jump " .. (value and "enabled" or "disabled"), value and "success" or "info", 3)
end)

PlayerTab:CreateDropdown("Animation Pack", {"Default", "Zombie", "Ninja", "Robot"}, "Default", function(option)
    Window:ShowNotification("Animation", "Changed animation pack to " .. option, "info", 3)
    -- Your animation pack code here
end)

-- Visuals Tab
VisualTab:CreateLabel("Visual Options")

VisualTab:CreateToggle("ESP", false, function(value)
    Window:ShowNotification("Visuals", "ESP has been " .. (value and "enabled" or "disabled"), value and "success" or "info", 3)
    -- Your ESP code here
end)

VisualTab:CreateToggle("Tracers", false, function(value)
    Window:ShowNotification("Visuals", "Tracers have been " .. (value and "enabled" or "disabled"), value and "success" or "info", 3)
    -- Your tracers code here
end)

VisualTab:CreateToggle("Chams", false, function(value)
    Window:ShowNotification("Visuals", "Chams have been " .. (value and "enabled" or "disabled"), value and "success" or "info", 3)
    -- Your chams code here
end)

VisualTab:CreateDropdown("ESP Color", {"Red", "Green", "Blue", "Purple", "White"}, "Red", function(option)
    Window:ShowNotification("Visuals", "ESP color changed to " .. option, "info", 3)
    -- Your ESP color change code here
end)

VisualTab:CreateSlider("ESP Thickness", 1, 10, 2, function(value)
    -- Your ESP thickness code here
end)

-- Settings Tab
SettingsTab:CreateLabel("UI Settings")

SettingsTab:CreateDropdown("Theme", {"Default", "Light", "Dark", "Midnight"}, "Midnight", function(option)
    -- Change the theme
    -- This would require additional code to implement theme changing
    Window:ShowNotification("Settings", "Theme changed to " .. option, "success", 3)
end)

SettingsTab:CreateSlider("UI Transparency", 0, 100, 0, function(value)
    -- Your UI transparency code here
    Window:ShowNotification("Settings", "UI Transparency set to " .. value .. "%", "info", 2)
end)

-- Script Execution
SettingsTab:CreateLabel("Script Execution")

local scriptBox = SettingsTab:CreateCodeBox("Script", "Enter your Lua script here...", "-- Enter your script here\nprint(\"Hello from Mafuyoshi!\")", function(text)
    -- This callback runs when focus is lost on the code box
end)

SettingsTab:CreateButton("Execute Script", function()
    local code = scriptBox.Value()
    Window:ExecuteScript(code)
end)

SettingsTab:CreateButton("Clear Script", function()
    scriptBox.Set("")
    Window:ShowNotification("Script Cleared", "Script editor has been cleared", "info", 2)
end)

-- Credits
MainTab:CreateLabel("Created by Mafuyoshi")
