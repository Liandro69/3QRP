ESX = nil
local savedNotes = {}

TriggerEvent('server:LoadsNote')
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('notepad', function(source)
  local _source  = source
  local xPlayer   = ESX.GetPlayerFromId(_source)
  TriggerClientEvent('lkrp_notepad:note', _source)
  TriggerClientEvent('lkrp_notepad:OpenNotepadGui', _source)
end)

TriggerEvent('es:addCommand', 'notas', function(source, args, user)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local item    = xPlayer.getInventoryItem('notepad').count
if item > 0 then
    TriggerClientEvent('lkrp_notepad:note', _source)
    TriggerClientEvent('lkrp_notepad:OpenNotepadGui', _source)
    TriggerEvent('server:LoadsNote')
else
     TriggerClientEvent('esx:showNotification', _source, 'Não tens um bloco de notas.')
end
    
end, {help = "Abre o bloco de notas se tiveres!"})


RegisterNetEvent("server:LoadsNote")
AddEventHandler("server:LoadsNote", function()
   TriggerClientEvent('lkrp_notepad:updateNotes', -1, savedNotes)
end)

RegisterNetEvent("server:newNote")
AddEventHandler("server:newNote", function(text, x, y, z)
      local import = {
        ["text"] = ""..text.."",
        ["x"] = x,
        ["y"] = y,
        ["z"] = z,
        ["created"] = false,
      }
      table.insert(savedNotes, import)
      TriggerEvent("server:LoadsNote")
end)

RegisterNetEvent("server:updateNote")
AddEventHandler("server:updateNote", function(noteID, text)
  if text ~= nil and noteID ~= nil and savedNotes[noteID] ~= nil then
    savedNotes[noteID]["text"]=text
    TriggerEvent("server:LoadsNote")
  end
end)

RegisterNetEvent("server:destroyNote")
AddEventHandler("server:destroyNote", function(noteID)
  table.remove(savedNotes, noteID)
  TriggerEvent("server:LoadsNote")
end)

