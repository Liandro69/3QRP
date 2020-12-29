Config                      = {}
Config.Locale               = 'br'

Config.Accounts             = { 'bank', 'black_money' }
Config.AccountLabels        = { bank = _U('bank'), black_money = _U('black_money') }

Config.EnableSocietyPayouts = true -- pay from the society account that the player is employed at? Requirement: tqrp_society
Config.DisableWantedLevel   = true
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)
Config.EnablePvP            = true -- enable pvp?
Config.MaxWeight            = 80   -- THIS IS 50KG

Config.PaycheckInterval     = 45 * 60000 -- how often to recieve pay checks in milliseconds
Config.CoordsSyncInterval   = 1000 -- how often to sync coords with server in milliseconds

Config.EnableDebug          = false

Config.PropList = {
    money = {                       ["model"] = 'prop_cash_pile_02'}, -- Done
    bagofdope = {                   ["model"] = 'prop_drug_package_02'}, -- Done
    trimmedweed = {                 ["model"] = 'bkr_prop_weed_bud_pruned_01a'}, -- Done
    meth = {                        ["model"] = 'bkr_prop_meth_smallbag_01a'}, -- Done
    HeavyArmor = {                  ["model"] = 'prop_bodyarmour_03'}, -- Done
    MedArmor = {                    ["model"] = 'prop_bodyarmour_03'}, -- Done
    SmallArmor = {                  ["model"] = 'prop_bodyarmour_03'}, -- Done
    bread = {                       ["model"] = 'v_res_fa_bread03'}, -- Done
    phone = {                       ["model"] = 'prop_npc_phone_02'}, -- Done
    weed_brick = {                  ["model"] = 'hei_prop_heist_weed_block_01b'}, -- Done
    gold_piece = {                  ["model"] = 'hei_prop_heist_gold_bar'}, -- Done
    lingot_gold = {                 ["model"] = 'hei_prop_heist_gold_bar'}, -- Done
    gold_bar =  {                   ["model"] = 'hei_prop_heist_gold_bar'}, -- Done
    rolex = {                       ["model"] = 'ex_office_swag_jewelwatch2'}, -- Done
    anel = {                        ["model"] = 'ex_office_swag_jewelwatch2'}, -- Done
    weed_100 = {                    ["model"] = 'hei_prop_heist_weed_block_01'}, -- Done
    stone = {                       ["model"] = 'proc_sml_stones01'}, -- Done
    washed_stone = {                ["model"] = 'proc_sml_stones01'}, -- Done
    recipe_WEAPON_CROWBAR = {       ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_WEAPON_PISTOL = {        ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_WEAPON_SWITCHBLADE = {   ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_WEAPON_WRENCH = {        ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_advancedlockpick = {     ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_arma_armacaopistola = {  ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_arma_cano = {            ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_arma_cao = {             ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_arma_gatilho = {         ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_lockpick = {             ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_nail = {                 ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_plantpot = {             ["model"] = 'p_blueprints_01_s'}, -- Done
    recipe_molafaca = {             ["model"] = 'p_blueprints_01_s'}, -- Done
    medikit = {                     ["model"] = 'xm_prop_x17_bag_med_01a'}, -- Done
    wood = {                        ["model"] = 'ng_proc_wood_01a'}, -- Done
    pine_wood = {                   ["model"] = 'ng_proc_wood_01a'}, -- Done
    iron = {                        ["model"] = 'ex_office_swag_silver'}, -- Done
    lingot_iron = {                 ["model"] = 'ex_office_swag_silver'}, -- Done
    radio = {                       ["model"] = 'prop_cs_walkie_talkie'}, -- Done
    disc_ammo_pistol = {            ["model"] = 'ex_office_swag_pills2'}, -- Done
    disc_ammo_pistol_large = {      ["model"] = 'ex_office_swag_pills2'} -- Done
}