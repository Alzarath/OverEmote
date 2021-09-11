----------------------------------------------------------------------------------------------------
-------------- Over Emote 1.1 - Bringing the Overwatch Emote Wheel to World of Warcraft ------------
--------------             By Songzee (Cuc Flavius)(Songzhu - Argent Dawn)              ------------
----------------------------------------------------------------------------------------------------
--------------                               Main Code                                  ------------
----------------------------------------------------------------------------------------------------

------------ Welcome Message -------------
print ("Over Emote Loaded - Use V to toggle it")


------------ Global Variables ------------
OverEmote_Key = "V"
OverEmote_Open = false
OverEmote_UpdateInterval = 0.1; 
OverEmote_TimeSinceLastUpdate = 0
OverEmote_CenterPoints = {}
OverEmote_ScreenWidth = GetScreenWidth()
OverEmote_ScreenHeight = GetScreenHeight()
OverEmote_UIScale = UIParent:GetEffectiveScale()
OverEmote_SelectedEmote = 10
OverEmote_PreviousSelected = 10 -- 10 should be null

--------------- Settings ----------------
OverEmote_Debugging = false


------------- Keybind handler ------------
local OE_KeyTrigger = CreateFrame("Frame", nil, UIParent)
OE_KeyTrigger:SetFrameStrata("DIALOG")
function OverEmote_KeyPress(self, key)
	if OverEmote_Open == false then
		if key == OverEmote_Key then
			frame = GetCurrentKeyBoardFocus () 
			if frame == nil then
				OverEmote_Open = true
				OE_KeyTrigger:SetPropagateKeyboardInput(false)
				OverEmote_Background:Show()
				OverEmote_ScreenWidth = GetScreenWidth()
				OverEmote_ScreenHeight = GetScreenHeight()
				OverEmote_CenterPoints = {}
				OverEmote_UIScale = UIParent:GetEffectiveScale()
				OverEmote_CalcCenterPoints(8, 350, OverEmote_ScreenWidth/2, OverEmote_ScreenHeight/2)
			end
		end
	end
end
function OverEmote_KeyRelease(self, key)
	if OverEmote_Open == true then
		if key == OverEmote_Key then
			OverEmote_Open = false
			OE_KeyTrigger:SetPropagateKeyboardInput(true)
			OverEmote_Background:Hide()
			OverEmote_DoEmote (OverEmote_SelectedEmote)
		end
	end
end
OE_KeyTrigger:SetScript("OnKeyDown", OverEmote_KeyPress)
OE_KeyTrigger:SetScript("OnKeyUp", OverEmote_KeyRelease)
OE_KeyTrigger:SetPropagateKeyboardInput(true)


------------- UPDATE Function -------------
function OverEmote_OnUpdate(self, elapsed)
	OverEmote_TimeSinceLastUpdate = OverEmote_TimeSinceLastUpdate + elapsed; 	
	while (OverEmote_TimeSinceLastUpdate > OverEmote_UpdateInterval) do
		OverEmote_Update()
		OverEmote_TimeSinceLastUpdate = OverEmote_TimeSinceLastUpdate - OverEmote_UpdateInterval;
	end
end

local OverEmote_UpdateFrame = CreateFrame("frame")
OverEmote_UpdateFrame:SetScript("OnUpdate", OverEmote_OnUpdate)

function OverEmote_Update ()
	if OverEmote_Open == true then
		if OverEmote_CheckMouseCenter() == true then
			OverEmote_ChangeHighlight ()
		end
		if OverEmote_CheckMouseCenter() == false then
			OverEmote_HideHighlights()
			OverEmote_SelectedEmote = 10
			OverEmote_PreviousSelected = 10
		end
	end
end

OverEmote_line = CreateFrame("frame")
OWtex = OverEmote_line:CreateTexture(nil, "BACKGROUND")
OWtex:SetColorTexture(1, 1, 1, 0.5)


--------- Check if the Mouse isn't too close to the middle --------
function OverEmote_CheckMouseCenter()
	local Xscaled, Yscaled = GetCursorPosition()
	local x = Xscaled/OverEmote_UIScale
	local y = Yscaled/OverEmote_UIScale
	local distance = distanceFrom(x,y,OverEmote_ScreenWidth/2,OverEmote_ScreenHeight/2)
	if distance <= 100 then
		return false
	else 
		return true
	end
end

--------- Change Highlight Frame ----------
function OverEmote_ChangeHighlight ()
	local Xscaled, Yscaled = GetCursorPosition()
	local x = Xscaled/OverEmote_UIScale
	local y = Yscaled/OverEmote_UIScale
	local minDistance = 4000
	local currentPoint = 0;
	local closestPoint = 0;
	for i = 0, 8, 1 do
		if (i % 2 == 0) then
			currentPoint = currentPoint+1;
		end
		local distance = distanceFrom(x,y,OverEmote_CenterPoints[i*2],OverEmote_CenterPoints[i*2+1])
		if distance < minDistance then
			minDistance = distance
			closestPoint = i
		end
	end
	if OverEmote_Debugging == true then
		ooktest(OverEmote_CenterPoints[closestPoint*2],OverEmote_CenterPoints[closestPoint*2+1])
		ooktest2(x,y)
		print (closestPoint)
		DrawRouteLine(OWtex, OverEmote_Background, x, y, OverEmote_CenterPoints[closestPoint*2],OverEmote_CenterPoints[closestPoint*2+1], 3, BOTTOMLEFT)
	end
	if OverEmote_PreviousSelected ~= closestPoint then
		OverEmote_PreviousSelected = closestPoint
		if closestPoint == 1 then -- hello
			OverEmote_HideHighlights()
			OverEmote_Highlight_6:Show()
			OverEmote_SelectedEmote = 1
		end	
		if closestPoint == 2 then -- emote
			OverEmote_HideHighlights()
			OverEmote_Highlight_7:Show()
			OverEmote_SelectedEmote = 2
		end	
		if closestPoint == 3 then -- thank
			OverEmote_HideHighlights()
			OverEmote_Highlight_8:Show()
			OverEmote_SelectedEmote = 3
		end
		if closestPoint == 4 then -- acknowledge
			OverEmote_HideHighlights()
			OverEmote_Highlight_1:Show()
			OverEmote_SelectedEmote = 4
		end
		if closestPoint == 5 then -- voice line
			OverEmote_HideHighlights()
			OverEmote_Highlight_2:Show()
			OverEmote_SelectedEmote = 5
		end		
		if closestPoint == 6 then -- ultimate status
			OverEmote_HideHighlights()
			OverEmote_Highlight_3:Show()
			OverEmote_SelectedEmote = 6
		end	
		if closestPoint == 7 then -- group up
			OverEmote_HideHighlights()
			OverEmote_Highlight_4:Show()
			OverEmote_SelectedEmote = 7
		end	
		if closestPoint == 8 or closestPoint == 0 then -- need healing
			OverEmote_HideHighlights()
			OverEmote_Highlight_5:Show()
			OverEmote_SelectedEmote = 8
		end	
	end
	if  OverEmote_PreviousSelected == closestPoint then
		OverEmote_SelectedEmote = OverEmote_PreviousSelected
	end
end


-- emotes --
function OverEmote_DoEmote (choice)
	OverEmote_SelectedEmote = 10
	if choice == 1 then
		DoEmote("hello")
	end
	if choice == 2 then
		DoEmote("dance")
	end
	if choice == 3 then
		DoEmote("thank")
	end
	if choice == 4 then
		DoEmote("nod")
	end
	if choice == 5 then
		DoEmote("joke")
	end
	if choice == 6 then
		SendChatMessage("My ultimate is charging 99%" ,"SAY" ,nil ,nil)
	end	
	if choice == 7 then
		DoEmote("beckon")
	end
	if choice == 8 or choice == 0 then
		DoEmote("healme")
	end
end
--- more emotes here : http://wowwiki.wikia.com/wiki/API_TYPE_Emotes_Token

--------- Hide Unselected Highlights ----------
function OverEmote_HideHighlights ()
		OverEmote_Highlight_1:Hide()
		OverEmote_Highlight_2:Hide()
		OverEmote_Highlight_3:Hide()
		OverEmote_Highlight_4:Hide()
		OverEmote_Highlight_5:Hide()
		OverEmote_Highlight_6:Hide()
		OverEmote_Highlight_7:Hide()
		OverEmote_Highlight_8:Hide()
end


--------- Calculate Center Points ---------
function OverEmote_CalcCenterPoints(points, radius, centerX, centerY)
    slice = 2 * math.pi / points;
    for i = 0, points, 1 do
        angle = slice * i;
        newX = toint(centerX + radius * math.cos(angle));
        newY = toint(centerY + radius * math.sin(angle));
		OverEmote_CenterPoints[i*2] = newX
		OverEmote_CenterPoints[i*2+1] = newY
    end
	
	OverEmote_Icon_Emote:SetPoint("BOTTOMLEFT",OverEmote_CenterPoints[4]-64,OverEmote_CenterPoints[5]-170)
	OverEmote_Icon_Thank:SetPoint("BOTTOMLEFT",OverEmote_CenterPoints[6]-16,OverEmote_CenterPoints[7]-110)
	OverEmote_Icon_Hello:SetPoint("BOTTOMLEFT",OverEmote_CenterPoints[2]-110,OverEmote_CenterPoints[3]-115)
	OverEmote_Icon_Healing:SetPoint("BOTTOMLEFT",OverEmote_CenterPoints[0]-170,OverEmote_CenterPoints[1]-64)
	OverEmote_Icon_Acknowledge:SetPoint("BOTTOMLEFT",OverEmote_CenterPoints[8]-100,OverEmote_CenterPoints[9]-64)
	OverEmote_Icon_Ultimate:SetPoint("BOTTOMLEFT",OverEmote_CenterPoints[12]-128,OverEmote_CenterPoints[13]+48)
	OverEmote_Icon_Group:SetPoint("BOTTOMLEFT",OverEmote_CenterPoints[14]-200,OverEmote_CenterPoints[15])
	OverEmote_Icon_Voice:SetPoint("BOTTOMLEFT",OverEmote_CenterPoints[10]-10,OverEmote_CenterPoints[11])
end


------------ Helper Functions --------------
function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

function distanceFrom(x1,y1,x2,y2)
	return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

------------ DEBUGGING STUFF -----------------
if OverEmote_Debugging == true then
	TEEEST = CreateFrame("Frame", nil, UIParent)
	TEEEST:SetFrameStrata("BACKGROUND")
	TEEEST:SetWidth(30)
	TEEEST:SetHeight(30)
	TEEEST:SetBackdrop({ bgFile = [[Interface\Buttons\WHITE8x8]], insets = {left = 3, right = 3, top = 4, bottom = 3}})
	TEEEST:SetBackdropColor(1, 1, 1, 1)
	TEEEST:SetPoint("BOTTOMLEFT",0,0)
	TEEEST:Show()
	
	TEEEST2 = CreateFrame("Frame", nil, UIParent)
	TEEEST2:SetFrameStrata("BACKGROUND")
	TEEEST2:SetWidth(30)
	TEEEST2:SetHeight(30)
	TEEEST2:SetBackdrop({ bgFile = [[Interface\Buttons\WHITE8x8]], insets = {left = 3, right = 3, top = 4, bottom = 3}})
	TEEEST2:SetBackdropColor(0, 0, 0, 1)
	TEEEST2:SetPoint("BOTTOMLEFT",0,0)
	TEEEST2:Show()
end

function ooktest(x,y)
	TEEEST:SetPoint("BOTTOMLEFT",x,y)
end

function ooktest2(x,y)
	TEEEST2:SetPoint("BOTTOMLEFT",x,y)
end

local LINEFACTOR = 256/254; -- Multiplying factor for texture coordinates
local LINEFACTOR_2 = LINEFACTOR / 2; -- Half o that
-- T        - Texture
-- C        - Canvas Frame (for anchoring)
-- sx,sy    - Coordinate of start of line
-- ex,ey    - Coordinate of end of line
-- w        - Width of line
-- relPoint - Relative point on canvas to interpret coords (Default BOTTOMLEFT)
function DrawRouteLine(T, C, sx, sy, ex, ey, w, relPoint)
   if (not relPoint) then relPoint = "BOTTOMLEFT"; end

   -- Determine dimensions and center point of line
   local dx,dy = ex - sx, ey - sy;
   local cx,cy = (sx + ex) / 2, (sy + ey) / 2;
   -- Normalize direction if necessary
   if (dx < 0) then
      dx,dy = -dx,-dy;
   end
   -- Calculate actual length of line
   local l = sqrt((dx * dx) + (dy * dy));
   -- Quick escape if it's zero length
   if (l == 0) then
      T:SetTexCoord(0,0,0,0,0,0,0,0);
      T:SetPoint("BOTTOMLEFT", C, relPoint, cx,cy);
      T:SetPoint("TOPRIGHT",   C, relPoint, cx,cy);
      return;
   end
   -- Sin and Cosine of rotation, and combination (for later)
   local s,c = -dy / l, dx / l;
   local sc = s * c;
   -- Calculate bounding box size and texture coordinates
   local Bwid, Bhgt, BLx, BLy, TLx, TLy, TRx, TRy, BRx, BRy;
   if (dy >= 0) then
      Bwid = ((l * c) - (w * s)) * LINEFACTOR_2;
      Bhgt = ((w * c) - (l * s)) * LINEFACTOR_2;
      BLx, BLy, BRy = (w / l) * sc, s * s, (l / w) * sc;
      BRx, TLx, TLy, TRx = 1 - BLy, BLy, 1 - BRy, 1 - BLx; 
      TRy = BRx;
   else
      Bwid = ((l * c) + (w * s)) * LINEFACTOR_2;
      Bhgt = ((w * c) + (l * s)) * LINEFACTOR_2;
      BLx, BLy, BRx = s * s, -(l / w) * sc, 1 + (w / l) * sc;
      BRy, TLx, TLy, TRy = BLx, 1 - BRx, 1 - BLx, 1 - BLy;
      TRx = TLy;
   end
   -- Set texture coordinates and anchors
   T:SetTexCoord(TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy);
   T:SetPoint("BOTTOMLEFT", C, relPoint, cx - Bwid, cy - Bhgt);
   T:SetPoint("TOPRIGHT",   C, relPoint, cx + Bwid, cy + Bhgt);
end




