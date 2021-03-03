local connection = exports.rp_mysql:getConnection()

addEvent("verificar_conta", true)
addEventHandler("verificar_conta", root, function(player)
	local loginAndSenha = dbPoll(dbQuery(connection, "SELECT * FROM accounts WHERE mtaserial", getPlayerSerial(player)), -1)
	if (#loginAndSenha > 0) then
		for i,v in ipairs(loginAndSenha) do
			local account = dbPoll(dbQuery(connection, "SELECT * FROM characters WHERE id", v['id']), -1)
			triggerClientEvent(player, 'uptdateClient', player, true, loginAndSenha, account, true)
		end
	else
		triggerClientEvent(player, 'uptdateClient', player, true, {}, {}, false)
	end
end)

addEvent("onLoginClick", true)
addEventHandler("onLoginClick", root, function(player, username, password2)
	local password = md5(password2)
	local loginQuery = dbPoll(dbQuery(connection, "SELECT * FROM accounts WHERE username = ? AND password = ? LIMIT 1", username, password), -1)
	if (tonumber(#loginQuery) or 0) > 0 then
		print(true)
		for _, row in ipairs(loginQuery) do
				if row["online"] == 1 then
					exports.rp_infobox:addNotification(player,"Sua conta ja está em uso!","error")
					return
				end
				local accId = tonumber(row["id"])
				setElementData(player, "acc:id", accId)
				setElementData(player, "acc:name", tostring(row["username"]))
				setElementData(player, "acc:admin", tonumber(row["admin"]) or 0)
				setElementData(player, "acc:aseged", tonumber(row["aseged"]) or 0)
				setElementData(player, "acc:lastlogin", row["lastlogin"])
				dbExec(connection, "UPDATE accounts SET online = '1' WHERE id = ?", accId)
				dbExec(connection, "UPDATE accounts SET mtaserial = ? WHERE id = ?", getPlayerSerial(player), row["id"])
		end
		exports.rp_infobox:addNotification(player,"Login bem sucedido!","success")
		checkCharacter(player)
		local account = getAccount ( username, password2 )
		if ( account ~= false ) then 
			logIn (player, account, password2 ) 
		else
			addAccount(tostring(username),tostring(password2))
			redirectPlayer(player,"Você teve um problema de login, entre novamente !",0)
		end
	end
end)

addEvent('createAccount', true)
addEventHandler('createAccount', root, function(p, user, password, avatar)
	local passwordmd5 = md5(password)
	local registerQuery = dbPoll(dbQuery(connection, "SELECT * FROM accounts WHERE username LIKE '".. tostring(user) .."' or mtaserial = '".. getPlayerSerial(p) .."'"), -1)
	local accountAdded = addAccount(tostring(user),tostring(password))
	if accountAdded then
		for _, row in ipairs(registerQuery) do
			if row["username"] == user then
				exports.rp_infobox:addNotification(p,"O nome de usuário está ocupado!","error")
				return
			end
			if row["mtaserial"] == getPlayerSerial(p) then
				exports.rp_infobox:addNotification(p,"Este serial já está conectado a uma conta!","error")
				return
			end
		end
		local registerInsert = dbQuery(connection, "INSERT INTO accounts SET username = ?, password = ?, mtaserial = ?, ip = ?, avatar = ?, regdate = NOW(), lastlogin = NOW()", user, passwordmd5, getPlayerSerial(p), getPlayerIP(p), avatar)
		local result, num, insertID = dbPoll(registerInsert, -1)
		if insertID then
			exports.rp_infobox:addNotification(p,"Registro bem sucedido! Agora você pode entrar!","success")
			setElementData(p, "acc:id", insertID)
			triggerClientEvent(p, 'uptdateClient', p, false, {}, {}, false)
		end
	else
		exports.rp_infobox:addNotification(p,"O nome de usuário está ocupado!","error")
	end
end)

function onCharCreateClick(player, charName, charBirth, charGender, charSkin)
	local charId = getElementData(player, "acc:id")
	local charQuery = dbPoll(dbQuery(connection, "SELECT * FROM characters where charname LIKE '".. charName .."' limit 1"), -1)
	for _, row in ipairs(charQuery) do
		if string.lower(charName) == string.lower(row["charname"]) then
			exports.rp_infobox:addNotification(player,"O nome de usuário está ocupado!","error")
			dbExec(connection, "DELETE FROM accounts WHERE id = ?", charId)
			triggerClientEvent(player, 'uptdateClient', player, true, {}, false)
			return
		end
	end
	local x, y, z = 1152.0964355469,-1756.3059082031,13.636505126953 --1149.8869628906, -1754.1486816406, 13.615719795227
	local pos = toJSON({x, y, z, 0, 0})
	local charInsert = dbExec(connection, "INSERT INTO characters SET id = ?, charname = ?, gender = ?, skin = ?, pos = ?, suly = 80, magassag = 180, eletkor = ?, leiras = ?, account = ?", charId, charName, charGender, charSkin, pos, charBirth, 'The Return Beta Version', getElementData(player, "acc:id"))
	if charInsert then
		triggerEvent('verificar_conta', player, player)
	end
end
addEvent("onCharCreateClick", true)
addEventHandler("onCharCreateClick", root, onCharCreateClick)

function checkCharacter(player)
	local accId = getElementData(player, "acc:id")
	local spawnQuery = dbPoll(dbQuery(connection, "SELECT * FROM characters WHERE id = ?", accId), -1)
	if (#spawnQuery > 0) then
		for _, cRow in ipairs(spawnQuery) do
			setElementData(player, "char:id", accId)
			--dbExec(connection, "UPDATE characters SET mtaserial = ? WHERE id = ?", getPlayerSerial(player), accId)
			setElementData(player, "playerid", accId)
			charname = tostring(cRow["charname"])
			playedTime = tonumber(cRow["playedTime"])
			money = tonumber(cRow["money"])
			bankmoney = tonumber(cRow["bankmoney"])
			skin = cRow["skin"]
			adminduty = cRow["adminduty"]
			anick = tostring(cRow["anick"])
			pp = cRow["premiumpont"]
			Leiras = cRow["leiras"]
			job = tostring(cRow["job"])
			pos = fromJSON(cRow["pos"])
			level = tonumber(cRow["Level"])
			exp = tonumber(cRow["LevelEXP"])
			setElementData(player, "spawnPos", pos)
			vehSlot = cRow["carSlot"]
			houseSlot = cRow["houseSlot"]
			hp = cRow["hp"]
			armor = cRow["armor"]
			hunger = cRow["hunger"]
			drink = cRow["drink"]
			adutyTime = cRow["adutyTime"]
			dutySkin = cRow["dutySkin"]


			adminjail = tonumber(cRow["adminjail"])
			adminjail_reason = cRow["adminjail_reason"]
			adminjail_idoTelik = tonumber(cRow["adminjail_idoTelik"])
			adminjail_alapIdo = tonumber(cRow["adminjail_alapIdo"])
			adminjail_admin = cRow["adminjail_admin"]
			adminjail_adminSerial = cRow["adminjail_adminSerial"]
						
			jailed = tonumber(cRow["jailed"]) or 0
			jailed_reason = cRow["jailed_reason"] or false
			jailed_idoTelik = tonumber(cRow["jailed_idoTelik"]) or 0
			jailed_alapIdo = tonumber(cRow["jailed_alapIdo"]) or 0
			jailed_player = cRow["jailed_player"] or false

			setElementData(source, "loggedin", true)
			setElementData(player, "jailed", jailed)
			setElementData(player, "jailed:reason", jailed_reason)
			setElementData(player, "jailed:ido", jailed_alapIdo)
			setElementData(player, "jailed:idoTelik", jailed_idoTelik)
			local idoLetelt1 = jailed_alapIdo-jailed_alapIdo
			setElementData(player, "jailed:idoLetelt", idoLetelt1)
			setElementData(player, "jailed:player", jailed_player)
				
			setElementData(player, "adminjail", adminjail)
			setElementData(player, "adminjail:reason", adminjail_reason)
			setElementData(player, "adminjail:ido", adminjail_idoTelik)
			setElementData(player, "idoTelik", adminjail_idoTelik)
			local idoLetelt = adminjail_alapIdo-adminjail_alapIdo
			setElementData(player, "idoLetelt", idoLetelt)
			setElementData(player, "adminjail:admin", adminjail_admin)
			setElementData(player, "adminjail:adminSerial", adminjail_adminSerial)
			setElementData(player, "adminjail:alapIdo", adminjail_alapIdo)
				
			checkAdminjail(player)
			checkPdJail(player)

			
			setElementData(player, "spawnedHp", hp)
			setElementData(player, "spawnedArmor", armor)
			setElementData(player, "spawnedHunger", hunger)
			setElementData(player, "spawnedDrink", drink)
			setElementData(player, "char:name", charname)
			setElementData(player, "char:playedTime", playedTime)
			setElementData(player, "char:money", money)
			setElementData(player, "char:bankmoney", bankmoney)
			setElementData(player, "char:skin", 0)
			setElementData(player, "char:adminduty", 0)
			setElementData(player, "char:anick", anick)
			setElementData(player, "char:pp", pp)
			setElementData(player, "job", job)
 			setElementData (player, "Sys:Level",level)
			setElementData (player, "LSys:EXP",exp)
			setElementData(player, "char:leiras", Leiras)
			setElementData(player, "aduty:time", adutyTime)
			setElementData(player, "char:dutySkin", dutySkin)
			setElementData(player, "char:vehSlot", vehSlot)
			setElementData(player, "char:houseSlot", houseSlot)
			setPlayerHudComponentVisible(player, "crosshair", true)
			triggerClientEvent(player, 'uptdateClient', player, false, {}, {}, false)
			triggerClientEvent(player, "spawnPlayer", player)
		end
	end
end
addEvent("checkCharacter", true)
addEventHandler("checkCharacter", root, checkCharacter)


function checkAdminjail(player)
	if getElementData(player, "adminjail") == 1 then
		local idoTelikTimer = setTimer(idoTelikLe, 60000, getElementData(player, "idoTelik"), player)
		local theTimer = setElementData(player, "adminjail:theTimerAccounts", idoTelikTimer)			
		outputChatBox("#dc143c[Cadeia Administrativa]:#ffffffVocê foi detido depois de entrar. para mais detalhes, use o comando #7cc576/tempo", player, 255, 255, 255, true)		
	end
end

function checkPdJail(player)
	if getElementData(player, "jailed") == 1 then
		local idoTelikTimer = setTimer(idoTelikLePd, 60000, getElementData(player, "jailed:idoTelik"), player)
		local theTimer = setElementData(player, "jailed:timerAccounts", idoTelikTimer)			
		outputChatBox("#0094ff[prisão]:#ffffff Você foi detido depois de entrar. para mais detalhes, use o comando #7cc576/tempo", player, 255, 255, 255, true)		
	end
end
