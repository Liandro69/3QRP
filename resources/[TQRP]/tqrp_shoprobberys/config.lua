Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'pt' -- 'en', 'sv' or 'custom'

Config.Shops = {
    {copJob = 'police', time = 420000, coords = vector3(-705.73, -914.91, 19.22), heading = 91.0, money = {6550, 12550}, cops = 3, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(372.29217529297, 326.39370727539, 103.56636047363), heading = 246.00857543945, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(2557.1748046875, 380.64489746094, 108.62294006348), heading = 340.8776550293, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(-3038.2673339844, 584.47491455078, 7.908935546875), heading = 23.610481262207, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(-3242.2670898438, 999.76306152344, 12.830704689026), heading = 345.36389160156, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(-2966.3012695313, 391.58193969727, 15.043300628662), heading = 86.15234375, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(-1487.2850341797, -376.92288208008, 40.163436889648), heading = 153.55458068848, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(-1221.3229980469, -908.12780761719, 12.326356887817), heading = 37.299858093262, money = {6550, 8550}, cops = 3, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(1134.0545654297, -983.3251953125, 46.415802001953), heading = 282.5920715332, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(-46.958980560303, -1758.9643554688, 29.420999526978), heading = 48.277374267578, money = {6550, 8550}, cops = 2, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(1165.1630859375, -323.87414550781, 69.205047607422), heading = 101.4720993042, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(-1819.5125732422, 793.64141845703, 138.08486938477), heading = 132.9716796875, money = {6550, 8550}, cops = 4, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false},
    {copJob = 'police', time = 420000, coords = vector3(268.920000000000, -978.0800000000, 29.3700000000000), heading = 167.47, money = {6650, 8550}, cops = 3, blip = false, name = 'Merceria Ti Jaquim', cooldown = {hour = 1, minute = 30, second = 0}, robbed = false, busy = false}

}

Translation = {
    ['pt'] = {
        ['shopkeeper'] = 'Ti Jaquim',
        ['robbed'] = "Acabei de ser assaltado ~r~Não tenho mais dinhiero awwwwwww!",
        ['cashrecieved'] = 'Dinheiro na caixa registadora:',
        ['currency'] = '$',
        ['scared'] = 'A borrar-se todo:',
        ['no_cops'] = 'És tão cagão vais...rouba uma loja mais no centro seu nabo!',
        ['cop_msg'] = 'Este escumalha está a roubar o Ti Jaquim!',
        ['set_waypoint'] = 'Marcar no GPS',
        ['hide_box'] = 'Sem Prioridade',
        ['robbery'] = 'Está a ser assaltado',
        ['walked_too_far'] = 'Foste para demasiado longe!'
    },
    ['sv'] = {
        ['shopkeeper'] = 'butiksbiträde',
        ['robbed'] = 'Jag blev precis rånad och har inga pengar kvar!',
        ['cashrecieved'] = 'Du fick:',
        ['currency'] = 'SEK',
        ['scared'] = 'Rädd:',
        ['no_cops'] = 'Det är inte tillräckligt med poliser online!',
        ['cop_msg'] = 'Vi har skickat en bild på rånaren från övervakningskamerorna!',
        ['set_waypoint'] = 'Sätt GPS punkt på butiken',
        ['hide_box'] = 'Stäng denna rutan',
        ['robbery'] = 'Pågående butiksrån',
        ['walked_too_far'] = 'Du gick för långt bort!'
    },
    ['custom'] = { -- edit this to your language
        ['shopkeeper'] = '',
        ['robbed'] = '',
        ['cashrecieved'] = '',
        ['currency'] = '',
        ['scared'] = '',
        ['no_cops'] = '',
        ['cop_msg'] = '',
        ['set_waypoint'] = '',
        ['hide_box'] = '',
        ['robbery'] = '',
        ['walked_too_far'] = ''
    }
}