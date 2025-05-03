--[[
    Mafuyoshi UI Library
    A lightweight UI library for Roblox scripts
    
    Usage:
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/username/MafuyoshiLib/main/source.lua"))()
    local Window = Library:CreateWindow("My Script")
    
    local Tab = Window:CreateTab("Main")
    Tab:CreateButton("Click Me", function() print("Button clicked!") end)
]]

local Library = {}
Library.__index = Library

-- Theme configurations
Library.Themes = {
	Default = {
		Background = Color3.fromRGB(30, 30, 35),
		Foreground = Color3.fromRGB(40, 40, 45),
		Accent = Color3.fromRGB(113, 47, 169), -- Purple accent
		Secondary = Color3.fromRGB(45, 45, 50),
		Success = Color3.fromRGB(72, 199, 142),
		Warning = Color3.fromRGB(255, 184, 48),
		Danger = Color3.fromRGB(235, 59, 90),
		TextColor = Color3.fromRGB(235, 235, 235),
		BorderColor = Color3.fromRGB(60, 60, 65),
	},
	Light = {
		Background = Color3.fromRGB(240, 240, 245),
		Foreground = Color3.fromRGB(250, 250, 255),
		Accent = Color3.fromRGB(113, 47, 169), -- Purple accent
		Secondary = Color3.fromRGB(225, 225, 230),
		Success = Color3.fromRGB(72, 199, 142),
		Warning = Color3.fromRGB(255, 184, 48),
		Danger = Color3.fromRGB(235, 59, 90),
		TextColor = Color3.fromRGB(50, 50, 55),
		BorderColor = Color3.fromRGB(200, 200, 205),
	},
	Dark = {
		Background = Color3.fromRGB(20, 20, 25),
		Foreground = Color3.fromRGB(30, 30, 35),
		Accent = Color3.fromRGB(113, 47, 169), -- Purple accent
		Secondary = Color3.fromRGB(35, 35, 40),
		Success = Color3.fromRGB(72, 199, 142),
		Warning = Color3.fromRGB(255, 184, 48),
		Danger = Color3.fromRGB(235, 59, 90),
		TextColor = Color3.fromRGB(235, 235, 235),
		BorderColor = Color3.fromRGB(50, 50, 55),
	},
	Midnight = {
		Background = Color3.fromRGB(15, 15, 25),
		Foreground = Color3.fromRGB(25, 25, 35),
		Accent = Color3.fromRGB(130, 60, 200), -- Brighter purple
		Secondary = Color3.fromRGB(30, 30, 45),
		Success = Color3.fromRGB(72, 199, 142),
		Warning = Color3.fromRGB(255, 184, 48),
		Danger = Color3.fromRGB(235, 59, 90),
		TextColor = Color3.fromRGB(235, 235, 235),
		BorderColor = Color3.fromRGB(40, 40, 60),
	},
}

-- Current theme
Library.CurrentTheme = "Midnight"

-- Create a new window
function Library:CreateWindow(title, theme, size)
	local window = {}
	setmetatable(window, self)
	
	-- Default size
	size = size or {width = 550, height = 350}
	
	-- Create ScreenGui
	window.ScreenGui = Instance.new("ScreenGui")
	window.ScreenGui.Name = "MafuyoshiLib"
	window.ScreenGui.ResetOnSpawn = false
	window.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	-- Set parent based on environment
	if syn and syn.protect_gui then
		syn.protect_gui(window.ScreenGui)
		window.ScreenGui.Parent = game:GetService("CoreGui")
	elseif gethui then
		window.ScreenGui.Parent = gethui()
	elseif game:GetService("RunService"):IsStudio() then
		window.ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	else
		window.ScreenGui.Parent = game:GetService("CoreGui")
	end
	
	-- Create main frame
	window.MainFrame = Instance.new("Frame")
	window.MainFrame.Name = "MainFrame"
	window.MainFrame.Size = UDim2.new(0, size.width, 0, size.height)
	window.MainFrame.Position = UDim2.new(0.5, -size.width/2, 0.5, -size.height/2)
	window.MainFrame.BackgroundColor3 = self.Themes[theme or self.CurrentTheme].Background
	window.MainFrame.BorderSizePixel = 0
	window.MainFrame.Active = true
	window.MainFrame.Draggable = true
	window.MainFrame.Parent = window.ScreenGui
	
	-- Add corner radius
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = window.MainFrame
	
	-- Add drop shadow
	local shadow = Instance.new("ImageLabel")
	shadow.Name = "Shadow"
	shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	shadow.BackgroundTransparency = 1
	shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	shadow.Size = UDim2.new(1, 30, 1, 30)
	shadow.ZIndex = -1
	shadow.Image = "rbxassetid://6014261993"
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ImageTransparency = 0.5
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(49, 49, 450, 450)
	shadow.Parent = window.MainFrame
	
	-- Create title bar
	window.TitleBar = Instance.new("Frame")
	window.TitleBar.Name = "TitleBar"
	window.TitleBar.Size = UDim2.new(1, 0, 0, 35)
	window.TitleBar.BackgroundColor3 = self.Themes[theme or self.CurrentTheme].Accent
	window.TitleBar.BorderSizePixel = 0
	window.TitleBar.Parent = window.MainFrame
	
	-- Add corner radius to title bar
	local titleCorner = Instance.new("UICorner")
	titleCorner.CornerRadius = UDim.new(0, 8)
	titleCorner.Parent = window.TitleBar
	
	-- Fix the bottom corners of title bar
	local bottomFix = Instance.new("Frame")
	bottomFix.Name = "BottomFix"
	bottomFix.Size = UDim2.new(1, 0, 0, 10)
	bottomFix.Position = UDim2.new(0, 0, 1, -10)
	bottomFix.BackgroundColor3 = self.Themes[theme or self.CurrentTheme].Accent
	bottomFix.BorderSizePixel = 0
	bottomFix.ZIndex = 0
	bottomFix.Parent = window.TitleBar
	
	-- Logo
	local logoContainer = Instance.new("Frame")
	logoContainer.Name = "LogoContainer"
	logoContainer.Size = UDim2.new(0, 25, 0, 25)
	logoContainer.Position = UDim2.new(0, 10, 0, 5)
	logoContainer.BackgroundTransparency = 1
	logoContainer.Parent = window.TitleBar
	
	local logo = Instance.new("TextLabel")
	logo.Name = "Logo"
	logo.Size = UDim2.new(1, 0, 1, 0)
	logo.BackgroundTransparency = 1
	logo.Text = "⚡" -- Lightning bolt as logo
	logo.TextColor3 = Color3.fromRGB(255, 255, 255)
	logo.TextSize = 18
	logo.Font = Enum.Font.GothamBold
	logo.Parent = logoContainer
	
	-- Title text
	local titleText = Instance.new("TextLabel")
	titleText.Name = "Title"
	titleText.Size = UDim2.new(1, -100, 1, 0)
	titleText.Position = UDim2.new(0, 45, 0, 0)
	titleText.BackgroundTransparency = 1
	titleText.Text = title or "Mafuyoshi UI"
	titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleText.TextSize = 16
	titleText.Font = Enum.Font.GothamBold
	titleText.TextXAlignment = Enum.TextXAlignment.Left
	titleText.Parent = window.TitleBar
	
	-- Minimize button
	local minimizeButton = Instance.new("TextButton")
	minimizeButton.Name = "MinimizeButton"
	minimizeButton.Size = UDim2.new(0, 35, 0, 35)
	minimizeButton.Position = UDim2.new(1, -70, 0, 0)
	minimizeButton.BackgroundTransparency = 1
	minimizeButton.Text = "−"
	minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimizeButton.TextSize = 20
	minimizeButton.Font = Enum.Font.GothamBold
	minimizeButton.Parent = window.TitleBar
	
	-- Close button
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 35, 0, 35)
	closeButton.Position = UDim2.new(1, -35, 0, 0)
	closeButton.BackgroundTransparency = 1
	closeButton.Text = "✕"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.TextSize = 16
	closeButton.Font = Enum.Font.GothamBold
	closeButton.Parent = window.TitleBar
	
	-- Content frame
	window.ContentFrame = Instance.new("Frame")
	window.ContentFrame.Name = "Content"
	window.ContentFrame.Size = UDim2.new(1, -20, 1, -45)
	window.ContentFrame.Position = UDim2.new(0, 10, 0, 40)
	window.ContentFrame.BackgroundTransparency = 1
	window.ContentFrame.Parent = window.MainFrame
	
	-- Tab system
	window.TabButtons = Instance.new("Frame")
	window.TabButtons.Name = "TabButtons"
	window.TabButtons.Size = UDim2.new(1, 0, 0, 35)
	window.TabButtons.BackgroundTransparency = 1
	window.TabButtons.Parent = window.ContentFrame
	
	local tabsLayout = Instance.new("UIListLayout")
	tabsLayout.FillDirection = Enum.FillDirection.Horizontal
	tabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabsLayout.Padding = UDim.new(0, 5)
	tabsLayout.Parent = window.TabButtons
	
	window.TabContent = Instance.new("Frame")
	window.TabContent.Name = "TabContent"
	window.TabContent.Size = UDim2.new(1, 0, 1, -40)
	window.TabContent.Position = UDim2.new(0, 0, 0, 40)
	window.TabContent.BackgroundTransparency = 1
	window.TabContent.Parent = window.ContentFrame
	
	-- Notification frame
	window.NotificationFrame = Instance.new("Frame")
	window.NotificationFrame.Name = "Notifications"
	window.NotificationFrame.Size = UDim2.new(0, 250, 1, 0)
	window.NotificationFrame.Position = UDim2.new(1, 10, 0, 0)
	window.NotificationFrame.BackgroundTransparency = 1
	window.NotificationFrame.Parent = window.MainFrame
	
	local notificationLayout = Instance.new("UIListLayout")
	notificationLayout.FillDirection = Enum.FillDirection.Vertical
	notificationLayout.SortOrder = Enum.SortOrder.LayoutOrder
	notificationLayout.Padding = UDim.new(0, 5)
	notificationLayout.Parent = window.NotificationFrame
	
	-- Minimize functionality
	local minimized = false
	minimizeButton.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			window.MainFrame:TweenSize(
				UDim2.new(0, size.width, 0, 35),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quart,
				0.3,
				true
			)
			minimizeButton.Text = "+"
		else
			window.MainFrame:TweenSize(
				UDim2.new(0, size.width, 0, size.height),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quart,
				0.3,
				true
			)
			minimizeButton.Text = "−"
		end
	end)
	
	-- Close button functionality
	closeButton.MouseButton1Click:Connect(function()
		window.ScreenGui:Destroy()
	end)
	
	-- Initialize tabs
	window.Tabs = {}
	window.CurrentTab = nil
	window.Theme = theme or self.CurrentTheme
	
	-- Create Tab method
	function window:CreateTab(name, icon)
		local tab = {}
		
		tab.Button = Instance.new("TextButton")
		tab.Button.Name = name.."Tab"
		tab.Button.Size = UDim2.new(0, 120, 1, 0)
		tab.Button.BackgroundColor3 = Library.Themes[self.Theme].Secondary
		tab.Button.BorderSizePixel = 0
		tab.Button.Text = name
		tab.Button.TextColor3 = Library.Themes[self.Theme].TextColor
		tab.Button.TextSize = 14
		tab.Button.Font = Enum.Font.GothamSemibold
		tab.Button.Parent = self.TabButtons
		
		-- Add corner radius
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = tab.Button
		
		-- Add icon if provided
		if icon then
			local iconLabel = Instance.new("TextLabel")
			iconLabel.Name = "Icon"
			iconLabel.Size = UDim2.new(0, 20, 0, 20)
			iconLabel.Position = UDim2.new(0, 10, 0.5, -10)
			iconLabel.BackgroundTransparency = 1
			iconLabel.Text = icon
			iconLabel.TextColor3 = Library.Themes[self.Theme].TextColor
			iconLabel.TextSize = 16
			iconLabel.Font = Enum.Font.GothamBold
			iconLabel.Parent = tab.Button
			
			-- Adjust text position
			tab.Button.Text = "   " .. name
		end
		
		tab.Content = Instance.new("ScrollingFrame")
		tab.Content.Name = name.."Content"
		tab.Content.Size = UDim2.new(1, 0, 1, 0)
		tab.Content.BackgroundTransparency = 1
		tab.Content.BorderSizePixel = 0
		tab.Content.ScrollBarThickness = 4
		tab.Content.ScrollBarImageColor3 = Library.Themes[self.Theme].Accent
		tab.Content.Visible = false
		tab.Content.Parent = self.TabContent
		
		local elementsLayout = Instance.new("UIListLayout")
		elementsLayout.FillDirection = Enum.FillDirection.Vertical
		elementsLayout.SortOrder = Enum.SortOrder.LayoutOrder
		elementsLayout.Padding = UDim.new(0, 8)
		elementsLayout.Parent = tab.Content
		
		local padding = Instance.new("UIPadding")
		padding.PaddingTop = UDim.new(0, 5)
		padding.PaddingLeft = UDim.new(0, 5)
		padding.PaddingRight = UDim.new(0, 5)
		padding.PaddingBottom = UDim.new(0, 5)
		padding.Parent = tab.Content
		
		-- Auto-size content
		elementsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			tab.Content.CanvasSize = UDim2.new(0, 0, 0, elementsLayout.AbsoluteContentSize.Y + 10)
		end)
		
		self.Tabs[name] = tab
		
		-- Tab button functionality
		tab.Button.MouseButton1Click:Connect(function()
			self:SelectTab(name)
		end)
		
		-- Select this tab if it's the first one
		if not self.CurrentTab then
			self:SelectTab(name)
		end
		
		-- Create UI elements
		function tab:CreateButton(text, callback)
			local button = Instance.new("TextButton")
			button.Name = text.."Button"
			button.Size = UDim2.new(1, 0, 0, 36)
			button.BackgroundColor3 = Library.Themes[window.Theme].Secondary
			button.BorderSizePixel = 0
			button.Text = text
			button.TextColor3 = Library.Themes[window.Theme].TextColor
			button.TextSize = 14
			button.Font = Enum.Font.GothamSemibold
			button.Parent = self.Content
			
			-- Add corner radius
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = button
			
			-- Add hover effect
			local originalColor = Library.Themes[window.Theme].Secondary
			local hoverColor = Color3.fromRGB(
				math.min(originalColor.R * 255 + 15, 255),
				math.min(originalColor.G * 255 + 15, 255),
				math.min(originalColor.B * 255 + 15, 255)
			)
			
			button.MouseEnter:Connect(function()
				button:TweenBackgroundColor3(hoverColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			button.MouseLeave:Connect(function()
				button:TweenBackgroundColor3(originalColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			-- Button functionality
			button.MouseButton1Click:Connect(function()
				if callback then
					callback()
				end
			end)
			
			return button
		end
		
		function tab:CreateLabel(text)
			local label = Instance.new("TextLabel")
			label.Name = "Label"
			label.Size = UDim2.new(1, 0, 0, 25)
			label.BackgroundTransparency = 1
			label.Text = text
			label.TextColor3 = Library.Themes[window.Theme].TextColor
			label.TextSize = 14
			label.Font = Enum.Font.GothamSemibold
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = self.Content
			
			return label
		end
		
		function tab:CreateToggle(text, default, callback)
			local toggleFrame = Instance.new("Frame")
			toggleFrame.Name = text.."Toggle"
			toggleFrame.Size = UDim2.new(1, 0, 0, 36)
			toggleFrame.BackgroundColor3 = Library.Themes[window.Theme].Secondary
			toggleFrame.BorderSizePixel = 0
			toggleFrame.Parent = self.Content
			
			-- Add corner radius
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = toggleFrame
			
			local toggleLabel = Instance.new("TextLabel")
			toggleLabel.Name = "Label"
			toggleLabel.Size = UDim2.new(1, -60, 1, 0)
			toggleLabel.Position = UDim2.new(0, 12, 0, 0)
			toggleLabel.BackgroundTransparency = 1
			toggleLabel.Text = text
			toggleLabel.TextColor3 = Library.Themes[window.Theme].TextColor
			toggleLabel.TextSize = 14
			toggleLabel.Font = Enum.Font.GothamSemibold
			toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			toggleLabel.Parent = toggleFrame
			
			local toggleButton = Instance.new("Frame")
			toggleButton.Name = "ToggleButton"
			toggleButton.Size = UDim2.new(0, 44, 0, 22)
			toggleButton.Position = UDim2.new(1, -52, 0.5, -11)
			toggleButton.BackgroundColor3 = default and Library.Themes[window.Theme].Accent or Library.Themes[window.Theme].BorderColor
			toggleButton.BorderSizePixel = 0
			toggleButton.Parent = toggleFrame
			
			-- Add corner radius to toggle button
			local toggleCorner = Instance.new("UICorner")
			toggleCorner.CornerRadius = UDim.new(1, 0)
			toggleCorner.Parent = toggleButton
			
			local toggleIndicator = Instance.new("Frame")
			toggleIndicator.Name = "Indicator"
			toggleIndicator.Size = UDim2.new(0, 18, 0, 18)
			toggleIndicator.Position = UDim2.new(default and 1 or 0, default and -20 or 2, 0.5, -9)
			toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			toggleIndicator.BorderSizePixel = 0
			toggleIndicator.Parent = toggleButton
			
			-- Add corner radius to indicator
			local indicatorCorner = Instance.new("UICorner")
			indicatorCorner.CornerRadius = UDim.new(1, 0)
			indicatorCorner.Parent = toggleIndicator
			
			-- Add hover effect
			local originalColor = Library.Themes[window.Theme].Secondary
			local hoverColor = Color3.fromRGB(
				math.min(originalColor.R * 255 + 15, 255),
				math.min(originalColor.G * 255 + 15, 255),
				math.min(originalColor.B * 255 + 15, 255)
			)
			
			toggleFrame.MouseEnter:Connect(function()
				toggleFrame:TweenBackgroundColor3(hoverColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			toggleFrame.MouseLeave:Connect(function()
				toggleFrame:TweenBackgroundColor3(originalColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			local toggled = default or false
			
			-- Toggle functionality
			toggleFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					toggled = not toggled
					toggleButton:TweenBackgroundColor3(
						toggled and Library.Themes[window.Theme].Accent or Library.Themes[window.Theme].BorderColor,
						Enum.EasingDirection.Out,
						Enum.EasingStyle.Quad,
						0.2,
						true
					)
					toggleIndicator:TweenPosition(
						UDim2.new(toggled and 1 or 0, toggled and -20 or 2, 0.5, -9),
						Enum.EasingDirection.InOut,
						Enum.EasingStyle.Quad,
						0.2,
						true
					)
					if callback then
						callback(toggled)
					end
				end
			end)

      
			return {
				Frame = toggleFrame,
				Value = function() return toggled end,
				Set = function(value)
					toggled = value
					toggleButton.BackgroundColor3 = toggled and Library.Themes[window.Theme].Accent or Library.Themes[window.Theme].BorderColor
					toggleIndicator.Position = UDim2.new(toggled and 1 or 0, toggled and -20 or 2, 0.5, -9)
					if callback then
						callback(toggled)
					end
				end
			}
		end
		
		function tab:CreateSlider(text, min, max, default, callback)
			local sliderFrame = Instance.new("Frame")
			sliderFrame.Name = text.."Slider"
			sliderFrame.Size = UDim2.new(1, 0, 0, 55)
			sliderFrame.BackgroundColor3 = Library.Themes[window.Theme].Secondary
			sliderFrame.BorderSizePixel = 0
			sliderFrame.Parent = self.Content
			
			-- Add corner radius
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = sliderFrame
			
			local sliderLabel = Instance.new("TextLabel")
			sliderLabel.Name = "Label"
			sliderLabel.Size = UDim2.new(1, -70, 0, 25)
			sliderLabel.Position = UDim2.new(0, 12, 0, 5)
			sliderLabel.BackgroundTransparency = 1
			sliderLabel.Text = text
			sliderLabel.TextColor3 = Library.Themes[window.Theme].TextColor
			sliderLabel.TextSize = 14
			sliderLabel.Font = Enum.Font.GothamSemibold
			sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			sliderLabel.Parent = sliderFrame
			
			local valueLabel = Instance.new("TextLabel")
			valueLabel.Name = "Value"
			valueLabel.Size = UDim2.new(0, 60, 0, 25)
			valueLabel.Position = UDim2.new(1, -70, 0, 5)
			valueLabel.BackgroundTransparency = 1
			valueLabel.Text = tostring(default)
			valueLabel.TextColor3 = Library.Themes[window.Theme].TextColor
			valueLabel.TextSize = 14
			valueLabel.Font = Enum.Font.GothamSemibold
			valueLabel.TextXAlignment = Enum.TextXAlignment.Right
			valueLabel.Parent = sliderFrame
			
			local sliderBg = Instance.new("Frame")
			sliderBg.Name = "Background"
			sliderBg.Size = UDim2.new(1, -24, 0, 6)
			sliderBg.Position = UDim2.new(0, 12, 0, 38)
			sliderBg.BackgroundColor3 = Library.Themes[window.Theme].BorderColor
			sliderBg.BorderSizePixel = 0
			sliderBg.Parent = sliderFrame
			
			-- Add corner radius to slider background
			local bgCorner = Instance.new("UICorner")
			bgCorner.CornerRadius = UDim.new(1, 0)
			bgCorner.Parent = sliderBg
			
			local sliderFill = Instance.new("Frame")
			sliderFill.Name = "Fill"
			sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			sliderFill.BackgroundColor3 = Library.Themes[window.Theme].Accent
			sliderFill.BorderSizePixel = 0
			sliderFill.Parent = sliderBg
			
			-- Add corner radius to slider fill
			local fillCorner = Instance.new("UICorner")
			fillCorner.CornerRadius = UDim.new(1, 0)
			fillCorner.Parent = sliderFill
			
			local sliderButton = Instance.new("TextButton")
			sliderButton.Name = "Button"
			sliderButton.Size = UDim2.new(0, 16, 0, 16)
			sliderButton.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
			sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sliderButton.BorderSizePixel = 0
			sliderButton.Text = ""
			sliderButton.Parent = sliderBg
			
			-- Add corner radius to slider button
			local buttonCorner = Instance.new("UICorner")
			buttonCorner.CornerRadius = UDim.new(1, 0)
			buttonCorner.Parent = sliderButton
			
			-- Add hover effect
			local originalColor = Library.Themes[window.Theme].Secondary
			local hoverColor = Color3.fromRGB(
				math.min(originalColor.R * 255 + 15, 255),
				math.min(originalColor.G * 255 + 15, 255),
				math.min(originalColor.B * 255 + 15, 255)
			)
			
			sliderFrame.MouseEnter:Connect(function()
				sliderFrame:TweenBackgroundColor3(hoverColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			sliderFrame.MouseLeave:Connect(function()
				sliderFrame:TweenBackgroundColor3(originalColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			local value = default
			local dragging  Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			local value = default
			local dragging = false
			
			local function updateSlider(input)
				local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
				local newValue = math.floor(min + (max - min) * pos)
				
				value = newValue
				valueLabel.Text = tostring(value)
				sliderFill:TweenSize(
					UDim2.new(pos, 0, 1, 0),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quad,
					0.1,
					true
				)
				sliderButton:TweenPosition(
					UDim2.new(pos, -8, 0.5, -8),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quad,
					0.1,
					true
				)
				
				if callback then
					callback(value)
				end
			end
			
			sliderButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)
			
			sliderButton.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)
			
			sliderBg.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					updateSlider(input)
					dragging = true
				end
			end)
			
			sliderBg.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)
			
			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateSlider(input)
				end
			end)
			
			return {
				Frame = sliderFrame,
				Value = function() return value end,
				Set = function(newValue)
					value = math.clamp(newValue, min, max)
					local pos = (value - min) / (max - min)
					valueLabel.Text = tostring(value)
					sliderFill.Size = UDim2.new(pos, 0, 1, 0)
					sliderButton.Position = UDim2.new(pos, -8, 0.5, -8)
					if callback then
						callback(value)
					end
				end
			}
		end
		
		function tab:CreateDropdown(text, options, default, callback)
			local dropdownFrame = Instance.new("Frame")
			dropdownFrame.Name = text.."Dropdown"
			dropdownFrame.Size = UDim2.new(1, 0, 0, 36)
			dropdownFrame.BackgroundColor3 = Library.Themes[window.Theme].Secondary
			dropdownFrame.BorderSizePixel = 0
			dropdownFrame.Parent = self.Content
			
			-- Add corner radius
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = dropdownFrame
			
			local dropdownLabel = Instance.new("TextLabel")
			dropdownLabel.Name = "Label"
			dropdownLabel.Size = UDim2.new(0.5, -10, 1, 0)
			dropdownLabel.Position = UDim2.new(0, 12, 0, 0)
			dropdownLabel.BackgroundTransparency = 1
			dropdownLabel.Text = text
			dropdownLabel.TextColor3 = Library.Themes[window.Theme].TextColor
			dropdownLabel.TextSize = 14
			dropdownLabel.Font = Enum.Font.GothamSemibold
			dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
			dropdownLabel.Parent = dropdownFrame
			
			local dropdownButton = Instance.new("TextButton")
			dropdownButton.Name = "Button"
			dropdownButton.Size = UDim2.new(0.5, -10, 1, -8)
			dropdownButton.Position = UDim2.new(0.5, 0, 0, 4)
			dropdownButton.BackgroundColor3 = Library.Themes[window.Theme].Background
			dropdownButton.BorderSizePixel = 0
			dropdownButton.Text = default or options[1] or "Select"
			dropdownButton.TextColor3 = Library.Themes[window.Theme].TextColor
			dropdownButton.TextSize = 14
			dropdownButton.Font = Enum.Font.Gotham
			dropdownButton.Parent = dropdownFrame
			
			-- Add corner radius to dropdown button
			local buttonCorner = Instance.new("UICorner")
			buttonCorner.CornerRadius = UDim.new(0, 6)
			buttonCorner.Parent = dropdownButton
			
			local dropdownIcon = Instance.new("TextLabel")
			dropdownIcon.Name = "Icon"
			dropdownIcon.Size = UDim2.new(0, 20, 0, 20)
			dropdownIcon.Position = UDim2.new(1, -25, 0.5, -10)
			dropdownIcon.BackgroundTransparency = 1
			dropdownIcon.Text = "▼"
			dropdownIcon.TextColor3 = Library.Themes[window.Theme].TextColor
			dropdownIcon.TextSize = 12
			dropdownIcon.Font = Enum.Font.Gotham
			dropdownIcon.Parent = dropdownButton
			
			local dropdownMenu = Instance.new("Frame")
			dropdownMenu.Name = "Menu"
			dropdownMenu.Size = UDim2.new(0.5, -10, 0, #options * 32)
			dropdownMenu.Position = UDim2.new(0.5, 0, 1, 5)
			dropdownMenu.BackgroundColor3 = Library.Themes[window.Theme].Background
			dropdownMenu.BorderSizePixel = 0
			dropdownMenu.Visible = false
			dropdownMenu.ZIndex = 10
			dropdownMenu.Parent = dropdownFrame
			
			-- Add corner radius to dropdown menu
			local menuCorner = Instance.new("UICorner")
			menuCorner.CornerRadius = UDim.new(0, 6)
			menuCorner.Parent = dropdownMenu
			
			-- Add shadow to dropdown menu
			local menuShadow = Instance.new("ImageLabel")
			menuShadow.Name = "Shadow"
			menuShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			menuShadow.BackgroundTransparency = 1
			menuShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			menuShadow.Size = UDim2.new(1, 20, 1, 20)
			menuShadow.ZIndex = 9
			menuShadow.Image = "rbxassetid://6014261993"
			menuShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			menuShadow.ImageTransparency = 0.6
			menuShadow.ScaleType = Enum.ScaleType.Slice
			menuShadow.SliceCenter = Rect.new(49, 49, 450, 450)
			menuShadow.Parent = dropdownMenu
			
			local menuLayout = Instance.new("UIListLayout")
			menuLayout.FillDirection = Enum.FillDirection.Vertical
			menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
			menuLayout.Padding = UDim.new(0, 0)
			menuLayout.Parent = dropdownMenu
			
			-- Add hover effect
			local originalColor = Library.Themes[window.Theme].Secondary
			local hoverColor = Color3.fromRGB(
				math.min(originalColor.R * 255 + 15, 255),
				math.min(originalColor.G * 255 + 15, 255),
				math.min(originalColor.B * 255 + 15, 255)
			)
			
			dropdownFrame.MouseEnter:Connect(function()
				dropdownFrame:TweenBackgroundColor3(hoverColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			dropdownFrame.MouseLeave:Connect(function()
				dropdownFrame:TweenBackgroundColor3(originalColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			local selectedOption = default or options[1] or "Select"
			
			for i, option in ipairs(options) do
				local optionButton = Instance.new("TextButton")
				optionButton.Name = option.."Option"
				optionButton.Size = UDim2.new(1, 0, 0, 32)
				optionButton.BackgroundTransparency = 1
				optionButton.Text = option
				optionButton.TextColor3 = Library.Themes[window.Theme].TextColor
				optionButton.TextSize = 14
				optionButton.Font = Enum.Font.Gotham
				optionButton.ZIndex = 10
				optionButton.Parent = dropdownMenu
				
				-- Add hover effect for option
				optionButton.MouseEnter:Connect(function()
					optionButton.BackgroundTransparency = 0.8
					optionButton.BackgroundColor3 = Library.Themes[window.Theme].Accent
				end)
				
				optionButton.MouseLeave:Connect(function()
					optionButton.BackgroundTransparency = 1
				end)
				
				optionButton.MouseButton1Click:Connect(function()
					selectedOption = option
					dropdownButton.Text = option
					dropdownMenu.Visible = false
					dropdownIcon.Text = "▼"
					if callback then
						callback(option)
					end
				end)
			end
			
			dropdownButton.MouseButton1Click:Connect(function()
				dropdownMenu.Visible = not dropdownMenu.Visible
				dropdownIcon.Text = dropdownMenu.Visible and "▲" or "▼"
			end)
			
			-- Close dropdown when clicking elsewhere
			game:GetService("UserInputService").InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local mousePos = game:GetService("UserInputService"):GetMouseLocation()
					local dropdownPos = dropdownMenu.AbsolutePosition
					local dropdownSize = dropdownMenu.AbsoluteSize
					
					if mousePos.X < dropdownPos.X or mousePos.X > dropdownPos.X + dropdownSize.X or
					   mousePos.Y < dropdownPos.Y or mousePos.Y > dropdownPos.Y + dropdownSize.Y then
						if dropdownMenu.Visible then
							dropdownMenu.Visible = false
							dropdownIcon.Text = "▼"
						end
					end
				end
			end)
			
			return {
				Frame = dropdownFrame,
				Value = function() return selectedOption end,
				Set = function(option)
					if table.find(options, option) then
						selectedOption = option
						dropdownButton.Text = option
						if callback then
							callback(option)
						end
					end
				end
			}
		end
		
		function tab:CreateTextBox(text, placeholder, default, callback)
			local textboxFrame = Instance.new("Frame")
			textboxFrame.Name = text.."TextBox"
			textboxFrame.Size = UDim2.new(1, 0, 0, 36)
			textboxFrame.BackgroundColor3 = Library.Themes[window.Theme].Secondary
			textboxFrame.BorderSizePixel = 0
			textboxFrame.Parent = self.Content
			
			-- Add corner radius
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = textboxFrame
			
			local textboxLabel = Instance.new("TextLabel")
			textboxLabel.Name = "Label"
			textboxLabel.Size = UDim2.new(0.4, -10, 1, 0)
			textboxLabel.Position = UDim2.new(0, 12, 0, 0)
			textboxLabel.BackgroundTransparency = 1
			textboxLabel.Text = text
			textboxLabel.TextColor3 = Library.Themes[window.Theme].TextColor
			textboxLabel.TextSize = 14
			textboxLabel.Font = Enum.Font.GothamSemibold
			textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
			textboxLabel.Parent = textboxFrame
			
			local textBox = Instance.new("TextBox")
			textBox.Name = "TextBox"
			textBox.Size = UDim2.new(0.6, -10, 1, -8)
			textBox.Position = UDim2.new(0.4, 0, 0, 4)
			textBox.BackgroundColor3 = Library.Themes[window.Theme].Background
			textBox.BorderSizePixel = 0
			textBox.Text = default or ""
			textBox.PlaceholderText = placeholder or "Enter text..."
			textBox.TextColor3 = Library.Themes[window.Theme].TextColor
			textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
			textBox.TextSize = 14
			textBox.Font = Enum.Font.Gotham
			textBox.ClearTextOnFocus = false
			textBox.Parent = textboxFrame
			
			-- Add corner radius to text box
			local boxCorner = Instance.new("UICorner")
			boxCorner.CornerRadius = UDim.new(0, 6)
			boxCorner.Parent = textBox
			
			-- Add hover effect
			local originalColor = Library.Themes[window.Theme].Secondary
			local hoverColor = Color3.fromRGB(
				math.min(originalColor.R * 255 + 15, 255),
				math.min(originalColor.G * 255 + 15, 255),
				math.min(originalColor.B * 255 + 15, 255)
			)
			
			textboxFrame.MouseEnter:Connect(function()
				textboxFrame:TweenBackgroundColor3(hoverColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			textboxFrame.MouseLeave:Connect(function()
				textboxFrame:TweenBackgroundColor3(originalColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			textBox.Focused:Connect(function()
				textBox:TweenBackgroundColor3(
					Library.Themes[window.Theme].Foreground,
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quad,
					0.2,
					true
				)
			end)
			
			textBox.FocusLost:Connect(function(enterPressed)
				textBox:TweenBackgroundColor3(
					Library.Themes[window.Theme].Background,
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quad,
					0.2,
					true
				)
				if callback then
					callback(textBox.Text, enterPressed)
				end
			end)
			
			return {
				Frame = textboxFrame,
				Value = function() return textBox.Text end,
				Set = function(value)
					textBox.Text = value
					if callback then
						callback(value, false)
					end
				end
			}
		end
		
		function tab:CreateCodeBox(text, placeholder, default, callback)
			local codeFrame = Instance.new("Frame")
			codeFrame.Name = text.."CodeBox"
			codeFrame.Size = UDim2.new(1, 0, 0, 150)
			codeFrame.BackgroundColor3 = Library.Themes[window.Theme].Secondary
			codeFrame.BorderSizePixel = 0
			codeFrame.Parent = self.Content
			
			-- Add corner radius
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = codeFrame
			
			local codeLabel = Instance.new("TextLabel")
			codeLabel.Name = "Label"
			codeLabel.Size = UDim2.new(1, -20, 0, 25)
			codeLabel.Position = UDim2.new(0, 12, 0, 5)
			codeLabel.BackgroundTransparency = 1
			codeLabel.Text = text
			codeLabel.TextColor3 = Library.Themes[window.Theme].TextColor
			codeLabel.TextSize = 14
			codeLabel.Font = Enum.Font.GothamSemibold
			codeLabel.TextXAlignment = Enum.TextXAlignment.Left
			codeLabel.Parent = codeFrame
			
			local codeBox = Instance.new("TextBox")
			codeBox.Name = "CodeBox"
			codeBox.Size = UDim2.new(1, -20, 0, 110)
			codeBox.Position = UDim2.new(0, 10, 0, 30)
			codeBox.BackgroundColor3 = Library.Themes[window.Theme].Background
			codeBox.BorderSizePixel = 0
			codeBox.Text = default or ""
			codeBox.PlaceholderText = placeholder or "Enter code here..."
			codeBox.TextColor3 = Library.Themes[window.Theme].TextColor
			codeBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
			codeBox.TextSize = 14
			codeBox.Font = Enum.Font.Code
			codeBox.ClearTextOnFocus = false
			codeBox.MultiLine = true
			codeBox.TextXAlignment = Enum.TextXAlignment.Left
			codeBox.TextYAlignment = Enum.TextYAlignment.Top
			codeBox.Parent = codeFrame
			
			-- Add corner radius to code box
			local boxCorner = Instance.new("UICorner")
			boxCorner.CornerRadius = UDim.new(0, 6)
			boxCorner.Parent = codeBox
			
			-- Add hover effect
			local originalColor = Library.Themes[window.Theme].Secondary
			local hoverColor = Color3.fromRGB(
				math.min(originalColor.R * 255 + 15, 255),
				math.min(originalColor.G * 255 + 15, 255),
				math.min(originalColor.B * 255 + 15, 255)
			)
			
			codeFrame.MouseEnter:Connect(function()
				codeFrame:TweenBackgroundColor3(hoverColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			codeFrame.MouseLeave:Connect(function()
				codeFrame:TweenBackgroundColor3(originalColor, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			
			codeBox.Focused:Connect(function()
				codeBox:TweenBackgroundColor3(
					Library.Themes[window.Theme].Foreground,
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quad,
					0.2,
					true
				)
			end)

      codeBox.FocusLost:Connect(function(enterPressed)
				codeBox:TweenBackgroundColor3(
					Library.Themes[window.Theme].Background,
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quad,
					0.2,
					true
				)
				if callback then
					callback(codeBox.Text, enterPressed)
				end
			end)
			
			return {
				Frame = codeFrame,
				Value = function() return codeBox.Text end,
				Set = function(value)
					codeBox.Text = value
					if callback then
						callback(value, false)
					end
				end
			}
		end
		
		return tab
	end
	
	-- Select a tab
	function window:SelectTab(name)
		if self.CurrentTab then
			self.Tabs[self.CurrentTab].Button.BackgroundColor3 = Library.Themes[self.Theme].Secondary
			self.Tabs[self.CurrentTab].Content.Visible = false
		end
		
		self.Tabs[name].Button.BackgroundColor3 = Library.Themes[self.Theme].Accent
		self.Tabs[name].Content.Visible = true
		self.CurrentTab = name
	end
	
	-- Show a notification
	function window:ShowNotification(title, message, type, duration)
		type = type or "info"
		duration = duration or 5
		
		local colors = {
			info = Library.Themes[self.Theme].Accent,
			success = Library.Themes[self.Theme].Success,
			warning = Library.Themes[self.Theme].Warning,
			error = Library.Themes[self.Theme].Danger
		}
		
		local notification = Instance.new("Frame")
		notification.Name = "Notification"
		notification.Size = UDim2.new(1, 0, 0, 80)
		notification.BackgroundColor3 = colors[type]
		notification.BorderSizePixel = 0
		notification.Position = UDim2.new(1, 0, 0, 0)
		notification.Parent = self.NotificationFrame
		
		-- Add corner radius
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 8)
		corner.Parent = notification
		
		-- Add shadow
		local shadow = Instance.new("ImageLabel")
		shadow.Name = "Shadow"
		shadow.AnchorPoint = Vector2.new(0.5, 0.5)
		shadow.BackgroundTransparency = 1
		shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
		shadow.Size = UDim2.new(1, 20, 1, 20)
		shadow.ZIndex = -1
		shadow.Image = "rbxassetid://6014261993"
		shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		shadow.ImageTransparency = 0.6
		shadow.ScaleType = Enum.ScaleType.Slice
		shadow.SliceCenter = Rect.new(49, 49, 450, 450)
		shadow.Parent = notification
		
		-- Icon based on type
		local icons = {
			info = "ℹ️",
			success = "✓",
			warning = "⚠️",
			error = "✕"
		}
		
		local iconLabel = Instance.new("TextLabel")
		iconLabel.Name = "Icon"
		iconLabel.Size = UDim2.new(0, 24, 0, 24)
		iconLabel.Position = UDim2.new(0, 10, 0, 10)
		iconLabel.BackgroundTransparency = 1
		iconLabel.Text = icons[type]
		iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		iconLabel.TextSize = 18
		iconLabel.Font = Enum.Font.GothamBold
		iconLabel.Parent = notification
		
		local notifTitle = Instance.new("TextLabel")
		notifTitle.Name = "Title"
		notifTitle.Size = UDim2.new(1, -80, 0, 25)
		notifTitle.Position = UDim2.new(0, 44, 0, 10)
		notifTitle.BackgroundTransparency = 1
		notifTitle.Text = title
		notifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		notifTitle.TextSize = 16
		notifTitle.Font = Enum.Font.GothamBold
		notifTitle.TextXAlignment = Enum.TextXAlignment.Left
		notifTitle.Parent = notification
		
		local notifMessage = Instance.new("TextLabel")
		notifMessage.Name = "Message"
		notifMessage.Size = UDim2.new(1, -60, 0, 40)
		notifMessage.Position = UDim2.new(0, 44, 0, 35)
		notifMessage.BackgroundTransparency = 1
		notifMessage.Text = message
		notifMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
		notifMessage.TextSize = 14
		notifMessage.Font = Enum.Font.Gotham
		notifMessage.TextXAlignment = Enum.TextXAlignment.Left
		notifMessage.TextWrapped = true
		notifMessage.Parent = notification
		
		local closeButton = Instance.new("TextButton")
		closeButton.Name = "CloseButton"
		closeButton.Size = UDim2.new(0, 24, 0, 24)
		closeButton.Position = UDim2.new(1, -30, 0, 10)
		closeButton.BackgroundTransparency = 1
		closeButton.Text = "✕"
		closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		closeButton.TextSize = 14
		closeButton.Font = Enum.Font.GothamBold
		closeButton.Parent = notification
		
		-- Animate notification in
		notification:TweenPosition(
			UDim2.new(0, 0, 0, 0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quart,
			0.3,
			true
		)
		
		-- Close button functionality
		closeButton.MouseButton1Click:Connect(function()
			notification:TweenPosition(
				UDim2.new(1, 0, 0, 0),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quart,
				0.3,
				true,
				function()
					notification:Destroy()
				end
			)
		end)
		
		-- Auto close after duration
		task.delay(duration, function()
			if notification and notification.Parent then
				notification:TweenPosition(
					UDim2.new(1, 0, 0, 0),
					Enum.EasingDirection.Out,
					Enum.EasingStyle.Quart,
					0.3,
					true,
					function()
						notification:Destroy()
					end
				)
			end
		end)
		
		return notification
	end
	
	-- Execute a script using loadstring
	function window:ExecuteScript(code)
		local success, result
		
		-- Create a protected call to loadstring
		success, result = pcall(function()
			return loadstring(code)
		end)
		
		if success and result then
			-- If loadstring succeeded, try to execute the compiled function
			success, result = pcall(result)
			
			if success then
				self:ShowNotification("Success", "Script executed successfully!", "success", 3)
				return true, "Script executed successfully!"
			else
				self:ShowNotification("Error", "Runtime error: " .. tostring(result), "error", 5)
				return false, "Runtime error: " .. tostring(result)
			end
		else
			self:ShowNotification("Error", "Syntax error: " .. tostring(result), "error", 5)
			return false, "Syntax error: " .. tostring(result)
		end
	end
	
	return window
end

-- Return the library
return Library
