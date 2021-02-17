Config = {}

Config.RestrictedChannels = 10 -- channels that are encrypted (EMS, Fire and police can be included there) if we give eg 10, channels from 1 - 10 will be encrypted
Config.enableCmd = false --  /radio command should be active or not (if not you have to carry the item "radio") true / false

Config.messages = {
  
  ['not_on_radio'] = 'Não estás em nenhuma rádio',
  ['on_radio'] = 'Estás na Rádio: <b>',
  ['joined_to_radio'] = 'Acedeste a rádio: <b>',
  ['restricted_channel_error'] = 'Não te podes juntar a canais encriptados!',
  ['you_on_radio'] = 'Já estás na rádio: <b>',
  ['you_leave'] = 'Tu deixaste a rádio: <b>'

}
