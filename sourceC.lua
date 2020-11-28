screenW, screenH = guiGetScreenSize()
x, y = (screenW/1920), (screenH/1080)
Roboto = dxCreateFont("files/fonts/Roboto.ttf", 15)

abas = {"Inicio", "Propriedades", "Grupos"}
guia = abas[1]
painel = false
selecionado = 0
buySlot = false
slotPrice = 5000
grupos = { }
gruposAttach = { }

function getPlayerFromID(id)
    for i,v in ipairs(getElementsByType("player")) do
        if (getElementData(v, "ID") or 0) == tonumber(id) then
            return v
        end
    end
end

function getStatusFaction(destiny, carg)
        types ={
            {1, "pm"},
            {2, "fac"}
        }
        for i,v in ipairs(types) do
            if v[2] == tonumber(carg) then
                if (getElementData(destiny, v[2]..":servico")) then
                    return "#00FF00Em serviço"
                else
                    return "#FF9090Fora de serviço"
                end
            end
        end
end

function getFactionName(groupID)
    local total = 0
    for i=1,#grupos do
        if grupos[i]['ID'] == tonumber(groupID) then
            return grupos[i]['Name']
        end
    end
end

function reloadListC1(tableSqlite)
    if type(tableSqlite) == "table" then
        grupos = tableSqlite
    end
end
addEvent("hrReloadList1C", true)
addEventHandler("hrReloadList1C", root, reloadListC1)

function reloadListC2(tableSqlite)
    if type(tableSqlite) == "table" then
        gruposAttach = tableSqlite
    end
end
addEvent("hrReloadList2C", true)
addEventHandler("hrReloadList2C", root, reloadListC2)

function renderDash()
        local PlayerName = localPlayer:getData("AirNew_RG_NomeCompleto") or "Desconhecido"
        local PlayerJob = localPlayer:getData("Emprego") or "Desempregado"
        local PlayerLevel = localPlayer:getData("Level") or 0
        local PlayerMoney = getPlayerMoney(localPlayer)
        local PlayerPremiumPoints = localPlayer:getData("char:pp") or 0

		dxDrawRectangle(0, 0, screenW, screenH, tocolor(10, 10, 10, 150))
		dxDrawRoundedRectangle(x*480, y*270, x*960, y*540, tocolor(20, 20, 20, 250), 5)
		dxDrawRoundedRectangle(x*480, y*270, x*960, y*70, tocolor(200, 200, 200, 250), 5)
		dxDrawText("BspLite - DashBoard", x*500, y*270, x*1440, y*340, tocolor(0, 0, 0, 255), x*1, Roboto, "left", "center", false, false, true, false, false)
		for i,v in ipairs(abas) do
			if isInSlot(x*(730 + 180 * i), y*280, x*150, y*50) == false then
				dxDrawRoundedRectangle(x*((730+1) + 180 * i), y*(280+1), x*(150+2.5), y*(50+2.5), tocolor(0, 0, 0, 200), 5)
				dxDrawRoundedRectangle(x*(730 + 180 * i), y*280, x*150, y*50, tocolor(150, 150, 150, 250), 5)
				dxDrawText(v, x*(730 + 180 * i), y*260, x*(880 + 180 * i), y*350, tocolor(0, 0, 0, 255), x*1, Roboto, "center", "center", false, false, true, false, false)
			else
				dxDrawRoundedRectangle(x*((730+1) + 180 * i), y*(280+1), x*(150+2.5), y*(50+2.5), tocolor(0, 0, 0, 200), 5)
				dxDrawRoundedRectangle(x*(730 + 180 * i), y*280, x*150, y*50, tocolor(255, 100, 50, 250), 5)
				dxDrawText(v, x*(730 + 180 * i), y*260, x*(880 + 180 * i), y*350, tocolor(255, 255, 255, 255), x*1, Roboto, "center", "center", false, false, true, false, false)				
			end
		end
		if guia == abas[1] then
			dxDrawImage(x*500, y*370, x*50, y*50, "files/images/tabs/informations.png")
            dxDrawImage(728, 270, 270, 270, ":Script-Hud/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, 20), false)
            dxDrawText(PlayerName, 785, 270, 998, 305, tocolor(255, 255, 255, 255), 1.50, "default", "right", "center", true, false, false, false, false)
            dxDrawText(PlayerJob, 785, 305, 998, 340, tocolor(255, 255, 255, 255), 1.20, "default", "right", "center", true, false, false, false, false)
            dxDrawText("Level: "..PlayerLevel, 785, 340, 998, 375, tocolor(255, 255, 255, 255), 1.20, "default", "right", "center", true, false, false, false, false)
            dxDrawText("Dinheiro: "..PlayerMoney, 785, 375, 998, 410, tocolor(255, 255, 255, 255), 1.20, "default", "right", "center", true, false, false, false, false)
            dxDrawText("Premium Points: "..PlayerPremiumPoints, 785, 410, 998, 445, tocolor(255, 255, 255, 255), 1.20, "default", "right", "center", true, false, false, false, false)
		elseif guia == abas[2] then
            dxDrawImage((x*500), (y*370), x*50, y*50, "files/images/tabs/property.png")
            for i=1,8 do
                if isInSlot(x*500, (y*435) + i * 28, x*353, y*37) then
                    dxDrawRectangle(x*500, (y*435) + i * 28, x*353, y*37, tocolor(255, 100, 50, 188), false)
                else
                    dxDrawRectangle(x*500, (y*435) + i * 28, x*353, y*37, tocolor(0, 0, 0, 188), false)
                end
                if selecionado >= 1 then
                    dxDrawRectangle(x*500, (y*435) + selecionado * 28, x*353, y*37, tocolor(255, 100, 50, 188), false)
                end
            end
            totalDeVeiculos = 0
            for i,data in ipairs((localPlayer:getData("TS:VeiculosInfo") or { })) do
                dxDrawText(data['NomeVeiculo'], x*500, (y*400) + i * 28, x*853, (y*504) + i * 28, tocolor(255, 255, 255, 255), 1.20, "default", "center", "center", false, false, false, true, false)
                totalDeVeiculos = totalDeVeiculos + 1
            end
            dxDrawRectangle(x*500, (y*316) + (y*100), x*203, y*37, tocolor(255, 255, 255, 255), false)
            dxDrawText("VEICULOS", x*500, (y*280) + (y*120), x*703, (y*345) + (y*120), tocolor(0, 0, 0, 188), 1.20, "default", "center", "center", false, false, false, false, false)
            if isInSlot(x*710, (y*316) + (y*100), x*153, y*37) == false then
                dxDrawRectangle(x*710, (y*316) + (y*100), x*153, y*37, tocolor(255, 255, 255, 255), false)
                dxDrawText("COMPRAR SLOTS", x*710, (y*280) + (y*120), x*863, (y*345) + (y*130), tocolor(0, 0, 0, 188), 1, "default", "center", "center", false, false, false, false, false)
            else
                dxDrawRectangle(x*710, (y*316) + (y*100), x*153, y*37, tocolor(255, 100, 50, 255), false)
                dxDrawText("COMPRAR SLOTS", x*710, (y*280) + (y*120), x*863, (y*345) + (y*130), tocolor(0, 0, 0, 188), 1, "default", "center", "center", false, false, false, false, false)
            end
            dxDrawRectangle(x*780, (y*316) + (y*50), x*78, y*37, tocolor(255, 255, 255, 255), false)
            dxDrawText(totalDeVeiculos.."/"..(localPlayer:getData("veh:slots") or 2), x*780, (y*316) + (y*50), x*858, y*403, tocolor(0, 0, 0, 188), 1.20, "default", "center", "center", false, false, false, false, false)
            if isInSlot(x*860, y*700, x*233, y*37) then
                dxDrawRectangle(x*860, y*700, x*233, y*37, tocolor(255, 100, 50, 188), false)
            else
                dxDrawRectangle(x*860, y*700, x*233, y*37, tocolor(90, 90, 90, 188), false)
            end

            if isInSlot(x*860, y*740, x*233, y*37) then
                dxDrawRectangle(x*860, y*740, x*233, y*37, tocolor(255, 100, 50, 188), false)
            else
                dxDrawRectangle(x*860, y*740, x*233, y*37, tocolor(90, 90, 90, 188), false)
            end
            dxDrawText("VENDER", x*860, y*700, x*1093, y*737, tocolor(255, 255, 255, 255), 1.20, "default", "center", "center", false, false, false, false, false)
            dxDrawText("LOCALIZAR", x*860, y*740, x*1093, y*777, tocolor(255, 255, 255, 255), 1.20, "default", "center", "center", false, false, false, false, false)
            if buySlot then
                dxDrawRectangle(x*860, y*493, x*278, y*84, tocolor(0, 0, 0, 150), false)
                dxDrawRectangle(x*860, y*493, x*278, y*25, tocolor(0, 0, 0, 150), false)
                dxDrawText("+1 slot de veiculos = 5.000pp", x*860, y*493, x*1138, y*518, tocolor(255, 255, 255, 255), x*1.00+(x*0.50), "default-bold", "center", "center", false, false, false, false, false)
                if isInSlot(x*870, y*528, x*121, y*39) then
                    dxDrawRectangle(x*870, y*528, x*121, y*39, tocolor(90, 255, 100, 150), false)
                else
                    dxDrawRectangle(x*870, y*528, x*121, y*39, tocolor(94, 253, 146, 150), false)
                end
                if isInSlot(x*1007, y*528, x*121, y*39) then
                    dxDrawRectangle(x*1007, y*528, x*121, y*39, tocolor(255, 80, 80, 150), false)
                else
                    dxDrawRectangle(x*1007, y*528, x*121, y*39, tocolor(255, 93, 93, 150), false)
                end
                dxDrawText("COMPRAR", x*870, y*528, x*991, y*567, tocolor(0, 0, 0, 255), x*1.00+(x*0.50), "default", "center", "center", false, false, false, false, false)
                dxDrawText("CANCELAR", x*1007, y*528, x*1128, y*567, tocolor(0, 0, 0, 255), x*1.00+(x*0.50), "default", "center", "center", false, false, false, false, false)
            end
        elseif guia == abas[3] then
            dxDrawImage(x*500, y*370, x*50, y*50, "files/images/tabs/groups.png")
            dxDrawRectangle(x*512, y*434, x*652, y*334, tocolor(30, 30, 30, 255))
            dxDrawRoundedRectangle(x*1177, y*434, x*230, y*334, tocolor(30, 30, 30, 255), 5)
            if grupos and gruposAttach then
                for i,v in ipairs(grupos) do
                    for i2,v2 in ipairs(gruposAttach) do
                        if v2['DutyId'] == v['ID'] then     
                            if isInSlot(x*1177, y*405 + i * 28, x*230, y*30) == false then
                                dxDrawRectangle(x*1177, y*405 + (i * 28), x*230, y*30, tocolor(50, 50, 50, 255))
                            else
                                dxDrawRectangle(x*1177, y*405 + (i * 28), x*230, y*30, tocolor(255, 100, 50, 255))
                            end
                            if selecionado >= 1 then
                                dxDrawRectangle(x*512, y*434, x*652, y*50, tocolor(255, 90, 50, 255))
                                dxDrawText(grupos[selecionado]['Name'], x*512, y*434, (x*512) + (x*652), (y*434) + (y*50), tocolor(255, 255, 255, 255), x*1.00+(x*0.50), "default-bold", "center", "center", false, false, false, false, false)
                                local variavelTeste = 0
                                for i,v in ipairs(gruposAttach) do
                                    if v['DutyId'] == grupos[selecionado]['ID'] then
                                        variavelTeste = variavelTeste + 1
                                        dxDrawRectangle(x*512, y*450 + variavelTeste * 15, x*652, y*20, tocolor(50, 50, 50, 255))
                                        local destiny = getPlayerFromID( v['ID'] )
                                        if destiny then
                                            local playerName = getPlayerName(destiny)
                                            local playerId = localPlayer:getData("ID") or 0
                                            --local status = getStatusFaction(destiny, grupos[selecionado]['Type']) or 
                                            local name = "   "..playerName.."("..playerId..")"--..status
                                            dxDrawText(name.." - #00FF00ONLINE", x*512, y*450 + variavelTeste * 15, (x*652) + (x*512), (y*20) + (y*450 + variavelTeste * 15), tocolor(255, 255, 255, 255), x*1.00+(x*0.50), "default-bold", "left", "center", false, false, false, true, false)
                                        end
                                    end
                                end
                            end
                            dxDrawText(v['Name'], x*1177, y*405 + i * 28, (x*230) + (x*1177), (y*30) + (y*405 + i * 28), tocolor(255, 255, 255, 255), x*1.00+(x*0.50), "default-bold", "center", "center", false, false, false, false, false)
                            if isInSlot(x*1177, y*405 + i * 28, x*230, y*30) == false then
                                dxDrawRectangle(x*1177, y*405 + i * 28, x*230, y*30, tocolor(50, 50, 50, 255))
                            else
                                dxDrawRectangle(x*1177, y*405 + i * 28, x*230, y*30, tocolor(255, 100, 50, 255))
                            end
                            dxDrawText(v['Name'], x*1177, y*405 + i * 28, (x*230) + (x*1177), (y*30) + (y*405 + i * 28), tocolor(255, 255, 255, 255), x*1.00+(x*0.50), "default-bold", "center", "center", false, false, false, false, false)
                        end
                    end
                end
            end
        end
        dxDrawText(guia, x*570, y*370, x*1000, y*420, tocolor(255, 255, 255, 255), x*1, Roboto, "left", "center", false, false, true, false, false)

end

bindKey("F4", "down", function()
    if painel then
        removeEventHandler("onClientRender", root, renderDash)
        painel = false
    else
        addEventHandler("onClientRender", root, renderDash)
        painel = true
    end
end)

addEventHandler("onClientClick", root, function(a, s)
    if s == "down" and painel then
        for i,v in ipairs(abas) do
            if isInSlot(x*(730 + 180 * i), y*280, x*150, y*50) then
                guia = v
                selecionado = 0
            end
        end
        if guia == abas[2] then
            for i,data in ipairs((localPlayer:getData("TS:VeiculosInfo") or { })) do
                if isInSlot(x*500, (y*435) + i * 28, x*353, y*37) then
                    selecionado = i
                end
            end
            if isInSlot(x*860, y*740, x*233, y*37) then
                local data = (localPlayer:getData("TS:VeiculosInfo") or { })
                exports.Script_Concessionaria:hrLocalizar(localPlayer, data[selecionado]["NomeVeiculo"], data[selecionado]["IDVeiculo"], data[selecionado]["ID"], data[selecionado]["Valor"])
            end
            if isInSlot(x*860, y*700, x*233, y*37) then
                local data = (localPlayer:getData("TS:VeiculosInfo") or { })
                exports.Script_Concessionaria:hrVender(localPlayer, data[selecionado]["IDVeiculo"], data[selecionado]["NomeVeiculo"])
            end
            if isInSlot(x*710, (y*316) + (y*100), x*153, y*37) then
                if buySlot == false then
                    if (localPlayer:getData("veh:slots") or 2) < 8 then
                        buySlot = true
                    else
                        exports['a_infobox']:showInfobox("error", "Você ja tem o máximo de slots necessários.")
                    end
                end
            end
            if buySlot then
                if isInSlot(x*1007, y*528, x*121, y*39) then
                    buySlot = false
                end
                if isInSlot(x*870, y*528, x*121, y*39) then
                    buySlot = false
                    local ppData = (localPlayer:getData("char:pp") or 0)
                    if ppData >= slotPrice then
                        triggerServerEvent("hrBuySlots", localPlayer, localPlayer, ppData, slotPrice)
                    else
                        exports['a_infobox']:showInfobox("error", "Premium Points Insuficente !")
                    end
                end
            end
        elseif guia == abas[3] then
            for i,v in ipairs(grupos) do
                for i2,v2 in ipairs(gruposAttach) do
                    if v2['DutyId'] == v['ID'] then     
                        if isInSlot(x*1177, y*405 + i * 28, x*230, y*30)then
                            selecionado = i
                        end
                    end
                end
            end
        end
    end
end)

--//     ASSETS

function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius
    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)
        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end

function isInSlot( posX, posY, width, height )
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

function playerIsFaction(player, groupID)
    playerId = getElementData(player, "ID") or 0
    local total = 0
    for i=1,#gruposAttach do
        if gruposAttach[i]['ID'] == playerId and gruposAttach[i]['DutyId'] == tonumber(groupID) then
            total = total + 1
        end
    end
    if total >= 1 then
        return true
    else
        return false
    end
end