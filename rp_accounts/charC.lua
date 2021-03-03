screenW, screenH = guiGetScreenSize()
resW, resH = (1366), (768)
sx, sy = (screenW/resW), (screenH/resH)
panel = false
Gender = nil
SkinID = 1
playerDataTable = {}

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
	triggerServerEvent( "verificar_conta", localPlayer, localPlayer)
end)

editBox = {}
function addEdit(mode)
	if tostring(mode) == "del" then
		for i = 1, #editBox do
			if isElement(editBox[i]) then
				destroyElement(editBox[i])
			end
		end
	elseif tostring(mode) == "accountsfalse" then

		editBox[1] = guiCreateEdit(-1000, -1000, 0, 0, "Usuário", false)
		guiEditSetMaxLength(editBox[1], 22)

		editBox[2] = guiCreateEdit(-1000, -1000, 0, 0, "Senha", false)
		guiEditSetMaxLength(editBox[2], 22)

		editBox[3] = guiCreateEdit(-1000, -1000, 0, 0, "Nome e Sobrenome", false)
		guiEditSetMaxLength(editBox[3], 22)

		editBox[4] = guiCreateEdit(-1000, -1000, 0, 0, "Idade", false)
		guiEditSetMaxLength(editBox[3], 4)

		editBox[5] = guiCreateEdit(-1000, -1000, 0, 0, "Masculino", false)
		Gender = 'ferfi'
		guiEditSetMaxLength(editBox[3], 22)

	elseif tostring(mode) == "accountstrue" then

		editBox[1] = guiCreateEdit(-1000, -1000, 0, 0, "Senha", false)
		guiEditSetMaxLength(editBox[1], 22)

	end
end

addEvent("uptdateClient", true)
addEventHandler("uptdateClient", root, function(show, tableExported, tableExported2, state)
	if show == true then
		if state then
			playerDataTable = tableExported
			person_DataTable = {}
			for i,v in ipairs(tableExported2) do
				person_DataTable['charname'] = v['charname']
				person_DataTable['money'] = v['money']
				person_DataTable['bankmoney'] = v['bankmoney']
			end
			for i,v in ipairs(playerDataTable) do
				playerDataTable['avatar'] = v['avatar']
				playerDataTable['username'] = v['username']
				playerDataTable['password'] = v['password']
			end
		else
			playerDataTable['avatar'] = '0'
		end
		panel = true
		account = tostring(state)
		addEdit('accounts'..account)
		section = 'home'..account
		showChat(false)
		showCursor(true)
		addEventHandler('onClientRender', getRootElement(), renderDx)
	else
		removeEventHandler('onClientRender', getRootElement(), renderDx)
		panel = false
		section = nil
		showChat(true)
		showCursor(false)
		addEdit('del')
	end
end)

function passwordHash(password)
	if password ~= 'Senha' then
	    local length = utfLen(password)

	    if length > 23 then
	        length = 23
	    end
	    return string.rep("*", length)
	else
		return password
	end
end

function renderDx()
	if panel then
		if account == 'true' then
			assetsTable = {
				['accountstrue'] = {
					{text=false, x=-20, y=-20, w=1406, h=808, file='assets/background.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=0, y=0, w=102, h=768, file='assets/bar.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=28, y=51, w=44.27, h=44.27, file=':rp_assets/avatars/'..playerDataTable['avatar']..'.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=28, y=139.27, w=44.27, h=41.8, file='assets/home.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=29, y=225.07, w=42.86, h=35.71, file='assets/infos.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=28, y=305, w=41.67, h=41.67, file='assets/credits.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=636, y=150, w=160, h=160, file='assets/stroker.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=641, y=155, w=151, h=151, file=':rp_assets/avatars/'..playerDataTable['avatar']..'.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=person_DataTable['charname'], x=516, y=307, w=400, h=59, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=3.5},
					{text=false, x=516, y=373, w=400, h=1, file='assets/line.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
					{text=passwordHash(guiGetText(editBox[1])), x=516, y=366, w=400, h=58, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=2.5},
					{text=false, x=515, y=450, w=401, h=80, file='assets/enter.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},

				},
				['hometrue'] = {
					{text=false, x=-20, y=-20, w=1406, h=808, file='assets/background.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=0, y=0, w=102, h=768, file='assets/bar.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=28, y=51, w=44.27, h=44.27, file=':rp_assets/avatars/'..playerDataTable['avatar']..'.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=28, y=139.27, w=44.27, h=41.8, file='assets/home.png', Clicked=true, ClickedType='color', color=tocolor(110, 181, 250, 255), alingX=false, alingY=false},
					{text=false, x=29, y=225.07, w=42.86, h=35.71, file='assets/infos.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=28, y=305, w=41.67, h=41.67, file='assets/credits.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=823, y=301, w=430, h=166, file='assets/hasAccount/person_background.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=322, y=205, w=160, h=160, file='assets/stroker.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=327, y=210, w=150, h=150, file=':rp_assets/avatars/'..playerDataTable['avatar']..'.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=201, y=478, w=401, h=80, file='assets/enter.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text='#000000Olá '..(person_DataTable['charname'])..',\nDeseja entrar nessa conta ?', x=144, y=364, w=516, h=116, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 50), alingX='center', alingY='center', scale=2.5},
					{text='Olá #AAEB82'..(person_DataTable['charname'])..'#FFFFFF,\nDeseja entrar nessa conta ?', x=144, y=362, w=516, h=116, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=2.5},
					{text=person_DataTable['charname'], x=967, y=336, w=286, h=48, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='left', alingY='center', scale=2},
					{text=person_DataTable['money']..',00', x=989, y=384, w=233, h=20, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 200), alingX='left', alingY='center', scale=1.5},
					{text=person_DataTable['bankmoney']..',00', x=989, y=404, w=233, h=20, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 200), alingX='left', alingY='center', scale=1.5},
					{text=false, x=849-3, y=334-3, w=100+6, h=100+6, file='assets/stroker.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
					{text=false, x=849, y=334, w=100, h=100, file=':rp_assets/avatars/'..playerDataTable['avatar']..'.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},

				},
			}
		else
			assetsTable = {
			['accountsfalse'] = {
				{text=false, x=-20, y=-20, w=1406, h=808, file='assets/background.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=0, y=0, w=102, h=768, file='assets/bar.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=51, w=44.27, h=44.27, file=':rp_assets/avatars/0.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=139.27, w=44.27, h=41.8, file='assets/home.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=29, y=225.07, w=42.86, h=35.71, file='assets/infos.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=305, w=41.67, h=41.67, file='assets/credits.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=636, y=44, w=163, h=163, file='assets/stroker.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=641, y=50, w=151, h=151, file=':rp_assets/avatars/'..playerDataTable['avatar']..'.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=560, y=101, w=29, h=47, file='assets/left.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false, modechange='avatar'},
				{text=false, x=872, y=101, w=29, h=47, file='assets/right.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false, modechange='avatar'},
				{text=false, x=515, y=522, w=401, h=80, file='assets/create.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=guiGetText(editBox[1]), x=516, y=326-105, w=400, h=58, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=false, x=516, y=384-105, w=400, h=1, file='assets/line.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=passwordHash(guiGetText(editBox[2])), x=516, y=385-105, w=400, h=58, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=false, x=516, y=443-105, w=400, h=1, file='assets/line.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=guiGetText(editBox[3]), x=516, y=444-105, w=400, h=58, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=false, x=516, y=502-105, w=400, h=1, file='assets/line.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=guiGetText(editBox[4]), x=516, y=503-105, w=400, h=58, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=false, x=516, y=561-105, w=400, h=1, file='assets/line.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=guiGetText(editBox[5]), x=516, y=562-105, w=400, h=58, file=false, Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX='center', alingY='center', scale=1.5},
				{text=false, x=600, y=575-105, w=17, h=35, file='assets/left.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false, modechange='Sexo'},
				{text=false, x=822, y=575-105, w=17, h=35, file='assets/right.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false, modechange='Sexo'},

			},
			['homefalse'] = {
				{text=false, x=-20, y=-20, w=1406, h=808, file='assets/background.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=0, y=0, w=102, h=768, file='assets/bar.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=51, w=44.27, h=44.27, file=':rp_assets/avatars/0.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=139.27, w=44.27, h=41.8, file='assets/home.png', Clicked=true, ClickedType='color', color=tocolor(110, 181, 250, 255), alingX=false, alingY=false},
				{text=false, x=29, y=225.07, w=42.86, h=35.71, file='assets/infos.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=305, w=41.67, h=41.67, file='assets/credits.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=497, y=188, w=480, h=317, file='assets/notHasAccount/text.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=536, y=425, w=401, h=80, file='assets/create.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
			},
			}
		end
			assetsTable['infos'] = {
				{text=false, x=-20, y=-20, w=1406, h=808, file='assets/background.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=0, y=0, w=102, h=768, file='assets/bar.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=51, w=44.27, h=44.27, file=':rp_assets/avatars/'..playerDataTable['avatar']..'.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=139.27, w=44.27, h=41.8, file='assets/home.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=29, y=225.07, w=42.86, h=35.71, file='assets/infos.png', Clicked=true, ClickedType='color', color=tocolor(110, 181, 250, 255), alingX=false, alingY=false},
				{text=false, x=28, y=305, w=41.67, h=41.67, file='assets/credits.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=230, y=92, w=983, h=574, file='assets/infos/text.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},

			}
			assetsTable['credits'] = {
				{text=false, x=-20, y=-20, w=1406, h=808, file='assets/background.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=0, y=0, w=102, h=768, file='assets/bar.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=51, w=44.27, h=44.27, file=':rp_assets/avatars/'..playerDataTable['avatar']..'.png', Clicked=true, ClickedType='zoom', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=139.27, w=44.27, h=41.8, file='assets/home.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=29, y=225.07, w=42.86, h=35.71, file='assets/infos.png', Clicked=true, ClickedType='color', color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},
				{text=false, x=28, y=305, w=41.67, h=41.67, file='assets/credits.png', Clicked=true, ClickedType='color', color=tocolor(110, 181, 250, 255), alingX=false, alingY=false},
				{text=false, x=230, y=92, w=983, h=574, file='assets/credits/text.png', Clicked=false, ClickedType=false, color=tocolor(255, 255, 255, 255), alingX=false, alingY=false},

			}
		for i,v in ipairs(assetsTable[section]) do
			if v['text'] == false then
				if isMouseInPosition(sx*v['x'], sy*v['y'], sx*v['w'], sy*v['h']) and v['Clicked'] then
					if v['ClickedType'] == 'color' then
						dxDrawImage(sx*v['x'], sy*v['y'], sx*v['w'], sy*v['h'], v['file'], 0, 0, 0, tocolor(110, 181, 250, 255))
					else
						dxDrawImage((sx*v['x']) - (sx*1), (sy*v['y']) - (sy*1), (sx*v['w']) + (sx*2), (sy*v['h']) + (sy*2), v['file'], 0, 0, 0, v['color'])
					end
				else
					dxDrawImage(sx*v['x'], sy*v['y'], sx*v['w'], sy*v['h'], v['file'], 0, 0, 0, v['color'])
				end
			else
				dxDrawText(v['text'], sx*v['x'], sy*v['y'], (sx*v['w']) + (sx*v['x']), (sy*v['h']) + (sy*v['y']), v['color'], sx*v['scale'], 'arial', v['alingX'], v['alingY'], false, false, false, true)
			end
		end
	end
end

function changeSelected(side, modechange)
	if side == 'right' then
		if modechange == 'avatar' then
			if tonumber(playerDataTable['avatar']) < 118 then
				playerDataTable['avatar'] = playerDataTable['avatar'] + 1
			end
		elseif modechange == 'Sexo' then
			guiSetText(editBox[5], 'Feminino')
			Gender = 'no'
			SkinID = 9
		end
	else
		if modechange == 'avatar' then
			if tonumber(playerDataTable['avatar']) > 0 then
				playerDataTable['avatar'] = playerDataTable['avatar'] - 1
			end	
		elseif modechange == 'Sexo'	then
			guiSetText(editBox[5], 'Masculino')
			Gender = 'ferfi'
			SkinID = 1
		end
	end
end

addEventHandler('onClientClick', root, function(b, s)
	if b == 'left' and s == 'down' then
		if panel then
			for i,v in ipairs(assetsTable[section]) do
				if isMouseInPosition(sx*v['x'], sy*v['y'], sx*v['w'], sy*v['h']) then
					if v['Clicked'] then
						if v['file'] == 'assets/home.png' then
							if section ~= 'home'..account then
								section = 'home'..account
							end
						elseif v['file'] == 'assets/infos.png' then
							if section ~= 'infos' then
								section = 'infos'
							end
						elseif v['file'] == 'assets/credits.png' then
							if section ~= 'credits' then
								section = 'credits'
							end
						elseif v['file'] == 'assets/create.png' and section == 'homefalse' then
							if section ~= 'accounts'..account then
								section = 'accounts'..account
								addEdit('accounts'..account)
							end
						elseif v['file'] == 'assets/enter.png' and section == 'hometrue' then
							if section ~= 'accounts'..account then
								section = 'accounts'..account
								addEdit('accounts'..account)
							end
						elseif v['file'] == ':rp_assets/avatars/'..playerDataTable['avatar']..'.png' then
							if section ~= 'accounts'..account then
								section = 'accounts'..account
								addEdit('accounts'..account)
							end
						elseif v['file'] == 'assets/left.png' and section == 'accountsfalse' then
							changeSelected('left', v['modechange'])
						elseif v['file'] == 'assets/right.png' and section == 'accountsfalse' then
							changeSelected('right', v['modechange'])
						elseif v['file'] == 'assets/create.png' and section == 'accountsfalse' then
							if tonumber(playerDataTable['avatar']) == 0 then exports.rp_infobox:addNotification('Escolha um avatar !','error') return end
							if #(guiGetText(editBox[1])) < 6 or guiGetText(editBox[1]) == "Usuário" then exports.rp_infobox:addNotification('Seu usuário deve ter no min 6 caracteres !','error') return end
							if #(guiGetText(editBox[2])) < 8 or guiGetText(editBox[2]) == "Senha" then exports.rp_infobox:addNotification('Sua senha deve ter no min 8 caracteres !','error')  return end
							if #(guiGetText(editBox[3])) < 5 or guiGetText(editBox[3]) == 'Nome e Sobrenome' then exports.rp_infobox:addNotification('Seu nome de ter no min 5 caracteres !','error') return end
							if (guiGetText(editBox[4])) == 'Idade' then exports.rp_infobox:addNotification('Digite sua idade !','error') return end
							if (tonumber(guiGetText(editBox[4])) < 18) then exports.rp_infobox:addNotification('Sua idade deve ser maior que 18 anos !', 'error') return end
							triggerServerEvent('createAccount', localPlayer, localPlayer, guiGetText(editBox[1]) , guiGetText(editBox[2]), playerDataTable['avatar'])
							triggerServerEvent('onCharCreateClick', localPlayer, localPlayer, guiGetText(editBox[3]) , guiGetText(editBox[4]), tostring(Sexo), SkinID)
						elseif v['file'] == 'assets/enter.png' and section == 'accountstrue' then
							if guiGetText(editBox[1]) == 'Senha' or #guiGetText(editBox[1]) < 1 then exports.rp_infobox:addNotification('Senha incorreta !','error')  return end
							if playerDataTable['password'] ~= md5(guiGetText(editBox[1])) then exports.rp_infobox:addNotification('Senha incorreta !','error')  return end
							triggerServerEvent('onLoginClick', localPlayer, localPlayer, playerDataTable['username'], guiGetText(editBox[1]))
						end
						if editBox and section == 'accountsfalse' then
							if v['text'] == guiGetText(editBox[1]) then
								if guiEditSetCaretIndex(editBox[1], string.len(guiGetText(editBox[1]))) then
								    guiBringToFront(editBox[1])
								    guiSetText( editBox[1], "" )
								end
							elseif v['text'] == passwordHash(guiGetText(editBox[2])) then
								if guiEditSetCaretIndex(editBox[2], string.len(guiGetText(editBox[2]))) then
								    guiBringToFront(editBox[2])
								    guiSetText( editBox[2], "" )
								end
							elseif v['text'] == (guiGetText(editBox[3])) then
								if guiEditSetCaretIndex(editBox[3], string.len(guiGetText(editBox[3]))) then
								    guiBringToFront(editBox[3])
								    guiSetText( editBox[3], "" )
								end
							elseif v['text'] == (guiGetText(editBox[4])) then
								if guiEditSetCaretIndex(editBox[4], string.len(guiGetText(editBox[4]))) then
								    guiBringToFront(editBox[4])
								    guiSetText( editBox[4], "" )
								end
							end
						elseif editBox and section == 'accountstrue' then
							if v['text'] == passwordHash(guiGetText(editBox[1])) then
								if guiEditSetCaretIndex(editBox[1], string.len(guiGetText(editBox[1]))) then
								    guiBringToFront(editBox[1])
								    guiSetText( editBox[1], "" )
								end
							end
						end
					end
				end
			end
		end
	end
end)

addEvent('spawnPlayer', true)
addEventHandler('spawnPlayer', root, function()
	setElementFrozen(localPlayer, true)
	local pos = getElementData(localPlayer, 'spawnPos')
	setElementPosition(localPlayer, pos[1], pos[2], pos[3])
	setElementInterior(localPlayer, pos[4])
	setElementDimension(localPlayer, pos[5])
	playSound("assets/bong.mp3")
	addEventHandler("onClientPreRender",getRootElement(),spawnChar1)
	spawntimer = setTimer(function()
		playSound("assets/bong.mp3")
		addEventHandler("onClientPreRender",getRootElement(),spawnChar2)
	end, 2000,1)
	spawntimer1 = setTimer(function()
		playSound("assets/bong.mp3")
		addEventHandler("onClientPreRender",getRootElement(),spawnChar3)
	end, 3000,1)
	spawntimer2 = setTimer(function()
		playSound("assets/bong.mp3")
		addEventHandler("onClientPreRender",getRootElement(),spawnChar4)
	end, 4000,1)
	spawntimer3 = setTimer(function()
		playSound("assets/bong.mp3") 
		spawnChar5()
	end, 5000,1)
end)

function spawnChar1()
local x,y,z = getElementPosition(localPlayer)
setCameraMatrix(x,y,z+45,x,y,z)
end

function spawnChar2()
local x,y,z = getElementPosition(localPlayer)
setCameraMatrix(x,y,z+25,x,y,z)
end

function spawnChar3()
local x,y,z = getElementPosition(localPlayer)
setCameraMatrix(x,y,z+15,x,y,z)
end

function spawnChar4()
local x,y,z = getElementPosition(localPlayer)
setCameraMatrix(x,y,z+5,x,y,z)
end

function spawnChar5()
setCameraTarget(localPlayer)
setElementFrozen(localPlayer, false)
removeEventHandler("onClientPreRender",getRootElement(),spawnChar1)
removeEventHandler("onClientPreRender",getRootElement(),spawnChar2)
removeEventHandler("onClientPreRender",getRootElement(),spawnChar3)
removeEventHandler("onClientPreRender",getRootElement(),spawnChar4)
--playSound("http://translate.google.com/translate_tts?tl=pt&q=olá "..getElementData(localPlayer,"char:name").." bem vindo Real Player &client=tw-ob", false)

end
-- function utils-----------------------------------------------------

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

-- Modified version for DX Text
function isCursorOverText(posX, posY, sizeX, sizeY)
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cX, cY = getCursorPosition()
	local screenWidth, screenHeight = guiGetScreenSize()
	local cX, cY = (cX*screenWidth), (cY*screenHeight)

	return ( (cX >= posX and cX <= posX+(sizeX - posX)) and (cY >= posY and cY <= posY+(sizeY - posY)) )
end