----------------------------------------------------------------------------------------------------
-------------- Over Emote 1.0 - Bringing the Overwatch Emote Wheel to World of Warcraft ------------
--------------             By Songzee (Cuc Flavius)(Songzhu - Argent Dawn)              ------------
----------------------------------------------------------------------------------------------------
--------------                             User Interface                               ------------
----------------------------------------------------------------------------------------------------


-------- Helper Functions --------
local s2 = sqrt(2);
local cos, sin, rad = math.cos, math.sin, math.rad;
local function CalculateCorner(angle)
	local r = rad(angle);
	return 0.5 + cos(r) / s2, 0.5 + sin(r) / s2;
end
local function RotateTexture(texture, angle)
	local LRx, LRy = CalculateCorner(angle + 45);
	local LLx, LLy = CalculateCorner(angle + 135);
	local ULx, ULy = CalculateCorner(angle + 225);
	local URx, URy = CalculateCorner(angle - 45);
	
	texture:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end

local texturePath = "Interface\\AddOns\\OverEmote\\Textures\\"
local wheelTexture = texturePath.."Wheel.blp"
local highlightTexture = texturePath.."Highlight512.blp"

--------- UI ---------

-- Dark Background
OverEmote_Background = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
OverEmote_Background:SetFrameStrata("BACKGROUND")
OverEmote_Background:SetAllPoints(UIParent)
OverEmote_Background:SetBackdrop({ bgFile = [[Interface\Buttons\WHITE8x8]], insets = {left = 3, right = 3, top = 4, bottom = 3}})
OverEmote_Background:SetBackdropColor(0, 0, 0, 0.5)
OverEmote_Background:SetPoint("CENTER",0,0)
OverEmote_Background:Hide()

-- Wheel
OverEmote_Wheel_TopLeft = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Wheel_TopLeft:SetSize(512, 512) 
OverEmote_Wheel_TopLeft:SetPoint("CENTER",-256,256) 
OverEmote_Wheel_TopLeft:SetFrameStrata("BACKGROUND")
local OverEmote_Wheel_TopLeft_Texture = OverEmote_Wheel_TopLeft:CreateTexture() 
OverEmote_Wheel_TopLeft_Texture:SetAllPoints() 
OverEmote_Wheel_TopLeft_Texture:SetTexture(wheelTexture)
OverEmote_Wheel_TopLeft.background = OverEmote_Wheel_TopLeft_Texture

OverEmote_Wheel_TopRight = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Wheel_TopRight:SetSize(512, 512) 
OverEmote_Wheel_TopRight:SetPoint("CENTER",256,256) 
OverEmote_Wheel_TopRight:SetFrameStrata("BACKGROUND")
local OverEmote_Wheel_TopRight_Texture = OverEmote_Wheel_TopRight:CreateTexture() 
OverEmote_Wheel_TopRight_Texture:SetAllPoints() 
OverEmote_Wheel_TopRight_Texture:SetTexture(wheelTexture)
OverEmote_Wheel_TopRight_Texture:SetTexCoord(1,0,0,1)
OverEmote_Wheel_TopRight.background = OverEmote_Wheel_TopRight_Texture

OverEmote_Wheel_BottomLeft = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Wheel_BottomLeft:SetSize(512, 512) 
OverEmote_Wheel_BottomLeft:SetPoint("CENTER",-256,-256) 
OverEmote_Wheel_BottomLeft:SetFrameStrata("BACKGROUND")
local OverEmote_Wheel_BottomLeft_Texture = OverEmote_Wheel_BottomLeft:CreateTexture() 
OverEmote_Wheel_BottomLeft_Texture:SetAllPoints() 
OverEmote_Wheel_BottomLeft_Texture:SetTexture(wheelTexture)
OverEmote_Wheel_BottomLeft_Texture:SetTexCoord(0,1,1,0)
OverEmote_Wheel_BottomLeft.background = OverEmote_Wheel_BottomLeft_Texture

OverEmote_Wheel_BottomRight = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Wheel_BottomRight:SetSize(512, 512) 
OverEmote_Wheel_BottomRight:SetPoint("CENTER",256,-256) 
OverEmote_Wheel_BottomRight:SetFrameStrata("BACKGROUND")
local OverEmote_Wheel_BottomRight_Texture = OverEmote_Wheel_BottomRight:CreateTexture() 
OverEmote_Wheel_BottomRight_Texture:SetAllPoints() 
OverEmote_Wheel_BottomRight_Texture:SetTexture(wheelTexture)
OverEmote_Wheel_BottomRight_Texture:SetTexCoord(1,0,1,0)
OverEmote_Wheel_BottomRight.background = OverEmote_Wheel_BottomRight_Texture



-- Highlight Area 1
OverEmote_Highlight_1 = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Highlight_1:SetSize(1080, 1080) 
OverEmote_Highlight_1:SetPoint("CENTER",-540,0) 
OverEmote_Highlight_1:SetFrameStrata("BACKGROUND")
local OverEmote_Highlight_1_Texture = OverEmote_Highlight_1:CreateTexture() 
OverEmote_Highlight_1_Texture:SetAllPoints() 
OverEmote_Highlight_1_Texture:SetTexture(highlightTexture)
OverEmote_Highlight_1.background = OverEmote_Highlight_1_Texture
OverEmote_Highlight_1:SetAlpha(0.1)
OverEmote_Highlight_1:Hide()

-- Highlight Area 2
OverEmote_Highlight_2 = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Highlight_2:SetSize(1080, 1080) 
OverEmote_Highlight_2:SetPoint("CENTER",-382,-382) 
OverEmote_Highlight_2:SetFrameStrata("BACKGROUND")
local OverEmote_Highlight_2_Texture = OverEmote_Highlight_2:CreateTexture() 
OverEmote_Highlight_2_Texture:SetAllPoints()
RotateTexture(OverEmote_Highlight_2_Texture, 45)
OverEmote_Highlight_2_Texture:SetTexture(highlightTexture)
OverEmote_Highlight_2.background = OverEmote_Highlight_2_Texture
OverEmote_Highlight_2:SetAlpha(0.1)
OverEmote_Highlight_2:Hide()

-- Highlight Area 3
OverEmote_Highlight_3 = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Highlight_3:SetSize(1080, 1080) 
OverEmote_Highlight_3:SetPoint("CENTER",0,-540) 
OverEmote_Highlight_3:SetFrameStrata("BACKGROUND")
local OverEmote_Highlight_3_Texture = OverEmote_Highlight_3:CreateTexture() 
OverEmote_Highlight_3_Texture:SetAllPoints()
RotateTexture(OverEmote_Highlight_3_Texture, 90)
OverEmote_Highlight_3_Texture:SetTexture(highlightTexture)
OverEmote_Highlight_3.background = OverEmote_Highlight_3_Texture
OverEmote_Highlight_3:SetAlpha(0.1)
OverEmote_Highlight_3:Hide()

-- Highlight Area 4
OverEmote_Highlight_4 = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Highlight_4:SetSize(1080, 1080) 
OverEmote_Highlight_4:SetPoint("CENTER",382,-382) 
OverEmote_Highlight_4:SetFrameStrata("BACKGROUND")
local OverEmote_Highlight_4_Texture = OverEmote_Highlight_4:CreateTexture() 
OverEmote_Highlight_4_Texture:SetAllPoints()
RotateTexture(OverEmote_Highlight_4_Texture, 135)
OverEmote_Highlight_4_Texture:SetTexture(highlightTexture)
OverEmote_Highlight_4.background = OverEmote_Highlight_4_Texture
OverEmote_Highlight_4:SetAlpha(0.1)
OverEmote_Highlight_4:Hide()

-- Highlight Area 5
OverEmote_Highlight_5 = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Highlight_5:SetSize(1080, 1080) 
OverEmote_Highlight_5:SetPoint("CENTER",540,0) 
OverEmote_Highlight_5:SetFrameStrata("BACKGROUND")
local OverEmote_Highlight_5_Texture = OverEmote_Highlight_5:CreateTexture() 
OverEmote_Highlight_5_Texture:SetAllPoints() 
OverEmote_Highlight_5_Texture:SetTexCoord(1,0,0,1)
OverEmote_Highlight_5_Texture:SetTexture(highlightTexture)
OverEmote_Highlight_5.background = OverEmote_Highlight_5_Texture
OverEmote_Highlight_5:SetAlpha(0.1)
OverEmote_Highlight_5:Hide()

-- Highlight Area 6
OverEmote_Highlight_6 = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Highlight_6:SetSize(1080, 1080) 
OverEmote_Highlight_6:SetPoint("CENTER",382,382) 
OverEmote_Highlight_6:SetFrameStrata("BACKGROUND")
local OverEmote_Highlight_6_Texture = OverEmote_Highlight_6:CreateTexture() 
OverEmote_Highlight_6_Texture:SetAllPoints()
RotateTexture(OverEmote_Highlight_6_Texture, 225)
OverEmote_Highlight_6_Texture:SetTexture(highlightTexture)
OverEmote_Highlight_6.background = OverEmote_Highlight_6_Texture
OverEmote_Highlight_6:SetAlpha(0.1)
OverEmote_Highlight_6:Hide()

-- Highlight Area 7
OverEmote_Highlight_7 = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Highlight_7:SetSize(1080, 1080) 
OverEmote_Highlight_7:SetPoint("CENTER",0,540) 
OverEmote_Highlight_7:SetFrameStrata("BACKGROUND")
local OverEmote_Highlight_7_Texture = OverEmote_Highlight_7:CreateTexture() 
OverEmote_Highlight_7_Texture:SetAllPoints()
RotateTexture(OverEmote_Highlight_7_Texture, 270)
OverEmote_Highlight_7_Texture:SetTexture(highlightTexture)
OverEmote_Highlight_7.background = OverEmote_Highlight_7_Texture
OverEmote_Highlight_7:SetAlpha(0.1)
OverEmote_Highlight_7:Hide()

-- Highlight Area 8
OverEmote_Highlight_8 = CreateFrame("Frame", nil, OverEmote_Background)
OverEmote_Highlight_8:SetSize(1080, 1080) 
OverEmote_Highlight_8:SetPoint("CENTER",-382,382)
OverEmote_Highlight_8:SetFrameStrata("BACKGROUND")
local OverEmote_Highlight_8_Texture = OverEmote_Highlight_8:CreateTexture() 
OverEmote_Highlight_8_Texture:SetAllPoints()
RotateTexture(OverEmote_Highlight_8_Texture, -45)
OverEmote_Highlight_8_Texture:SetTexture(highlightTexture)
OverEmote_Highlight_8.background = OverEmote_Highlight_8_Texture
OverEmote_Highlight_8:SetAlpha(0.1)
OverEmote_Highlight_8:Hide()


-- Wheel Icons --

-- Emote
OverEmote_Icon_Emote = CreateFrame("Frame", "MyFrame", OverEmote_Background) 
OverEmote_Icon_Emote:SetSize(128, 128) 
OverEmote_Icon_Emote:SetPoint("CENTER",0,0)
local OverEmote_Icon_Emote_texture = OverEmote_Icon_Emote:CreateTexture() 
OverEmote_Icon_Emote_texture:SetAllPoints() 
OverEmote_Icon_Emote_texture:SetTexture("Interface\\AddOns\\OverEmote\\Textures\\OW_Icons.blp") 
OverEmote_Icon_Emote_texture:SetTexCoord(.25,.5,0,.25)
OverEmote_Icon_Emote.background = OverEmote_Icon_Emote_texture 

-- Thank
OverEmote_Icon_Thank = CreateFrame("Frame", "MyFrame", OverEmote_Background) 
OverEmote_Icon_Thank:SetSize(128, 128) 
OverEmote_Icon_Thank:SetPoint("CENTER",0,0)
local OverEmote_Icon_Thank_texture = OverEmote_Icon_Thank:CreateTexture() 
OverEmote_Icon_Thank_texture:SetAllPoints() 
OverEmote_Icon_Thank_texture:SetTexture("Interface\\AddOns\\OverEmote\\Textures\\OW_Icons.blp") 
OverEmote_Icon_Thank_texture:SetTexCoord(0,.25,0,.25)
OverEmote_Icon_Thank.background = OverEmote_Icon_Thank_texture 

-- Hello
OverEmote_Icon_Hello = CreateFrame("Frame", "MyFrame", OverEmote_Background) 
OverEmote_Icon_Hello:SetSize(128, 128) 
OverEmote_Icon_Hello:SetPoint("CENTER",0,0)
local OverEmote_Icon_Hello_texture = OverEmote_Icon_Hello:CreateTexture() 
OverEmote_Icon_Hello_texture:SetAllPoints() 
OverEmote_Icon_Hello_texture:SetTexture("Interface\\AddOns\\OverEmote\\Textures\\OW_Icons.blp") 
OverEmote_Icon_Hello_texture:SetTexCoord(.25,.5,.25,.5)
OverEmote_Icon_Hello.background = OverEmote_Icon_Hello_texture 

-- Healing
OverEmote_Icon_Healing = CreateFrame("Frame", "MyFrame", OverEmote_Background) 
OverEmote_Icon_Healing:SetSize(256, 128) 
OverEmote_Icon_Healing:SetPoint("CENTER",0,0)
local OverEmote_Icon_Healing_texture = OverEmote_Icon_Healing:CreateTexture() 
OverEmote_Icon_Healing_texture:SetAllPoints() 
OverEmote_Icon_Healing_texture:SetTexture("Interface\\AddOns\\OverEmote\\Textures\\OW_Icons.blp") 
OverEmote_Icon_Healing_texture:SetTexCoord(.5,1,0,.25)
OverEmote_Icon_Healing.background = OverEmote_Icon_Healing_texture 

-- Acknowledge
OverEmote_Icon_Acknowledge = CreateFrame("Frame", "MyFrame", OverEmote_Background) 
OverEmote_Icon_Acknowledge:SetSize(256, 128) 
OverEmote_Icon_Acknowledge:SetPoint("CENTER",0,0)
local OverEmote_Icon_Acknowledge_texture = OverEmote_Icon_Acknowledge:CreateTexture() 
OverEmote_Icon_Acknowledge_texture:SetAllPoints() 
OverEmote_Icon_Acknowledge_texture:SetTexture("Interface\\AddOns\\OverEmote\\Textures\\OW_Icons.blp") 
OverEmote_Icon_Acknowledge_texture:SetTexCoord(.5,1,.25,.5)
OverEmote_Icon_Acknowledge.background = OverEmote_Icon_Acknowledge_texture 

-- Ultimate
OverEmote_Icon_Ultimate = CreateFrame("Frame", "MyFrame", OverEmote_Background) 
OverEmote_Icon_Ultimate:SetSize(256, 128) 
OverEmote_Icon_Ultimate:SetPoint("CENTER",0,0)
local OverEmote_Icon_Ultimate_texture = OverEmote_Icon_Ultimate:CreateTexture() 
OverEmote_Icon_Ultimate_texture:SetAllPoints() 
OverEmote_Icon_Ultimate_texture:SetTexture("Interface\\AddOns\\OverEmote\\Textures\\OW_Icons.blp") 
OverEmote_Icon_Ultimate_texture:SetTexCoord(.5,1,.5,.75)
OverEmote_Icon_Ultimate.background = OverEmote_Icon_Ultimate_texture 

-- Group
OverEmote_Icon_Group = CreateFrame("Frame", "MyFrame", OverEmote_Background) 
OverEmote_Icon_Group:SetSize(256, 128) 
OverEmote_Icon_Group:SetPoint("CENTER",0,0)
local OverEmote_Icon_Group_texture = OverEmote_Icon_Group:CreateTexture() 
OverEmote_Icon_Group_texture:SetAllPoints() 
OverEmote_Icon_Group_texture:SetTexture("Interface\\AddOns\\OverEmote\\Textures\\OW_Icons.blp") 
OverEmote_Icon_Group_texture:SetTexCoord(.5,1,.75,1)
OverEmote_Icon_Group.background = OverEmote_Icon_Group_texture 

-- Voice
OverEmote_Icon_Voice = CreateFrame("Frame", "MyFrame", OverEmote_Background) 
OverEmote_Icon_Voice:SetSize(128, 128) 
OverEmote_Icon_Voice:SetPoint("CENTER",0,0)
local OverEmote_Icon_Voice_texture = OverEmote_Icon_Voice:CreateTexture() 
OverEmote_Icon_Voice_texture:SetAllPoints() 
OverEmote_Icon_Voice_texture:SetTexture("Interface\\AddOns\\OverEmote\\Textures\\OW_Icons.blp") 
OverEmote_Icon_Voice_texture:SetTexCoord(.25,.5,.75,1)
OverEmote_Icon_Voice.background = OverEmote_Icon_Voice_texture 

------------ Run At Startup ---------------

OverEmote_CalcCenterPoints(8, 350, OverEmote_ScreenWidth/2, OverEmote_ScreenHeight/2)

