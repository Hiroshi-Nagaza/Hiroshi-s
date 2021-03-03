local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)

painel = false
createdGuis = {}

x_base = 440
y_base = 150

slots = {
    [1] = {x = x_base + 1*54, y = y_base+54},
    [2] = {x = x_base + 2*54, y = y_base+54},
    [3] = {x = x_base + 3*54, y = y_base+54},
    [4] = {x = x_base + 4*54, y = y_base+54},
    [5] = {x = x_base + 5*54, y = y_base+54},
    [6] = {x = x_base + 6*54, y = y_base+54},
    [7] = {x = x_base + 1*54, y = y_base+2*54},
    [8] = {x = x_base + 2*54, y = y_base+2*54},
    [9] = {x = x_base + 3*54, y = y_base+2*54},
    [10] = {x = x_base + 4*54, y = y_base+2*54},
    [11] = {x = x_base + 5*54, y = y_base+2*54},
    [12] = {x = x_base + 6*54, y = y_base+2*54},
    [13] = {x = x_base + 1*54, y = y_base+3*54},
    [14] = {x = x_base + 2*54, y = y_base+3*54},
    [15] = {x = x_base + 3*54, y = y_base+3*54},
    [16] = {x = x_base + 4*54, y = y_base+3*54},
    [17] = {x = x_base + 5*54, y = y_base+3*54},
    [18] = {x = x_base + 6*54, y = y_base+3*54},
    [19] = {x = x_base + 1*54, y = y_base+4*54},
    [20] = {x = x_base + 2*54, y = y_base+4*54},
    [21] = {x = x_base + 3*54, y = y_base+4*54},
    [22] = {x = x_base + 4*54, y = y_base+4*54},
    [23] = {x = x_base + 5*54, y = y_base+4*54},
    [24] = {x = x_base + 6*54, y = y_base+4*54},
    [25] = {x = x_base + 1*54, y = y_base+1*54},
    [26] = {x = x_base + 2*54, y = y_base+2*54},
    [27] = {x = x_base + 3*54, y = y_base+3*54},
    [28] = {x = x_base + 4*54, y = y_base+4*54},
    [29] = {x = x_base + 5*54, y = y_base+5*54},
    [30] = {x = x_base + 6*54, y = y_base+6*54},

}

bindKey("k", "down", function()
	if painel then
		createGui("destroy")
		removeEventHandler("onClientRender", root, drawInvory)
		playSound("files/close.mp3", false)
		alfa = 0
		painel = false
	else
		createGui("inv")
		addEventHandler("onClientRender", root, drawInvory)
		playSound("files/open.mp3", false)
		painel = true
	end
	if isCursorShowing(localPlayer) then
		showCursor(false)
	else
		showCursor(true)
	end
	reloadPeso()
end)

function reloadPeso()
	setElementData(localPlayer, "Inventory:Slots", 0)
	for i,v in ipairs(itemLists) do
		if (getElementData(localPlayer, tostring(itemLists[i].name)) or 0) >= 1 then
			setElementData(localPlayer, "Inventory:Slots", (getElementData(localPlayer, "Inventory:Slots") or 0) + tonumber(itemLists[i].peso))
		end
	end
end

function createGui(type)
  if tostring(type) == "destroy" then
    for i = 1, 6 do
      if isElement(createdGuis[i]) then
        destroyElement(createdGuis[i])
      end
    end
  elseif tostring(type) == "inv" then
    createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "QUANTIDADE", false)
    guiEditSetMaxLength(createdGuis[1], 8)
    createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "ID", false)
    guiEditSetMaxLength(createdGuis[2], 4)
  end
end

alfa = 0

function drawInvory()
	local peso1 = getElementData(localPlayer, "Inventory:Slots") or 0
	local peso2 = getElementData(localPlayer, "Inventory:MaxSlots") or 25
	if alfa < 255 then
		alfa = alfa + 15
	else
		alfa = 255
	end
	dxDrawImage(x*361, y*170, x*643, y*428, "files/base.png", 0, 0, 0, tocolor(255, 255, 255, alfa), false)
	for posX=1, Maxslots do
		for posY=1,colunas do
			dxDrawImage(x*470+posX*54, y*160+posY*54, x*53, y*53, "files/slot.png", 0, 0, 0, tocolor(255, 255, 255, alfa), false)
			if isCursorOnElement(x*470+posX*54, y*160+posY*54, x*53, y*53) then
				dxDrawImage(x*470+posX*54-0.5, y*160+posY*54-0.5, x*53+1, y*53+1, "files/slot.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				dxDrawImage(x*470+posX*54, y*160+posY*54, x*53, y*53, "files/slot.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			end
		end
	end
	dxDrawImage(x*524, y*177, x*94, y*23, "files/bolso_button.png", 0, 0, 0, tocolor(255, 255, 255, alfa), false)
	if isCursorOnElement(x*524, y*177, x*94, y*23) then
		dxDrawImage(x*524, y*177, x*94, y*23, "files/bolso_button.png", 0, 0, 0, tocolor(200, 200, 200, 255), false)
	end
	dxDrawImage(x*628, y*177, x*345, y*23, "files/limite_background.png", 0, 0, 0, tocolor(255, 255, 255, alfa), false)
	dxDrawImage(x*628, y*177, x*345/25 * peso1, y*23, "files/limite.png", 0, 0, 0, tocolor(255, 255, 255, alfa), false)
	dxDrawText(peso1.."/"..peso2.." KG", x*772, y*180, x*779, y*195, tocolor(90, 90, 255, alfa), 1.20, "default-bold", "left", "top", false, false, true, false)
	dxDrawImage(x*876, y*213, x*112, y*280, "files/actionbar_right.png", 0, 0, 0, tocolor(255, 255, 255, alfa), false)
	dxDrawText(tostring(guiGetText(createdGuis[1])), x*887, y*213, x*977, y*240, tocolor(255, 255, 255, alfa), 1.00, "default-bold", "center", "center", true, true, true, true, true)
	dxDrawText(tostring(guiGetText(createdGuis[2])), x*887, y*246, x*977, y*273, tocolor(255, 255, 255, alfa), 1.00, "default-bold", "center", "center", true, true, true, true, true)
	linha = 0
	for i, v in ipairs(itemLists) do 
		if (getElementData(localPlayer, tostring(itemLists[i].name)) or 0) >= 1 then
			linha = linha + 1
    		if isCursorOnElement(slots[linha].x, slots[linha].y, x*53, y*53) then
    			dxDrawImage(slots[linha].x, slots[linha].y, x*53, y*53, "files/items/"..(i)..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    		else
    			dxDrawImage(slots[linha].x, slots[linha].y, x*53, y*53, "files/items/"..(i)..".png", 0, 0, 0, tocolor(255, 255, 255, 200), false)
    		end
    	end
	end 
end

addEventHandler("onClientClick", root,
function(button, state, cursorx, cursory)
	if state == "down" then
		if painel then
			if isCursorOnElement( x*887, y*213, x*90, y*27) then
		    	if guiEditSetCaretIndex(createdGuis[1], string.len(guiGetText(createdGuis[1]))) then
			        guiBringToFront(createdGuis[1])
			        guiSetText( createdGuis[1], "" )
			    end
			elseif isCursorOnElement( x*887, y*246, x*90, y*27) then
		    	if guiEditSetCaretIndex(createdGuis[2], string.len(guiGetText(createdGuis[2]))) then
			        guiBringToFront(createdGuis[2])
			        guiSetText( createdGuis[2], "" )
			    end
		    end
		end
	end
end)

addCommandHandler("teste", 
function()
	for i,v in ipairs(itemLists) do
		if (getElementData(localPlayer, tostring(itemLists[i].name)) or 0) >= 1 then
			outputChatBox("Você possui: "..tostring(itemLists[i].name), 0, 255, 0, true)
		else
			outputChatBox("Você não possui: "..tostring(itemLists[i].name), 255, 0, 0, true)
		end
	end
end)

function isCursorOnElement( posX, posY, width, height )
  if isCursorShowing( ) then
    local mouseX, mouseY = getCursorPosition( )
    local clientW, clientH = guiGetScreenSize( )
    local mouseX, mouseY = mouseX * clientW, mouseY * clientH
    if ( mouseX > posX and mouseX < ( posX + width ) and mouseY > posY and mouseY < ( posY + height ) ) then
      return true
    end
  end
  return false
end

--Autor: Hiroshi
