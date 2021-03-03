addEvent("OnPlayerLoginClick", true)
addEventHandler("OnPlayerLoginClick", root, function(player, login, senha)
	if getElementType(player) == "player" then
		local account = getAccount ( login, senha )
		if ( account ~= false ) then 
			logIn (player, account, senha ) 
			exports["h_infobox"]:addBox(player, "success", "Login feito com sucesso!")
			triggerClientEvent(player,"saveLoginToXML",player, tostring(login))
			triggerClientEvent( player, "ClosePanel", player)
		else
			exports["h_infobox"]:addBox(player, "Error", "Error login ou senha incorreta")
		end
	end
end)

addEvent("OnPlayerRegisterClick", true)
addEventHandler("OnPlayerRegisterClick", root, function(player, login, senha)
	if getElementType(player) == "player" then
		local account = getAccount ( login, senha )
		if ( account == true ) then 
			exports["h_infobox"]:addBox(player, "error", "Ja existe um conta com este usuário")
		else
			addAccount(tostring(login),tostring(senha))
			exports["h_infobox"]:addBox(player, "success", "Conta criada com sucesso")
			local account = getAccount ( login, senha )
			logIn (player, account, senha ) 
			exports["h_infobox"]:addBox(player, "success", "Login feito com sucesso!")
			triggerClientEvent(player,"saveLoginToXML",player, tostring(login))
			triggerClientEvent( player, "ClosePanel", player)
		end
	end
end)