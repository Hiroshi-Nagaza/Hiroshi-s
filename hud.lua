local screenW, screenH = guiGetScreenSize()
local x, y  =  (screenW/1366), (screenH/768)

local tableHud = {
	{image = "files/fundo.png", x1 = 1089, y1 = 706, x2 = 250, y2 = 50},
	{image = "files/mic.png", x1 = 1104, y1 = 721, x2 = 15.17, y2 = 20.58},
	{image = "files/NORMAL.png", x1 = 1127, y1 = 722, x2 = 73, y2 = 13},
	{image = "files/fundos.png", x1 = 1214, y1 = 718, x2 = 109, y2 = 25},
}

local iconesHUD = {
	{image = "files/icone_vida.png", x1 = 1219, y1 = 723, x2 = 15, y2 = 15},
	{image = "files/icone_colete.png", x1 = 1247, y1 = 722, x2 = 15, y2 = 18.01},
	{image = "files/icone_fome.png", x1 = 1275, y1 = 723, x2 = 15, y2 = 15},
	{image = "files/icone_sede.png", x1 = 1305, y1 = 723, x2 = 12, y2 = 17},
}

local logo = {
	{image = "files/logo.png", x1 = 1214, y1 = 0, x2 = 150, y2 = 150}
}

local velocimetro = {
	{image = "files/fundo_gasolina.png", x1 = 652, y1 = 674, x2 = 61, y2 = 61},
	--{image = "files/icone_gasolina.png", x1 = 670, y1 = 692, x2 = 25, y2 = 25},
	{image = "files/engine.png", x1 = 723, y1 = 683, x2 = 23.83, y2 = 17.33},
	{image = "files/luz.png", x1 = 755, y1 = 681, x2 = 22.75, y2 = 22.75},
	{image = "files/door.png", x1 = 725, y1 = 709, x2 = 17, y2 = 16.11},
	{image = "files/cinto.png", x1 = 759, y1 = 707, x2 = 15, y2 = 17.4},
}

local iconVelo = {
	{image = "files/icone_gasolina.png", x1 = 670, y1 = 692, x2 = 25, y2 = 25}
}

randX = 0
randY = 0
randW = 0
randH = 0
alpha = 0

addEventHandler("onClientRender", root, function()
	sede = getElementData(localPlayer, "char:thirst") or 0
	fome  = getElementData(localPlayer, "char:hunger") or 0
	colete = getPedArmor(localPlayer)
	vida = getElementHealth(localPlayer)
	for i,v in pairs(tableHud) do
		dxDrawImage( x*tableHud[i]['x1'], y*tableHud[i]['y1'], x*tableHud[i]['x2'], y*tableHud[i]['y2'], tableHud[i]['image'], 0, 0, 0, tocolor(255,255,255,255), false )
		if voice then
			randX = math.random(1, 2)
			randY = math.random(1, 2)
			randW = math.random(2, 3)
			randH = math.random(2, 3)
			dxDrawImage( x*tableHud[2]['x1']-randX, y*tableHud[2]['y1']-randY, x*tableHud[2]['x2']+randW, y*tableHud[2]['y2']+randH, tableHud[2]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
		end
	end
	dxDrawImageSection(x*1214,  y*718, x*25, y*25*vida/100, 0, 0, x*25,  y*25*vida/100, "files/vida.png")
	dxDrawImageSection(x*1242,  y*718, x*25, y*25*colete/100, 0, 0, x*25,  y*25*colete/100, "files/colete.png")
	dxDrawImageSection(x*1270,  y*718, x*25, y*25*fome/100, 0, 0, x*25,  y*25*fome/100, "files/fome.png")
	dxDrawImageSection(x*1298,  y*718, x*25, y*25*sede/100, 0, 0, x*25,  y*25*sede/100, "files/sede.png")
	for i,v in pairs(iconesHUD) do
		dxDrawImage( x*iconesHUD[i]['x1'], y*iconesHUD[i]['y1'], x*iconesHUD[i]['x2'], y*iconesHUD[i]['y2'], iconesHUD[i]['image'], 0, 0, 0, tocolor(255,255,255,255), false )
	end
	if alpha < 255 then
		alpha = alpha + 5
	else
		alpha = 0
	end
	for i,v in pairs(logo) do
		dxDrawImage( x*logo[i]['x1'], y*logo[i]['y1'], x*logo[i]['x2'], y*logo[i]['y2'], logo[i]['image'], 0, 0, 0, tocolor(alpha,alpha,alpha,255), false )
	end
end)

AnimY = 1000
addEventHandler("onClientRender", root, function()
	in_vehicle = getPedOccupiedVehicle(localPlayer)
	if in_vehicle then
		if getVehicleEngineState ( in_vehicle, true ) then
			AnimY = 1000
			local gasolina = getElementData(in_vehicle, "veh:fuel") or 0
			for i,v in pairs(velocimetro) do
				dxDrawImage( x*velocimetro[i]['x1'], y*velocimetro[i]['y1'], x*velocimetro[i]['x2'], y*velocimetro[i]['y2'], velocimetro[i]['image'], 0, 0, 0, tocolor(200,200,200,200), false )
				dxDrawImageSection(x*651,  y*674, x*60, y*60*gasolina/100, 0, 0, x*65, y*65*gasolina/100, "files/gasolina.png")
			end
			for i,v in pairs(iconVelo) do
				dxDrawImage( x*iconVelo[i]['x1'], y*iconVelo[i]['y1'], x*iconVelo[i]['x2'], y*iconVelo[i]['y2'], iconVelo[i]['image'], 0, 0, 0, tocolor(255,255,255,255), false )
			end
			dxDrawImage( x*velocimetro[2]['x1'], y*velocimetro[2]['y1'], x*velocimetro[2]['x2'], y*velocimetro[2]['y2'], velocimetro[2]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
			vehicleSpeed = getElementSpeed(in_vehicle,1)
			local getSpeed = string.format("%03d",vehicleSpeed)
	        dxDrawText(getSpeed.."\n KM", x*620-1, y*676-1, x*641+2, y*735+2, tocolor(0, 0, 0, 255), 1.5, "default", "right", "top", false, false, true)
	        dxDrawText(getSpeed.."\n KM", x*620, y*676, x*641, y*735, tocolor(255, 255, 255, 255), 1.5, "default", "right", "top", false, false, true)
		else
			if AnimY > 674 then
				AnimY = AnimY - 10
			else
				AnimY = 674
			end
			dxDrawText("VEICULO DESLIGADO \n'J' PARA LIGAR", x*651-1,  y*AnimY-1, x*711+2, y*734+2, tocolor(0, 0, 0, 255), 2, "default", "center", "top", false, false, true)
			dxDrawText("VEICULO DESLIGADO \n'J' PARA LIGAR", x*651,  y*AnimY, x*711, y*734, tocolor(255, 255, 255, 255), 2, "default", "center", "top", false, false, true)
		end
		if isVehicleLocked( in_vehicle ) or ( getElementData( in_vehicle, "cl_vehiclelocked" ) ) then 
			dxDrawImage( x*velocimetro[4]['x1'], y*velocimetro[4]['y1'], x*velocimetro[4]['x2'], y*velocimetro[4]['y2'], velocimetro[4]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
		end
		if getVehicleOverrideLights ( in_vehicle ) == 2 then
			dxDrawImage( x*velocimetro[3]['x1'], y*velocimetro[3]['y1'], x*velocimetro[3]['x2'], y*velocimetro[3]['y2'], velocimetro[3]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
		end
		if getElementData(localPlayer, "ov") then
			dxDrawImage( x*velocimetro[5]['x1'], y*velocimetro[5]['y1'], x*velocimetro[5]['x2'], y*velocimetro[5]['y2'], velocimetro[5]['image'], 0, 0, 0, tocolor(90,90,255,255), false )
		end
	end
end)



--//complementos
g_Player = getLocalPlayer()
function getVehicleSpeed()
    if isPedInVehicle(g_Player) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(g_Player))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 187.5
    end
    return 0
end
function getElementSpeed(element,unit)
    assert(isElement(element), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(element) .. ")")
    assert(getElementType(element) == "player" or getElementType(element) == "ped" or getElementType(element) == "object" or getElementType(element) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(element) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(element)) * mult).length
end

function toggleRadar()
	if isVisible then
		addEventHandler("onClientRender", root, hud )
	else
		removeEventHandler("onClientRender", root, hud )
	end
	isVisible = not isVisible
end
bindKey ("F11", "down", toggleRadar)

local components = {"weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted", "vehicle_name", "area_name", "radio"}
function onClientResourceStart()
	sAlpha = 200
	for _, component in ipairs(components) do
		setPlayerHudComponentVisible(component, false)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onClientResourceStart)

function onClientResourceStop()
	for _, component in ipairs(components) do
		setPlayerHudComponentVisible(component, true)
	end
end
addEventHandler("onClientResourceStop", resourceRoot, onClientResourceStop)

function getPedMaxHealth(ped)
	assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")
	local stat = getPedStat(ped, 24)
	local maxhealth = 100 + (stat - 569) / 4.31
	return math.max(1, maxhealth)
end

addEventHandler("onClientPlayerVoiceStart", localPlayer,
	function()
		voice= true
	end
)

addEventHandler("onClientPlayerVoiceStop", localPlayer,
	function()
		voice= false
	end
)

local veh = false
local nosOn = false
bindKey("vehicle_fire", "both",
function(_,state)
        veh = getPedOccupiedVehicle(localPlayer)
        if veh and state == "up" and isVehicleNitroActivated(veh) and getVehicleController(veh) == localPlayer then
                setVehicleNitroActivated(veh, false)
                nosOn = false
        elseif veh and state == "down" and getVehicleController(veh) == localPlayer then
                setVehicleNitroActivated(veh, true)
                nosOn = true
        end
end)

-- Autor: Hiroshi
