Config = {}

Config.MinPolice                 = 5       -- Min number of police needed to rob jewelry store.
Config.ResetTime                 = 120        -- Number of Minutes the store will reset after first case is broken

Config.Closed                    =  false      -- Sets store to closed if the police online is less then MinPolice
Config.AllowPoliceStoreClose     =  true     -- Allows any job set in Config.PoliceJobs to Close the store after a robbery until next store reset.

Config.PoliceNotifyBroken        =  100       -- The chance breaking a case will notify the police.  Setting to 100 will notify first broken case..
Config.PoliceNotifyNonBroken     =  20       -- The chance attempting to break a case will notify the police.  Setting to 100 will notify every attempt.

Config.PlayFailSound             =  true    -- Uses sound for failed attempt to break.

-- AllowedWewapons lists all weapons that are able to be used to break cases with the chance percent it has of breaking glass.
Config.AllowedWeapons = {
   { name = 'WEAPON_SPECIALCARBINE', chance = 100 },
   { name = 'WEAPON_FIREEXTINGUISHER', chance = 10 },
   { name = 'WEAPON_GOLFCLUB', chance = 15 },
   { name = 'WEAPON_HAMMER', chance = 30 },
   { name = 'WEAPON_PISTOL', chance = 35 },
   { name = 'WEAPON_COMPACTRIFLE', chance = 50 },
   { name = 'WEAPON_SMG', chance = 40 },
   { name = 'WEAPON_BAT', chance = 10 },
   { name = 'WEAPON_CROWBAR', chance = 20 },
   { name = 'WEAPON_WRENCH', chance = 30 },
}

-- List of all jobs that are law enforcement in your server.
Config.PoliceJobs =  {
   'police',
   'sheriff',
}

--  These jobs will not be able to rob the jewelry store at all.
Config.UnAuthJobs = {
   'sheriff',
   'ambulance',
}

--  These are the items you can recieve from breaking a case - need to be listed from lowest chance to highest chance.
--  If you have the highest chance set to less then 100 - will have a chance to not recieve any items from box.
--  You will need to change the names of these items to items in your database or enter these items into your database.
Config.ItemDrops  = {
   { name = 'net_cracker', max = 1,  chance = 1 },
   { name = 'dia_box', max =  math.random( 1,3 ), chance = 10 },
   { name = 'diamond', max =  math.random( 3,6 ),  chance = 15},
   { name = 'rolex', max =  math.random( 2,5 ), chance = 40 },
   { name = 'anel', max = math.random( 4,10 ), chance = 50 },
   { name = '2ct_gold_chain', max =  math.random( 3,9 ),  chance = 110},
}

-- Do Not Edit -- This list is just the general information for each of the 20 cases.
Config.CaseLocations = {
   [1] = {
      Pos = { x = -626.3253, y = -239.0511, z = 37.64523 },
      Prop = 'des_jewel_cab2_end',
      Prop1 = 'des_jewel_cab2_start',
      Broken = false,
   },
   [2] = {
      Pos = { x = -625.2751, y = -238.2881, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
   },
   [3] = {
      Pos = { x = -627.2115, y = -234.8942, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
   },
   [4] = {
      Pos = { x = -626.1613, y = -234.1315, z = 37.64523 },
      Prop = 'des_jewel_cab4_end',
      Prop1 = 'des_jewel_cab4_start',
      Broken = false,
   },
   [5] = {
      Pos = { x = -626.5439 , y = -233.6047 , z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
   },
   [6] = {
      Pos = { x = -627.5945 , y = -234.3678, z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
   },
   [7] = {
      Pos = { x = -622.6159, y = -232.5636, z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
   },
   [8] = {
      Pos = { x = -620.5214, y = -232.8823, z = 37.64523 },
      Prop = 'des_jewel_cab4_end',
      Prop1 = 'des_jewel_cab4_start',
      Broken = false,
   },
   [9] = {
      Pos = { x = -620.1764, y =-230.7865 , z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
   },
   [10] = {
      Pos = { x = -621.5175, y = -228.9474, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
   },
   [11] = {
      Pos = { x = -623.6147, y = -228.6247, z = 37.64523 },
      Prop = 'des_jewel_cab2_end',
      Prop1 = 'des_jewel_cab2_start',
      Broken = false,
   },
   [12] = {
      Pos = { x = -623.9558, y = -230.7263, z = 37.64523 },
      Prop = 'des_jewel_cab4_end',
      Prop1 = 'des_jewel_cab4_start',
      Broken = false,
   },
   [13] = {
      Pos = { x = -619.8483, y = -234.9137, z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
   },
   [14] = {
      Pos = { x = -618.7984, y = -234.1509, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
   },
   [15] = {
      Pos = { x = -624.2796, y = -226.6066, z = 37.64523 },
      Prop = 'des_jewel_cab4_end',
      Prop1 = 'des_jewel_cab4_start',
      Broken = false,
   },
   [16] = {
      Pos = { x = -625.3300, y = -227.3697, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
   },

   [17] = {
      Pos = { x = -619.2031, y = -227.2482, z = 37.64523 },
      Prop = 'des_jewel_cab2_end',
      Prop1 = 'des_jewel_cab2_start',
      Broken = false,
   },
   [18] = {
      Pos = { x = -619.9662, y = -226.198, z = 37.64523 },
      Prop = 'des_jewel_cab_end',
      Prop1 = 'des_jewel_cab_start',
      Broken = false,
   },
   [19] = {
      Pos = { x = -617.0856, y = -230.1627, z = 37.64523 },
      Prop = 'des_jewel_cab2_end',
      Prop1 = 'des_jewel_cab2_start',
      Broken = false,
   },
   [20] = {
      Pos = { x = -617.8492, y = -229.1128, z = 37.64523 },
      Prop = 'des_jewel_cab3_end',
      Prop1 = 'des_jewel_cab3_start',
      Broken = false,
   },
 }
