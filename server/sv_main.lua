ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local dutyTablo = {}

RegisterNetEvent("sp-duty:toggleDuty")
AddEventHandler("sp-duty:toggleDuty", function()
    local src = source
	local plyState = Player(src).state
    local xPlayer = ESX.GetPlayerFromId(src)
    if plyState.onDuty == false then
        local UTCTime = os.date("%d/%m/%Y - %H:%M:%S")
        local totalTime = (os.time() - dutyTablo[src]) / 60
        MySQL.Async.execute("UPDATE users set `job_last` = @jobLastTime, `total_duty` = total_duty + @totalDuty WHERE identifier = @sourceIdentifier", {['@sourceIdentifier'] = xPlayer.identifier, ['@jobLastTime'] = UTCTime, ['@totalDuty'] = totalTime}, function(affectedRows)
            if affectedRows > 0 then
                -- plyState:set('onDuty', false, true)
            end
        end)
    else
        dutyTablo[src] = os.time()
    end
end)

AddEventHandler("playerDropped", function()
    local src = source
	local plyState = Player(src).state
    if plyState.onDuty == true then
        local xPlayer = ESX.GetPlayerFromId(src)
        local UTCTime = os.date("%d/%m/%Y/%H:%M:%S")
        local totalTime = (os.time() - dutyTablo[src]) / 60

        MySQL.Async.execute("UPDATE users set `job_last` = @jobLastTime, `total_duty` = total_duty + @totalDuty WHERE identifier = @sourceIdentifier", {['@sourceIdentifier'] = xPlayer.identifier, ['@jobLastTime'] = UTCTime, ['@totalDuty'] = totalTime}, function(affectedRows)
            if affectedRows > 0 then
                -- plyState:set('onDuty', false, true)
            end
        end)
    end
end)

-- Yetkili Tool

RegisterNetEvent("sp-duty:action")
AddEventHandler("sp-duty:action", function(pPlayerId)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local targetPlayer
    if type(pPlayerId) ~= "string" then
        targetPlayer = ESX.GetPlayerFromId(pPlayerId)
    end

    if (USER_GROUPS[xPlayer.getGroup()].canSeeDetails) then
        if pPlayerId:startswith("steam:") then
            MySQL.Async.fetchAll("SELECT `total_duty`, `job_last` FROM users WHERE identifier = @targetIdentifier", {['targetIdentifier'] = pPlayerId}, function(result)
                if result[1] ~= nil or result[1] ~= {} then
                    --  Adminler komut ile steam hex yazdığı kişinin duty bilgilerine erişebiliyor bütün yaptığım scriptlere bu tarz admin tool'ları eklemeye özen göstermeye çalışıyorum ancak mNotify mı başka bir şey mi kullanılması gerekir bilmediğim için burayı sana saldım.
                else
                    -- Data bulunamadı notification
                end
            end)
        else
            MySQL.Async.fetchAll("SELECT `total_duty`, `job_last` FROM users WHERE identifier = @targetIdentifier", {['targetIdentifier'] = targetPlayer.identifier}, function(result)
                if result[1] ~= nil or result[1] ~= {} then
                    --  Adminler komut ile id yazdığı kişinin duty bilgilerine erişebiliyor bütün yaptığım scriptlere bu tarz admin tool'ları eklemeye özen göstermeye çalışıyorum ancak mNotify mı başka bir şey mi kullanılması gerekir bilmediğim için burayı sana saldım.
                else
                    -- Data bulunamadı notification
                end
            end)
        end
    else
        -- Yetki yetmiyor notification
    end
end)

function string.startswith(self, str) 
    return self:find('^' .. str) ~= nil
end
