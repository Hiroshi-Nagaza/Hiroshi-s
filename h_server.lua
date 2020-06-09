function switchEngine ( playerSource )
    local theVehicle = getPedOccupiedVehicle ( playerSource )
    if theVehicle and getVehicleController ( theVehicle ) == playerSource then
        local state = getVehicleEngineState ( theVehicle )
        setVehicleEngineState ( theVehicle, not state )
		
    end
end
addCommandHandler ( "motor", switchEngine )


function exit(theVehicle,seat,jacked)
	setVehicleOverrideLights ( theVehicle, 1 ) -- farol do carro desliga quando sai
	--setVehicleEngineState ( theVehicle, false ) -- motor desliga quando sai
	--setElementFrozen(theVehicle, true) -- carro fica fixo no chão quando sai
       
     
end
addEventHandler("onPlayerVehicleExit",getRootElement(),exit)



function enter(theVehicle,seat,jacked)
	setVehicleOverrideLights ( theVehicle, 2 ) -- farol do carro liga quando entra
	--setElementFrozen(theVehicle, false) -- carro fica des-fixo no chão quando entra
end
addEventHandler("onPlayerVehicleEnter",getRootElement(),enter)