TasteZumTeleportieren = 38 

-- Hier ist der Link um eine andere Taste einzustellen. Aktuell ist es 38 (E).
-- https://docs.fivem.net/docs/game-references/controls/#controls

LastDeadTime = 0
LastDeadLocation = 0

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end

Citizen.CreateThread(function()
	AlreadyDead = false
    while true do
        Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
		if IsEntityDead(playerPed) and not AlreadyDead then
			ShowNotification("~b~Drücke [E] um dich zu deiner alten Position zu teleportieren!")
            LastDeadTime = ((GetGameTimer())/1000)
            LastDeadLocation = GetEntityCoords(PlayerPedId())
            AlreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			AlreadyDead = false
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustReleased(1,  38 --[[ E key ]]) then
            if ((((GetGameTimer())/1000) - LastDeadTime) < 12.5) then
                StartPlayerTeleport(PlayerId(), LastDeadLocation.x, LastDeadLocation.y, LastDeadLocation.z, 0.0, true, true, true)
            end
        end
    end
end)