Config.Healing = 1.2 -- // If this is 0, then its disabled.. Default: 3.. That means, if a person lies in a bed, then he will get 1 health every 3 seconds.

Config.objects = {
	ButtonToSitOnChair = 58, -- // Default: G -- // https://docs.fivem.net/game-references/controls/
	ButtonToLayOnBed = 38, -- // Default: E -- // https://docs.fivem.net/game-references/controls/
	ButtonToStandUp = 23, -- // Default: F -- // https://docs.fivem.net/game-references/controls/
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	BedBackAnimation = {dict='anim@gangops@morgue@table@', anim='ko_front'},
	BedStomachAnimation = {anim='WORLD_HUMAN_SUNBATHE'},
	BedSitAnimation = {anim='WORLD_HUMAN_PICNIC'},
	locations = {
		{object="v_med_bed2", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true, hash = nil},
		{object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false, hash = nil},
		{object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false, hash = nil},
		{object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false, hash = nil},
		{object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false, hash = nil},
		{object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false, hash = nil},
		{object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false, hash = nil},
		{object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false, hash = nil},
		{object="prop_table_03_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false, hash = nil},
		{object="v_med_emptybed", verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=true, hash = nil},
		{object="prop_off_chair_01", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.5, direction=168.0, bed=false, hash = nil},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.10, verticalOffsetZ=0.1, direction=180.0, bed=false, hash = -853526657},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.10, verticalOffsetZ=0.1, direction=180.0, bed=false, hash = -1531508740},
		{object="v_med_bed1", verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-1.4, direction=90.0, bed=true, hash = nil}
	}
}

-- // YOU WILL FIND ALL BUTTONS HERE FOR CODE BELOW;P
-- [[ https://docs.fivem.net/game-references/controls/ ]]

Config.Text = {
	SitOnChair = '~INPUT_THROW_GRENADE~ para te sentares',
	SitOnBed = '~INPUT_PICKUP~ para te sentares na cama',
	LieOnBed = '~INPUT_PICKUP~ para te deitares na cama',
	SwitchBetween = '~INPUT_CELLPHONE_LEFT~ ~INPUT_CELLPHONE_RIGHT~ para virares-te',
	Standup = '~INPUT_ARREST~ para te levantares',
}