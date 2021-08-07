local plyState = LocalPlayer.state

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    if xPlayer.job.name == 'police' then
		plyState:set('onDuty', false, true)
		buildList()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if job.name == 'police' then
		plyState:set('onDuty', false, true)
		buildList()
	end
end)

RegisterNetEvent('sp-duty:sign', function()
	if plyState.onDuty == true then
		plyState:set('onDuty', false, true)
		exports["mnotify"]:Notify("info", "Mesaiden çıktın.", 2500)
		onDuty = false
	else
		plyState:set('onDuty', true, true)
		exports["mnotify"]:Notify("info", "Mesaiye başladın.", 2500)
		onDuty = true
	end
	TriggerServerEvent('sp-duty:toggleDuty')
end)

--Yetkili Tool
--[[RegisterCommand("dutyAction", function(src, args)
	TriggerServerEvent("sp-duty:action", args[1])
	
	TriggerEvent('chat:addSuggestion', '/dutyAction', 'Duty bilgileri sorgulama', {
		{ name="ID", help="Server ID veya Hex ID" }
	})
end)--]]