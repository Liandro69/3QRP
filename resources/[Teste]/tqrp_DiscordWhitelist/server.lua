----------------------------------------
--- Discord Whitelist, Made by FAXES ---
----------------------------------------

-- Documentation: https://docs.faxes.zone/docs/discord-whitelist-setup
--- Config ---
notWhitelistedMessage = "Não estás whitelisted!" -- Message displayed when they are not whitelist with the role

whitelistRoles = { -- Role IDs needed to pass the whitelist
    "679897305213698057", -- Civil
    "679880156709781505", -- Staff
    "678729991957118996", -- CEO
    "701516054442016768", -- Empreiteiro
}

--- Code ---

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    local passAuth = false
    deferrals.defer()

    deferrals.update("A verificar...")

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        usersRoles = exports.discord_perms:GetRoles(src)
        local function has_value(table, val)
            if table then
                for index, value in ipairs(table) do
                    if value == val then
                        return true
                    end
                end
            end
            return false
        end
        for index, valueReq in ipairs(whitelistRoles) do 
            if has_value(usersRoles, valueReq) then
                passAuth = true
            end
            if next(whitelistRoles,index) == nil then
                if passAuth == true then
                    deferrals.done()
                else
                    deferrals.done(notWhitelistedMessage)
                    CancelEvent()
                    return
                end
            end
        end
    else
        deferrals.done("Obrigatorio entrar no servidor com o discord aberto.")
    end
end)