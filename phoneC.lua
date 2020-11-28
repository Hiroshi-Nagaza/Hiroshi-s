local screenW, screenH = guiGetScreenSize()
local x, y  =  (screenW/1366), (screenH/768)

local tela = false
local screen = "home"

local painelTable = {

	["home"] = {
		{image  = "files/home/home.png", x1=1084, y1=220, x2=252, y2=508},
    	{image  = "files/home/icone_call.png", x1=1106, y1=680, x2=35, y2=35.59},
    	{image  = "files/home/icone_sms.png", x1=1161, y1=680, x2=35, y2=35.59},
    	{image  = "files/home/icone_emergencia.png", x1=1220, y1=680, x2=35, y2=35.59},
    	{image  = "files/home/icone_loc.png", x1=1279, y1=680, x2=35, y2=35.59},
    	{image  = "files/borda.png", x1=1061, y1=145, x2=305, y2=670}
	},

	["call"] = {
		{image  = "files/call/fundo.png", x1=1084, y1=220, x2=252, y2=508},
		{image  = "files/call/ligar.png", x1=1160, y1=667, x2=100, y2=25},
		{image  = "files/call/linha.png", x1=1144, y1=365, x2=163, y2=1},
		{image  = "files/call/1.png", x1=1116, y1=387, x2=50, y2=50},
		{image  = "files/call/2.png", x1=1185, y1=387, x2=50, y2=50},
		{image  = "files/call/3.png", x1=1254, y1=387, x2=50, y2=50},
		{image  = "files/call/4.png", x1=1116, y1=456, x2=50, y2=50},
		{image  = "files/call/5.png", x1=1185, y1=456, x2=50, y2=50},
		{image  = "files/call/6.png", x1=1254, y1=456, x2=50, y2=50},
		{image  = "files/call/7.png", x1=1116, y1=524, x2=50, y2=50},
		{image  = "files/call/8.png", x1=1185, y1=524, x2=50, y2=50},
		{image  = "files/call/9.png", x1=1254, y1=524, x2=50, y2=50},
		{image  = "files/call/0.png", x1=1185, y1=593, x2=50, y2=50},
		{image  = "files/borda.png", x1=1061, y1=145, x2=305, y2=670}
	},
	["calling"] = {
		{image  = "files/call/fundo.png", x1=1084, y1=220, x2=252, y2=508},
		{image  = "files/calling/ligando.png", x1=1141, y1=280, x2=146, y2=367},
		{image  = "files/calling/cancelar.png", x1=1180, y1=587, x2=60, y2=60},
		{image  = "files/borda.png", x1=1061, y1=145, x2=305, y2=670}
	},
	["callingyou"] = {
		{image  = "files/call/fundo.png", x1=1084, y1=220, x2=252, y2=508},
		{image  = "files/callingyou/recebendo.png", x1=1111, y1=280, x2=200, y2=413},
		{image  = "files/callingyou/atender.png", x1=1111, y1=633, x2=60, y2=60},
		{image  = "files/callingyou/cancelar.png", x1=1251, y1=633, x2=60, y2=60},
		{image  = "files/borda.png", x1=1061, y1=145, x2=305, y2=670}
	},
	["msg"] = {
		{image = "files/msg/fundo.png", x1=1084, y1=220, x2=252, y2=508},
		{image = "files/msg/enviar.png", x1=1208, y1=673, x2=100, y2=30},
		{image  = "files/borda.png", x1=1061, y1=145, x2=305, y2=670}
	},
	["help"] = {
		{image = "files/help/fundo.png", x1=1084, y1=220, x2=252, y2=508},
		{image = "files/help/socorros.png", x1=1095, y1=322, x2=230, y2=100},
		{image = "files/help/ajudas.png", x1=1095, y1=430, x2=230, y2=159},
		{image = "files/help/icone.png", x1=1203, y1=271, x2=22.75, y2=22.75},
		{image = "files/help/mecanico.png", x1=1118, y1=444, x2=185, y2=35, tipo="GCM"},
		{image = "files/help/policia.png", x1=1118, y1=335, x2=185, y2=35, tipo="Policial"},
		{image = "files/help/samu.png", x1=1118, y1=372, x2=185, y2=35, tipo="SAMU"},
		{image = "files/help/staff.png", x1=1118, y1=548, x2=185, y2=35, tipo="STAFF"},
		{image = "files/help/taxi.png", x1=1118, y1=480, x2=185, y2=35, tipo="TÁXI"},
		{image  = "files/borda.png", x1=1061, y1=145, x2=305, y2=670}
	},
	["loc"] = {
		{image = "files/loc/fundo.png", x1=1084, y1=220, x2=252, y2=508},
		{image = "files/loc/botao.png", x1=1176, y1=410, x2=145, y2=25},
		{image  = "files/borda.png", x1=1061, y1=145, x2=305, y2=670}
	}
}

local tonumbersPOS = {
	{number = 1, x1=1116, y1=387, x2=50, y2=50},
	{number = 2, x1=1185, y1=387, x2=50, y2=50},
	{number = 3, x1=1254, y1=387, x2=50, y2=50},
	{number = 4, x1=1116, y1=456, x2=50, y2=50},
	{number = 5, x1=1185, y1=456, x2=50, y2=50},
	{number = 6, x1=1254, y1=456, x2=50, y2=50},
	{number = 7, x1=1116, y1=524, x2=50, y2=50},
	{number = 8, x1=1185, y1=524, x2=50, y2=50},
	{number = 9, x1=1254, y1=524, x2=50, y2=50},
	{number = 0, x1=1185, y1=593, x2=50, y2=50}
}

local editBox = {}

function addEdit(type)
  if tostring(type) == "del" then
    for i = 1, 6 do
      if isElement(editBox[i]) then
        destroyElement(editBox[i])
      end
    end
  elseif tostring(type) == "number" then
    editBox[1] = guiCreateEdit(-1000, -1000, 0, 0, "insira o id", false)
    guiEditSetMaxLength(editBox[1], 5)
  elseif tostring(type) == "mensage" then
 	editBox[1] = guiCreateEdit(x*1115, y*347, x*100, y*30, "insira o id", false)
    guiEditSetMaxLength(editBox[1], 11)
 	editBox[2] = guiCreateEdit(x*1115, y*384, x*193, y*50, "insira a mensagem", false)
    guiEditSetMaxLength(editBox[2], 500)
  elseif tostring(type) == "localizion" then
 	editBox[1] = guiCreateEdit(x*1112, y*409, x*55, y*20, "ID", false)
    guiEditSetMaxLength(editBox[1], 11)
  end
end

function Draw()
	for i,v in pairs(painelTable[screen]) do
		dxDrawImage( x*painelTable[screen][i]['x1'], y*painelTable[screen][i]['y1'], x*painelTable[screen][i]['x2'], y*painelTable[screen][i]['y2'], painelTable[screen][i]['image'], 0, 0, 0, tocolor(255,255,255,255), false )
		if painelTable[screen][i]['image'] ~= "files/home/home.png" and painelTable[screen][i]['image'] ~= "files/call/fundo.png" and painelTable[screen][i]['image'] ~= "files/borda.png" and painelTable[screen][i]['image'] ~= "files/msg/fundo.png" and painelTable[screen][i]['image'] ~= "files/loc/fundo.png" and painelTable[screen][i]['image'] ~= "files/help/socorros.png" and painelTable[screen][i]['image'] ~= "files/help/ajudas.png" then
			if isCursorOnElement(x*painelTable[screen][i]['x1'], y*painelTable[screen][i]['y1'], x*painelTable[screen][i]['x2'], y*painelTable[screen][i]['y2']) then
				dxDrawImage( x*painelTable[screen][i]['x1']-1, y*painelTable[screen][i]['y1']-1, x*painelTable[screen][i]['x2']+2, y*painelTable[screen][i]['y2']+2, painelTable[screen][i]['image'], 0, 0, 0, tocolor(255,255,255,255), false )
			end
		end
	end
	if screen == "call" then
		dxDrawText(guiGetText(editBox[1]), x*1221, y*351, x*1304, y*365, tocolor(150, 150, 150, 255), 1, "default-bold", "right", "top", false, false, true, false)
	end
	if screen == "calling" then
		dxDrawText(destinyName, x*1141, y*402, x*1287, y*430, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false)
	end
	if screen == "callingyou" then
		dxDrawText(callingName, x*1141, y*402, x*1287, y*430, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false)
	end
	if screen == "loc" then
		dxDrawText(getZoneName(getElementPosition(localPlayer)), x*1207, y*383, x*1322, y*399, tocolor(255, 255, 0, 255), 1, "default", "center", "top", false, false, true, false)
	end
end

function Abrir()
	if tela == false then
		tela = true
		addEventHandler("onClientRender", root, Draw)
		if not isCursorShowing() then
			showCursor(true)
		end
	else
		if not getElementData( localPlayer, "em_chamada") then
			tela = false
			removeEventHandler("onClientRender", root, Draw)
			screen = "home"
			if isCursorShowing() then
				showCursor(false)
			end
			if addEdit then
				addEdit("del")
			end
		else
			outputChatBox("#FF0000[ERRO] #FFFFFF Você está em uma ligação !", 255, 255, 255, true)
		end
	end
end
bindKey( "b", "down", Abrir )

digitos = 0

aceita = false
encerrado = false

function receber_call(emisor, id)
	screen = "callingyou"
	callingName = tostring(emisor)
	encerrado = false
	toque = playSound( "files/callingyou/sound.mp3", true)
	setTimer(function()
		if not aceita and not encerrado then
			desligar()
		end
	end, 30000, 1)
	function atenderCall()
		if isElement( toque ) then
			stopSound(toque)
		end
		aceita = true
		encerrado = false
		triggerServerEvent( "atender", localPlayer, localPlayer, tonumber(id))
	end
	function desligar()
		triggerServerEvent( "desligar", localPlayer, localPlayer, tonumber(id))
		encerrado = true
		if isElement( toque ) then
			stopSound(toque)
		end
		setElementData(localPlayer, "em_chamada", nil)
		screen = "home"
		if addEdit then
			addEdit("del")
		end
		outputChatBox("encerrada a ligação", 255, 255, 255, true)
	end
end
addEvent("receber_call", true)
addEventHandler("receber_call", root, receber_call)

function enviar_call(receptor, id)
	screen = "calling"
	destinyName = tostring(receptor)
	encerrado = false
	function desligar()
		triggerServerEvent( "desligar", localPlayer, localPlayer, tonumber(id))
		encerrado = true
		if isElement( toque ) then
			stopSound(toque)
		end
		setElementData(localPlayer, "em_chamada", nil)
		screen = "home"
		if addEdit then
			addEdit("del")
		end
		outputChatBox("encerrada a ligação", 255, 255, 255, true)
	end
end
addEvent("enviar_call", true)
addEventHandler("enviar_call", root, enviar_call)

addEventHandler("onClientClick", root, function(_, state)
	if tela == true and state == "down" then
		if screen == "home" then
			for i,v in pairs(painelTable["home"]) do -- cliques da tela incial
				if isCursorOnElement(x*painelTable["home"][i]['x1'], y*painelTable["home"][i]['y1'], x*painelTable["home"][i]['x2'], y*painelTable["home"][i]['y2']) then
					if (i) == 2 then
						screen = "call"
						addEdit("number")
					elseif (i) == 3 then
						screen = "msg"
						addEdit("mensage")
					elseif (i) == 4 then
						screen = "help"
					elseif (i) == 5 then
						screen = "loc"
						addEdit("localizion")
					end
				end
			end
		elseif screen == "call" then
			for i,v in pairs(tonumbersPOS) do -- clique das teclas
				if isCursorOnElement(x*tonumbersPOS[i]['x1'], y*tonumbersPOS[i]['y1'], x*tonumbersPOS[i]['x2'], y*tonumbersPOS[i]['y2']) then
					if  guiGetText(editBox[1]) == "insira o id" then
						digitos = 0
						guiSetText(editBox[1], "")
					end
					if digitos < 5 then
						digitos = digitos + 1
						guiSetText( editBox[1], guiGetText(editBox[1])..tonumbersPOS[i]["number"])
					end
				end
			end
			for i,v in pairs(painelTable[screen]) do -- clique de chamar emergencia
				if isCursorOnElement(x*painelTable[screen][i]['x1'], y*painelTable[screen][i]['y1'], x*painelTable[screen][i]['x2'], y*painelTable[screen][i]['y2']) then
					if (i) == 2 then
						if not getElementData(localPlayer, "em_chamada") then
							setElementData(localPlayer, "em_chamada", true)
							triggerServerEvent("ligar", localPlayer, localPlayer, tonumber(guiGetText(editBox[1])))
						else
							outputChatBox("#FF0000[ERRO] #FFFFFFVocê ja está em uma ligação", 255, 255, 255, true)
						end
					end
				end
			end
		elseif screen == "msg" then
			if isCursorOnElement(x*painelTable[screen][2]['x1'], y*painelTable[screen][2]['y1'], x*painelTable[screen][2]['x2'], y*painelTable[screen][2]['y2']) then
				if getPlayerMoney(localPlayer) >= 15 then
					triggerServerEvent( "enviar_mensagem", localPlayer, localPlayer, guiGetText(editBox[1]), guiGetText(editBox[2]))
				else
					outputChatBox("#FF0000[ERRO] #FFFFFFDinheiro Insuficiente, Min 15,00 R$", 255, 255, 255, true)
				end
			end
		elseif screen == "help" then
			for i,v in pairs(painelTable[screen]) do -- clique de chamar emergencia
				if isCursorOnElement(x*painelTable[screen][i]['x1'], y*painelTable[screen][i]['y1'], x*painelTable[screen][i]['x2'], y*painelTable[screen][i]['y2']) then
					if (i) ~= 1 and (i) ~= 2 and (i) ~= 3 and (i) ~= 4 and (i) ~= 10 then
						if not getElementData(localPlayer, "chamada:"..tostring(painelTable[screen][i]['tipo'])) then
							setElementData(localPlayer, "chamada:"..tostring(painelTable[screen][i]['tipo']), true)
							triggerServerEvent("event:"..tostring(painelTable[screen][i]['tipo']), localPlayer, localPlayer, tostring(painelTable[screen][i]['tipo']))
						else
							outputChatBox("#FF0000[ERRO] #FFFFFFVocê ja chamou: "..tostring(painelTable[screen][i]['tipo']), 255, 255, 255, true)
						end
					end
				end
			end
		elseif screen == "calling" then
			for i,v in pairs(painelTable[screen]) do
				if isCursorOnElement(x*painelTable[screen][i]['x1'], y*painelTable[screen][i]['y1'], x*painelTable[screen][i]['x2'], y*painelTable[screen][i]['y2']) then
					if (i) == 3 then
						desligar()
					end
				end
			end
		elseif screen == "callingyou" then
			for i,v in pairs(painelTable[screen]) do
				if isCursorOnElement(x*painelTable[screen][i]['x1'], y*painelTable[screen][i]['y1'], x*painelTable[screen][i]['x2'], y*painelTable[screen][i]['y2']) then
					if (i) == 4 then
						desligar()
					elseif (i) == 3 then
						atenderCall()
					end
				end
			end
		end
		if isCursorOnElement(x*1116, y*232, x*9, y*20) then
			screen = "home"
			if addEdit then
				addEdit("del")
			end
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
