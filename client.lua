Citizen.CreateThread(function()

    while true do 
        local directions = {
            [0] = 'PÓŁNOC',
            [1] = 'PÓŁNOCNY ZACHÓD',
            [2] = 'ZACHÓD',
            [3] = 'POŁUDNIOWY ZACHÓD',
            [4] = 'POŁUDNIE',
            [5] = 'POŁUDNIOWY WSCHÓD',
            [6] = 'WSCHÓD',
            [7] = 'PÓŁNOCNY WSCHÓD',
            [8] = 'PÓŁNOC'
        }

        -- local directions = {
        --     [0] = 'NORTH',
        --     [1] = 'NORTH-WEST',
        --     [2] = 'WEST',
        --     [3] = 'SOUTH-WEST',
        --     [4] = 'SOUTH',
        --     [5] = 'SOUTH-EAST',
        --     [6] = 'EAST',
        --     [7] = 'NORTH-EAST',
        --     [8] = 'NORTH'
        -- }

        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.getPercent()
        end)

        local playerpedid = PlayerPedId()
        
        if NetworkGetTalkerProximity() == 1.5 then
            voicik = 10
        elseif NetworkGetTalkerProximity() == 3.0 then
            voicik = 50
        elseif NetworkGetTalkerProximity() == 6.0 then
            voicik = 100
        end

        local heading = directions[math.floor((GetEntityHeading(playerpedid) + 22.5) / 45.0)]
        
        local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()) 
        
        local healthPercent = (GetEntityHealth(playerpedid) / 200) * 100
        local staminaPercent = (stamina / 100) * 100

        SendNUIMessage({
            action = "update",
            kierunek = heading,
            jedzenie = hunger,
            woda = thirst,
            zycie = healthPercent,
            zmeczenie = staminaPercent,
            voice = voicik,
            kamza = GetPedArmour(playerpedid),
        })
        Citizen.Wait(1000)
    end
end)

