---- #########################################################################
---- #                                                                       #
---- # Copyright (C) OpenTX                                                  #
-----#                                                                       #
---- # License GPLv2: http://www.gnu.org/licenses/gpl-2.0.html               #
---- #                                                                       #
---- # This program is free software; you can redistribute it and/or modify  #
---- # it under the terms of the GNU General Public License version 2 as     #
---- # published by the Free Software Foundation.                            #
---- #                                                                       #
---- # This program is distributed in the hope that it will be useful        #
---- # but WITHOUT ANY WARRANTY; without even the implied warranty of        #
---- # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
---- # GNU General Public License for more details.                          #
---- #  Im EVGEN SPININ FOR TEST777777777777777777777                                                            #
---- #########################################################################
local options = {
  { "Option1", SOURCE, 1 },
  { "SmallTextSize", BOOL, 0 },
  { "Option3", COLOR, RED },
  { "CircleCheckList", BOOL, 0 }
}

local sizeTxt = MIDSIZE
local textMargin = 30
local startTextPosition = 41
local flag = 0
local action1 = TEXT_COLOR + INVERS + BLINK
local action2 = TEXT_COLOR
local action3 = TEXT_COLOR
local action4 = TEXT_COLOR
local action5 = TEXT_COLOR
local action6 = TEXT_COLOR
local action7 = TEXT_COLOR

local isBlink = TEXT_COLOR + INVERS + BLINK
local notBlink = TEXT_COLOR
local screen = 2


-- local actions = {
-- 	1 = isBlink,
-- 	2 = notBlink,
-- 	3 = notBlink,
-- 	4 = notBlink,
-- 	5 = notBlink,
-- 	6 = notBlink,
-- 	7 = notBlink
-- }

local utils = {}

--image background--

local bitmaps = {}

--image background--

---------------------------------------------------
local sounds = {
	action1 = "/SOUNDS/en/fm-1.wav",
	action2 = "/SOUNDS/en/fm-2.wav",
	action3 = "/SOUNDS/en/fm-3.wav",
	action4 = "/SOUNDS/en/fm-4.wav",
	action5 = "/SOUNDS/en/fm-5.wav",
	action6 = "/SOUNDS/en/fm-6.wav",
	action7 = "/SOUNDS/en/fm-7.wav"
}

-----------------------------

function getTextSize(isSmallText)
	if (isSmallText == 1) then
		sizeTxt = SMLSIZE
	else
		sizeTxt = MIDSIZE
	end
end

-----------------------------

local function getTextMargin(isSmallText)
	if (isSmallText == 1) then
		textMargin = 15
	else
		textMargin = 30
	end
end

-----------------------------

function setAction()
	if (flag == 1) then
		return nil
	else
		flag = 1
	end

    if(action1 == isBlink) then 
      action1 = notBlink
      action2 = isBlink
      playFile(sounds.action2)
	  return nil
    end
    if(action2 == isBlink) then 
      action2 = notBlink
      action3 = isBlink
      playFile(sounds.action3)
	  return nil
    end
    if(action3 == isBlink) then 
      action3 = notBlink
      action4 = isBlink
      playFile(sounds.action4)
	  return nil
    end
    if(action4 == isBlink) then 
      action4 = notBlink
      action5 = isBlink
      playFile(sounds.action5)
	  return nil
    end
    if(action5 == isBlink) then 
      action5 = notBlink
      action6 = isBlink
      playFile(sounds.action6)
	  return nil   
    end
    if(action6 == isBlink) then 
      action6 = notBlink
      action7 = isBlink
      playFile(sounds.action7)
	  return nil    
    end
    if(action7 == isBlink) then 
      action7 = notBlink
      action1 = isBlink
      playFile(sounds.action1)
	  return nil
    end
  end

utils.drawBackgroundImage = function(name, x , y , width)
	if bitmaps[name] == nil then
		bitmaps[name] = Bitmap.open("/IMAGES/"..name..".png")
	end
	lcd.drawBitmap(bitmaps[name],x , y , width)
end
-------------------------------------------------
local function create(zone, options)
	local pie = { zone=zone, options=options, counter=0 }
	return pie
end

local function update(pie, options)
	pie.options = options
	getTextMargin(options.SmallTextSize)
	getTextSize(options.SmallTextSize)
end

local function background(pie)
	pie.counter = pie.counter + 1
end

function refresh(pie)


if (action7 == notBlink) then
	utils.drawBackgroundImage('z84',10 ,1,240)
	lcd.setColor(TEXT_COLOR, pie.options.Option3)
	lcd.drawText(50, 1,"CHECK-LIST", DBLSIZE)

	lcd.drawText(50, startTextPosition,"1 Option", action1 + sizeTxt)
	lcd.drawText(50, startTextPosition + textMargin,"2 Option", action2 + sizeTxt)
	lcd.drawText(50, startTextPosition + textMargin * 2,"3 Option", action3 + sizeTxt)
	lcd.drawText(50, startTextPosition + textMargin * 3,"4 Option", action4 + sizeTxt)
	lcd.drawText(50, startTextPosition + textMargin * 4,"5 Option", action5 + sizeTxt)
	lcd.drawText(50, startTextPosition + textMargin * 5,"6 Option", action6 + sizeTxt)
	lcd.drawText(50, startTextPosition + textMargin * 6,"7 Option", action7 + sizeTxt)
end

if (action7 == isBlink)then

	utils.drawBackgroundImage('tx16s',10 ,1,240)
	if (pie.options.CircleCheckList == 0) then return 
	end

end


	-- lcd.drawText(50, 51, pie.options.Option2, action1)
	--lcd.drawText(50, 81,"2 Option", action1)
	--lcd.drawText(50, 111,getTime(), action1)
	--lcd.drawText(50, 141,getValue('sh'), action1)
	--lcd.drawText(50, 171,pie.counter, BLINK+INVERS)
	--lcd.drawText(50, 141,val, INVERS)
	--lcd.drawBitmap(Bitmap.open("/IMAGES/E180.png"),1,1,200)


	-- do some stuff
	pie.counter = pie.counter + 1
	if (pie.counter > 50) and ( pie.counter < 52) then
		play()    
	end

	local shValue = getValue('sh')

	if (shValue > 0) then 
		setAction()
	else
		flag = 0
	end

	collectgarbage()
end 

function play()
  playFile("/SOUNDS/ru/gps.wav")  
end

return { name="Testing", options=options, create=create, update=update, refresh=refresh, background=background }
