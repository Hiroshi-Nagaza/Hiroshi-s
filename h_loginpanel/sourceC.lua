hiroshiW, hiroshiH = guiGetScreenSize()
x, y = (hiroshiW/1366), (hiroshiH/768)
montserrant_normal = exports["h_fonts"]:getFont("f8")
montserrant_light = exports["h_fonts"]:getFont("f10")

panel = false

createdGuis = {}

function createGui(type)
  if tostring(type) == "destroy" then
    for i = 1, 6 do
      if isElement(createdGuis[i]) then
        destroyElement(createdGuis[i])
      end
    end
  elseif tostring(type) == "login" then
    createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, loadLoginFromXML(), false)
    guiEditSetMaxLength(createdGuis[1], 20)   
    createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "Senha", false)
    guiEditSetMaxLength(createdGuis[2], 20)
  elseif tostring(type) == "register" then
    createdGuis[1] = guiCreateEdit(-1000, -1000, 0, 0, "Usuário", false)
    guiEditSetMaxLength(createdGuis[1], 20)   
    createdGuis[2] = guiCreateEdit(-1000, -1000, 0, 0, "Senha", false)
    guiEditSetMaxLength(createdGuis[2], 20)
    createdGuis[3] = guiCreateEdit(-1000, -1000, 0, 0, "Confirme a Senha", false)
    guiEditSetMaxLength(createdGuis[3], 20)
  end
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
	addEventHandler("onClientRender", root, drawLogin)
	createGui("login")
	showCursor(true)
	showChat(false)
	panel = true
	screen = "login"
	musica = playSound("assets/music.mp3")
end)

addEvent("ClosePanel", true)
addEventHandler("ClosePanel", root,
function()
	removeEventHandler("onClientRender", root, drawLogin)
	panel = false
	screen = nil
	showCursor(false)
	showChat(true)
	if isElement(musica) then
		destroyElement(musica)
	end
end
)

function passwordHash(password)
	if password ~= "Senha" then
		if password ~= "Confirme a Senha" then
		    local length = utfLen(password)

		    if length > 20 then
		        length = 20
		    end
		    return string.rep("*", length)
		else
			return password
		end
	else
		return password
	end
end

preechimentoX = 0
function drawLogin ()
	if (panel) then
		for i,v in ipairs(assetsPosition["Main_Welcome"]) do
			dxDrawImage( x*assetsPosition["Main_Welcome"][i]["x"], y*assetsPosition["Main_Welcome"][i]["y"], x*assetsPosition["Main_Welcome"][i]["width"],  y*assetsPosition["Main_Welcome"][i]["height"],  assetsPosition["Main_Welcome"][i]["image"], 0, 0, 0, tocolor(255,255,255,255), false)
			dxDrawText( discord, x*295, y*632, x*0, y*0, tocolor(41, 44, 62, 255), 0.8, montserrant_light, "left", "top", false, false, true, true, false)
			dxDrawText( servername, x*485, y*447, x*0, y*0, tocolor(41, 44, 62, 255), 1.20, montserrant_light, "left", "top", false, false, true, true, false)

		end
		if screen == "login" then
			for i,v in ipairs(assetsPosition["Assets_Login"]) do
				dxDrawImage( x*assetsPosition["Assets_Login"][i]["x"], y*assetsPosition["Assets_Login"][i]["y"], x*assetsPosition["Assets_Login"][i]["width"],  y*assetsPosition["Assets_Login"][i]["height"],  assetsPosition["Assets_Login"][i]["image"], 0, 0, 0, tocolor(255,255,255,255), false)
				dxDrawText( guiGetText( createdGuis[1] ), x*732, y*375, x*0, y*0, tocolor(150, 150, 150, 200), 0.8, montserrant_light, "left", "top", false, false, true, true, false)
				dxDrawText( passwordHash(guiGetText( createdGuis[2] )), x*732, y*423, x*0, y*0, tocolor(150, 150, 150, 200), 0.8, montserrant_light, "left", "top", false, false, true, true, false)
				if isMouseInPosition(x*assetsPosition["Assets_Login"][i]["x"], y*assetsPosition["Assets_Login"][i]["y"], x*assetsPosition["Assets_Login"][i]["width"],  y*assetsPosition["Assets_Login"][i]["height"]) then
					if assetsPosition["Assets_Login"][i]["image"] == "assets/login_button.png" then
						if preechimentoX < 200 then
							preechimentoX = preechimentoX + 25
						else
							preechimentoX = 200
						end
								
						dxDrawImageSection(x*678, y*500, x*preechimentoX, y*45, 0, 0, preechimentoX, 45, "assets/fundo_preench.png", 0, 0, 0, tocolor(0, 0, 0, 50), true)
						dxDrawImage( x*assetsPosition["Assets_Login"][i]["x"], y*assetsPosition["Assets_Login"][i]["y"], x*assetsPosition["Assets_Login"][i]["width"],  y*assetsPosition["Assets_Login"][i]["height"],  assetsPosition["Assets_Login"][i]["image"], 0, 0, 0, tocolor(255,255,255,255), true)
					end
				else
					preechimentoX = 0
				end
			end
		end
		if screen == "register" then
			for i,v in ipairs(assetsPosition["Assets_Resgiter"]) do
				dxDrawImage( x*assetsPosition["Assets_Resgiter"][i]["x"], y*assetsPosition["Assets_Resgiter"][i]["y"], x*assetsPosition["Assets_Resgiter"][i]["width"],  y*assetsPosition["Assets_Resgiter"][i]["height"],  assetsPosition["Assets_Resgiter"][i]["image"], 0, 0, 0, tocolor(255,255,255,255), false)
				dxDrawText( guiGetText( createdGuis[1] ), x*732, y*360, x*0, y*0, tocolor(150, 150, 150, 200), 0.8, montserrant_light, "left", "top", false, false, true, true, false)
				dxDrawText( passwordHash(guiGetText( createdGuis[2] )), x*732, y*407, x*0, y*0, tocolor(150, 150, 150, 200), 0.8, montserrant_light, "left", "top", false, false, true, true, false)
				dxDrawText( passwordHash(guiGetText( createdGuis[3] )), x*732, y*455, x*0, y*0, tocolor(150, 150, 150, 200), 0.8, montserrant_light, "left", "top", false, false, true, true, false)
				if isMouseInPosition(x*assetsPosition["Assets_Resgiter"][i]["x"], y*assetsPosition["Assets_Resgiter"][i]["y"], x*assetsPosition["Assets_Resgiter"][i]["width"],  y*assetsPosition["Assets_Resgiter"][i]["height"]) then
					if assetsPosition["Assets_Resgiter"][i]["image"] == "assets/register_button.png" then
						if preechimentoX < 200 then
							preechimentoX = preechimentoX + 25
						else
							preechimentoX = 200
						end
								
						dxDrawImageSection(x*678, y*500, x*preechimentoX, y*45, 0, 0, preechimentoX, 45, "assets/fundo_preench.png", 0, 0, 0, tocolor(0, 0, 0, 50), true)
						dxDrawImage( x*assetsPosition["Assets_Resgiter"][i]["x"], y*assetsPosition["Assets_Resgiter"][i]["y"], x*assetsPosition["Assets_Resgiter"][i]["width"],  y*assetsPosition["Assets_Resgiter"][i]["height"],  assetsPosition["Assets_Resgiter"][i]["image"], 0, 0, 0, tocolor(255,255,255,255), true)
					end
				else
					preechimentoX = 0
				end
			end
		end
		for i,v in ipairs(assetsPosition["Assets_Up"]) do
			dxDrawImage( x*assetsPosition["Assets_Up"][i]["x"], y*assetsPosition["Assets_Up"][i]["y"], x*assetsPosition["Assets_Up"][i]["width"],  y*assetsPosition["Assets_Up"][i]["height"],  assetsPosition["Assets_Up"][i]["image"], 0, 0, 0, tocolor(255,255,255,255), false)
		end
	end
end

addEventHandler("onClientClick", root, 
function(_, state)
	if (panel) then
		if screen == "login" and state == "down" then
			if isMouseInPosition(x*732, y*375, x*100, y*20) then
				if guiEditSetCaretIndex(createdGuis[1], string.len(guiGetText(createdGuis[1]))) then
					guiBringToFront(createdGuis[1])
					guiSetText( createdGuis[1], "" )
				end
			end
			if isMouseInPosition(x*732, y*423, x*100, y*20) then
				if guiEditSetCaretIndex(createdGuis[2], string.len(guiGetText(createdGuis[2]))) then
					guiBringToFront(createdGuis[2])
					guiSetText( createdGuis[2], "" )
				end
			end
			if isMouseInPosition(x*assetsPosition["Assets_Login"][2]["x"], y*assetsPosition["Assets_Login"][2]["y"], x*assetsPosition["Assets_Login"][2]["width"],  y*assetsPosition["Assets_Login"][2]["height"]) then
				if guiGetText(createdGuis[1]) ~= " " and guiGetText(createdGuis[1]) ~= "Usuário" then
					if guiGetText(createdGuis[2]) ~= " " and guiGetText(createdGuis[2]) ~= "Senha" then
						triggerServerEvent( "OnPlayerLoginClick", localPlayer, localPlayer, tostring(guiGetText(createdGuis[1])), tostring(guiGetText(createdGuis[2])))
					else
						exports["h_infobox"]:addBox("error", "Digite sua Senha")
					end
				else
					exports["h_infobox"]:addBox("error", "Digite seu login")
				end
			end
			if isMouseInPosition(x*1034, y*641, x*40, y*18) then
				screen = "register"
				createGui("destroy")
				createGui("register")
				bindKey("backspace","down",function()
					createGui("destroy")
					createGui("login")
					screen = "login"
				end)
			end
		elseif screen == "register" and state == "down" then
			if isMouseInPosition(x*677, y*348, x*394, y*50) then
				if guiEditSetCaretIndex(createdGuis[1], string.len(guiGetText(createdGuis[1]))) then
					guiBringToFront(createdGuis[1])
					guiSetText( createdGuis[1], "" )
				end
			end
			if isMouseInPosition(x*677, y*398, x*394, y*50) then
				if guiEditSetCaretIndex(createdGuis[2], string.len(guiGetText(createdGuis[2]))) then
					guiBringToFront(createdGuis[2])
					guiSetText( createdGuis[2], "" )
				end
			end
			if isMouseInPosition(x*677, y*458, x*394, y*50) then
				if guiEditSetCaretIndex(createdGuis[3], string.len(guiGetText(createdGuis[3]))) then
					guiBringToFront(createdGuis[3])
					guiSetText( createdGuis[3], "" )
				end
			end
			if isMouseInPosition(x*assetsPosition["Assets_Resgiter"][2]["x"], y*assetsPosition["Assets_Resgiter"][2]["y"], x*assetsPosition["Assets_Resgiter"][2]["width"],  y*assetsPosition["Assets_Resgiter"][2]["height"]) then
				if guiGetText(createdGuis[1]) ~= " " and guiGetText(createdGuis[1]) ~= "Usuário" then
					if guiGetText(createdGuis[2]) ~= " " and guiGetText(createdGuis[2]) ~= "Senha" then
						if guiGetText(createdGuis[2]) ~= guiGetText(createdGuis[3]) then
							exports["h_infobox"]:addBox("error", "Confirme a senha corretamente")
						else
							print("registrar")
							triggerServerEvent( "OnPlayerRegisterClick", localPlayer, localPlayer, tostring(guiGetText(createdGuis[1])), tostring(guiGetText(createdGuis[2])))
						end
					else
						exports["h_infobox"]:addBox("error", "Digite uma Senha")
					end
				else
					exports["h_infobox"]:addBox("error", "Digite um nome de Usuário")
				end
			end
		end
	end
end
)

function loadLoginFromXML()
	local XML = xmlLoadFile ("userdata.xml")
    if not XML then
        XML = xmlCreateFile("userdata.xml", "login")
    end
	
    local usernameNode = xmlFindChild (XML, "username", 0)
    if usernameNode then
        return xmlNodeGetValue(usernameNode)
    else
		return "Usuário"
    end
    xmlUnloadFile ( XML )
end

function saveLoginToXML(username)
    local XML = xmlLoadFile ("userdata.xml")
    if not XML then
        XML = xmlCreateFile("userdata.xml", "login")
    end
	if (username ~= "") then
		local usernameNode = xmlFindChild (XML, "username", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(XML, "username")
		end
		xmlNodeSetValue (usernameNode, tostring(username))
	end
    xmlSaveFile(XML)
    xmlUnloadFile (XML)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", root, saveLoginToXML)

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end