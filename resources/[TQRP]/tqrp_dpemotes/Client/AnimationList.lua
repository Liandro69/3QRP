DP = {}

DP.Expressions = {
   ["Irritado"] = {"Expression", "mood_angry_1"},
   ["Bêbedo"] = {"Expression", "mood_drunk_1"},
   ["Burro"] = {"Expression", "pose_injured_1"},
   ["Eletrocutado"] = {"Expression", "electrocuted_1"},
   ["Mal-disposto"] = {"Expression", "effort_1"},
   ["Mal-disposto 2"] = {"Expression", "mood_drivefast_1"},
   ["Mal-disposto 3"] = {"Expression", "pose_angry_1"},
   ["Feliz"] = {"Expression", "mood_happy_1"},
   ["Magoado"] = {"Expression", "mood_injured_1"},
   ["Feliz"] = {"Expression", "mood_dancing_low_1"},
   ["Fumar"] = {"Expression", "smoking_hold_1"},
   ["Sem  piscar"] = {"Expression", "pose_normal_1"},
   ["Um olho"] = {"Expression", "pose_aiming_1"},
   ["Chocado 1"] = {"Expression", "shocked_1"},
   ["Chocado 2"] = {"Expression", "shocked_2"},
   ["Dormir 1"] = {"Expression", "mood_sleeping_1"},
   ["Dormir 2"] = {"Expression", "dead_1"},
   ["Dormir 3"] = {"Expression", "dead_2"},
   ["Presunçoso"] = {"Expression", "mood_smug_1"},
   ["Especulativo"] = {"Expression", "mood_aiming_1"},
   ["Stressado"] = {"Expression", "mood_stressed_1"},
   ["Aborrecido"] = {"Expression", "mood_sulk_1"},
   ["Estranho 1"] = {"Expression", "effort_2"},
   ["Estranho 2"] = {"Expression", "effort_3"},
}

DP.Walks = {
  ["Alien"] = {"move_m@alien"},
  ["Blindado"] = {"anim_group_move_ballistic"},
  ["Arrogantr"] = {"move_f@arrogant@a"},
  ["Corajoso"] = {"move_m@brave"},
  ["Casual 1"] = {"move_m@casual@a"},
  ["Casual 2"] = {"move_m@casual@b"},
  ["Casual 3"] = {"move_m@casual@c"},
  ["Casual 4"] = {"move_m@casual@d"},
  ["Casual5"] = {"move_m@casual@e"},
  ["Casual 6"] = {"move_m@casual@f"},
  ["Chichi"] = {"move_f@chichi"},
  ["Confidente"] = {"move_m@confident"},
  ["Polícia 1"] = {"move_m@business@a"},
  ["Polícia 2"] = {"move_m@business@b"},
  ["Polícia 3"] = {"move_m@business@c"},
  ["Normal mulher"] = {"move_f@multiplayer"},
  ["Normal homem"] = {"move_m@multiplayer"},
  ["Bêbedo"] = {"move_m@drunk@a"},
  ["Pouco bêbedo"] = {"move_m@drunk@slightlydrunk"},
  ["Bêbedo 2"] = {"move_m@buzzed"},
  ["Bêbedo 3"] = {"move_m@drunk@verydrunk"},
  ["Mulher"] = {"move_f@femme@"},
  ["Fogo 1"] = {"move_characters@franklin@fire"},
  ["Fogo 2"] = {"move_characters@michael@fire"},
  ["Fogo 3"] = {"move_m@fire"},
  ["Fugir"] = {"move_f@flee@a"},
  ["Franklin"] = {"move_p_m_one"},
  ["Gangster 1"] = {"move_m@gangster@generic"},
  ["Gangster 2"] = {"move_m@gangster@ng"},
  ["Gangster 3"] = {"move_m@gangster@var_e"},
  ["Gangster 4"] = {"move_m@gangster@var_f"},
  ["Gangster 5"] = {"move_m@gangster@var_i"},
  ["Grooving"] = {"anim@move_m@grooving@"},
  ["Guarda"] = {"move_m@prison_gaurd"},
  ["Algemas"] = {"move_m@prisoner_cuffed"},
  ["Saltos 1"] = {"move_f@heels@c"},
  ["Saltos 2"] = {"move_f@heels@d"},
  ["Escalar"] = {"move_m@hiking"},
  ["Hipster"] = {"move_m@hipster@a"},
  ["Hobo"] = {"move_m@hobo@a"},
  ["Pressa"] = {"move_f@hurry@a"},
  ["Zelador 1"] = {"move_p_m_zero_janitor"},
  ["Zelador 2"] = {"move_p_m_zero_slow"},
  ["Correr"] = {"move_m@jog@"},
  ["Lemar"] = {"anim_group_move_lemar_alley"},
  ["Lester 1"] = {"move_heist_lester"},
  ["Lester 2"] = {"move_lester_caneup"},
  ["Canibal"] = {"move_f@maneater"},
  ["Michael"] = {"move_ped_bucket"},
  ["Dinheiro"] = {"move_m@money"},
  ["Musculado"] = {"move_m@muscle@a"},
  ["Posh 1"] = {"move_m@posh@"},
  ["Posh 2"] = {"move_f@posh@"},
  ["Apressado"] = {"move_m@quick"},
  ["Corredor"] = {"female_fast_runner"},
  ["Triste"] = {"move_m@sad@a"},
  ["Atrevido"] = {"move_m@sassy"},
  ["Atrevida"] = {"move_f@sassy"},
  ["Assustado"] = {"move_f@scared"},
  ["Sexy"] = {"move_f@sexy@a"},
  ["Suspeito"] = {"move_m@shadyped@a"},
  ["Lento"] = {"move_characters@jimmy@slow@"},
  ["Swagger"] = {"move_m@swagger"},
  ["Durão 1"] = {"move_m@tough_guy@"},
  ["Durão 2"] = {"move_f@tough_guy@"},
  ["Lixo 1"] = {"clipset@move@trash_fast_turn"},
  ["Lixo 2"] = {"missfbi4prepp1_garbageman"},
  ["Trevor"] = {"move_p_m_two"},
  ["Largo"] = {"move_m@bag"},
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   ["aperto"] = {"mp_ped_interaction", "handshake_guy_a", "Aperto de mão 1", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["aperto2"] = {"mp_ped_interaction", "handshake_guy_b", "Aperto de mão 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["abraco"] = {"mp_ped_interaction", "kisses_guy_a", "Abraço 1", "hug2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["abraco2"] = {"mp_ped_interaction", "kisses_guy_b", "Abraço 2", "hug", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["dar"] = {"mp_common", "givetake1_a", "Dar 1", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["dar2"] = {"mp_common", "givetake1_b", "Dar 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Baseball", "baseballthrow"},
   ["baseball2"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Lançamento Baseball", "baseball"},
   ["mirar"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Confronto", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mirar2"] = {"missminuteman_1ig_2", "handsup_base", "Confroto (assustado)", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["soco"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Soco", "punched"},
   ["levarsoco"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Levar com soco", "punch"},
   ["cabecada"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Cabeçada", "headbutted"},
   ["levarcabecada"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Levar com cabeçada", "headbutt"},
   ["estalo2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Estalo 2", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["estalo"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Estalo", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["levarestalo"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Levar com estalo 1", "slap"},
   ["levarestalo2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Levar com estalo 2", "slap2"},
}

DP.Dances = {
   ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dança F", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dança F2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dança F3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dança F4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dança F5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dança F6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dança Slow 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dança Slow 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dança Slow 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dança", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dança 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dança 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dança 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dança de cima 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dança de cima 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dança tímida 1", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dança tímida 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dança tímida 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Dança estranha 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dança 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dança 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Dança 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dança estranha", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dança estranha 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dança estranha 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dança estranha 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dança estranha 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dança estranha 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dança 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dança estranha 8", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dança estranha 7", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dança 5", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dança Glowsticks", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dança Glowsticks 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dança Glowsticks 3", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dança Cavalo", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dança Cavalo 2", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dança Cavalo 3", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
}

DP.Emotes = {
   ["beber"] = {"mp_player_inteat@pnq", "loop", "Beber", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["besta"] = {"anim@mp_fm_event@intro", "beast_transform", "Besta", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["relaxado"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Relaxado", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["apanharsol4"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Apanhar Sol 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["apanharsol5"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Apanhar Sol 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["deitarfrente"] = {"missfbi3_sniping", "prone_dave", "Deitar de frente", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mandarencostar"] = {"misscarsteal3pullover", "pull_over_right", "Mandar Enconstar", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["ausente"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Ausente", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Idle 8"},
   ["ausente9"] = {"friends@fra@ig_1", "base_idle", "Ausente 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente10"] = {"mp_move@prostitute@m@french", "idle", "Ausente 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ausente11"] = {"random@countrysiderobbery", "idle_a", "Ausente 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Ausente 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Ausente 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Ausente 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Ausente 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Ausente 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Ausente 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ausente12"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Ausente 12", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bebedo"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Bêbedo", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bebedo2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Bêbedo 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bebedo3"] = {"missarmenian2", "standing_idle_loop_drunk", "Bêbedo 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["guitarra"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Guitarra Invisível"},
   ["piano"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Piano"},
   ["discutir"] = {"misscarsteal4@actor", "actor_berating_loop", "Discutir 1", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["discutir2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Discutir 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["discutir3"] = {"random@arrests", "thanks_male_05", "Discutir 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Bartender", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mandarbeijo"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Mandar beijo"},
   ["mandarbeijo2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Mandar beijo 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["venia"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Vénia"},
   ["atao"] = {"misscommon@response", "bring_it_on", "Atao", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["atao2"] = {"mini@triathlon", "want_some_of_this", "Atao 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["policia2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Polícia 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["policia3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Polícia 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bracos"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Braços cruzados", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bracos2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Braços cruzados 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["bracos3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Braços cruzados 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bracos4"] = {"random@street_race", "_car_b_lookout", "Braços cruzados 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bracos5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Braços cruzados 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bracos7"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Braços cruzados 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bracos6"] = {"random@shop_gunstore", "_idle", "Braços cruzados 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bracos8"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Braços cruzados 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bracos9"] = {"rcmnigel1a_band_groupies", "base_m2", "Braços cruzados 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["apontarbaixo"] = {"gestures@f@standing@casual", "gesture_hand_down", "Apontar para baixo", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["render"] = {"random@arrests@busted", "idle_a", "Render", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["belamerda"] = {"anim@mp_player_intupperv_sign", "enter", "BelaMerda", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["ola"] = {"anim@mp_player_intupperwave", "idle_a", "Olá", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["tascrazy"] = {"anim@mp_player_intupperyou_loco", "idle_a", "Tás Crazy?", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["cair"] = {"random@drunk_driver_1", "drunk_fall_over", "Caír "},
   ["suicidio"] = {"mp_suicide", "pistol", "Suicídio"},
   ["suicidio2"] = {"mp_suicide", "pill", "Suicídio 2"},
   ["levarestalo"] = {"friends@frf@ig_2", "knockout_plyr", "Levar Estalo"},
   ["levarestalo2"] = {"anim@gangops@hostage@", "victim_fail", "Levar Estalo 2"},
   ["adormecido"] = {"mp_sleep", "sleep_loop", "Adormecido", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["aquecer"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Aquecer Luta"},
   ["aquecer2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Aquecer Luta 2"},
   ["dedo"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Dedo", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dedo2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Dedo 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["aperto"] = {"mp_ped_interaction", "handshake_guy_a", "Aperto de mão", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["aperto2"] = {"mp_ped_interaction", "handshake_guy_b", "Aperto de mão 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["esperar4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Esperar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["esperar5"] = {"missclothing", "idle_storeclerk", "Esperar 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Esperar 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar7"] = {"rcmnigel1cnmt_1c", "base", "Esperar 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar8"] = {"rcmjosh1", "idle", "Esperar 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar9"] = {"rcmjosh2", "josh_2_intp1_base", "Esperar 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Esperar 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar11"] = {"misshair_shop@hair_dressers", "keeper_base", "Esperar 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["suspensorio"] = {"move_m@hiking", "idle", "Suspensório", AnimationOptions = 
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["abraco"] = {"mp_ped_interaction", "kisses_guy_a", "Abraço"},
   ["abraco2"] = {"mp_ped_interaction", "kisses_guy_b", "Abraço 2"},
   ["abraco3"] = {"mp_ped_interaction", "hugs_guy_a", "Abraço 3"},
   ["inspecionar"] = {"random@train_tracks", "idle_e", "Inspecionar"},
   ["surpresa"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Surpresa", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Corrida 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Corrida 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Corrida 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog5"] = {"move_m@joy@a", "walk", "Corrida 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Jumping Jacks", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ajoelhar2"] = {"rcmextreme3", "idle", "Ajoelhar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ajoelhar3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Ajoelhar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bater"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Bater à porta", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["bater2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Bater à porta 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["punhos"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Estalar punhos", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},
   ["encostar2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Enconstar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["encostar3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Encostar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["encostar4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Encostar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["encostar5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Encostar 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["encostar6"] = {"random@street_race", "_car_a_flirt_girl", "Encostar 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Encostar no Bar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Encostar no Bar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Encostar no Bar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bar5"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Encostar no Bar 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bar6"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Encostar no Bar 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["encostarlado"] = {"timetable@mime@01_gc", "idle_a", "Encostar de lado", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["encostarlado2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Encostar de lado 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["encostarlado3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Encostar de lado 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["encostarlado4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Encostar de lado 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["encostarlado5"] = {"rcmjosh2", "josh_2_intp1_base", "Encostar de lado 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["eu"] = {"gestures@f@standing@casual", "gesture_me_hard", "Eu", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["mecanico"] = {"mini@repair", "fixing_a_ped", "Mecânico", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mecanico2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "Mecânico 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mecanico3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mecânico 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mecanico4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mecânico 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mecanico5"] = {"amb@prop_human_movie_bulb@base", "base", "Mecânico 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["medico2"] = {"amb@medic@standing@tendtodead@base", "base", "Médico 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["meditar"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Meditar", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditar2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Meditar 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditar3"] = {"rcmepsilonism3", "base_loop", "Meditar 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nao"] = {"anim@heists@ornate_bank@chat_manager", "fail", "Não", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nao2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "Não 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tirarmacaco"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Tirar macaco do nariz", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nao3"] = {"gestures@m@standing@casual", "gesture_no_way", "Não 3", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cansado"] = {"re@construction", "out_of_breath", "Cansado", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apanhar"] = {"random@domestic", "pickup_low", "Apanhar"},
   ["empurrar"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Empurrar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["empurrar2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Empurrar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["apontar"] = {"gestures@f@standing@casual", "gesture_point", "Apontar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["flexoes"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Flexões", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["contagem"] = {"random@street_race", "grid_girl_race_start", "Contagem", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["apontar2"] = {"mp_gun_shop_tut", "indicate_right", "Apontar para a direita", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["continencia"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Saudar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["continencia2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Saudar 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["continencia3"] = {"anim@mp_player_intuppersalute", "idle_a", "Saudar 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["assustado"] = {"random@domestic", "f_distressed_loop", "Assustado", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["assustado2"] = {"random@homelandsecurity", "knees_loop_girl", "Assustado 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tudoseguido"] = {"misscommon@response", "screw_you", "Vai-te foder", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sacudir"] = {"move_m@_idles@shake_off", "shakeoff_1", "Sacudir", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["ferido"] = {"random@dealgonewrong", "idle_a", "Ferido", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dormir"] = {"timetable@tracy@sleep@", "idle_c", "Dormir", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["naosei"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Não sei", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["naosei2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Não sei 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["sentar"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Sentar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar2"] = {"rcm_barry3", "barry_3_sit_loop", "Sentar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Sentar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Sentar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Sentar 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Sentar 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Sentar 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Sentar 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Sentar 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentar10"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Sentar 10", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentartriste"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Sentar triste", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarassustado"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Sentar assustado", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarassustado2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Sentar assustado 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarassustado3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Sentar assustado 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarbebedo"] = {"timetable@amanda@drunk@base", "base", "Sentar Bêbedo", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarcadeira2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sentar na cadeira 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarcadeira3"] = {"timetable@reunited@ig_10", "base_amanda", "Sentar na cadeira 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarcadeira4"] = {"timetable@ron@ig_3_couch", "base", "Sentar na cadeira 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarcadeira5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sentar na cadeira 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarcadeira6"] = {"timetable@maid@couch@", "base", "Sentar na cadeira 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sentarcadeira7"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sentar na cadeira 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["abdominais"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Abdominais", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palmas5"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Palmas 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palmas3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Palmas 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["palmas"] = {"amb@world_human_cheering@male_a", "base", "Bater palmas", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["palmas4"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Palmas 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["palmas2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Palmas 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cheirar"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Cheirar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mirararma"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Mirar Arma", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["zonzo"] = {"misscarsteal4@actor", "stumble", "Zonzo", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["choque"] = {"stungun@standing", "damage", "Choque", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["apanharsol"] = {"amb@world_human_sunbathe@male@back@base", "base", "Apanhar sol", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["apanharsol2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Apanhar sol 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["t"] = {"missfam5_yoga", "a2_pose", "T", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "bind_pose_180", "T 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pensar5"] = {"mp_cp_welcome_tutthink", "b_think", "Pensar 5", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["pensar"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Pensar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pensar3"] = {"timetable@tracy@ig_8@base", "base", "Pensar 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["pensar2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Pensar 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fixe5"] = {"anim@mp_player_intupperthumbs_up", "enter", "Fixe 5", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["fixe4"] = {"anim@mp_player_intupperthumbs_up", "exit", "Fixe 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["fixe3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Fixe 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["fixe2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Fixe 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fixe"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Fixe", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["teclar"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Teclar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["teclar2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Teclar 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["teclar3"] = {"mp_prison_break", "hack_loop", "Teclar 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["teclar4"] = {"mp_fbi_heist", "loop", "Teclar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["aquecermaos"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Aquecer Mãos", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["acenar4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Acenar 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["acenar2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Acenar 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["acenar3"] = {"friends@fra@ig_1", "over_here_idle_a", "Acenar 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["acenar"] = {"friends@frj@ig_1", "wave_a", "Acenar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["acenar5"] = {"friends@frj@ig_1", "wave_b", "Acenar 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["acenar6"] = {"friends@frj@ig_1", "wave_c", "Acenar 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["acenar7"] = {"friends@frj@ig_1", "wave_d", "Acenar 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["acenar8"] = {"friends@frj@ig_1", "wave_e", "Acenar 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["acenar9"] = {"gestures@m@standing@casual", "gesture_hello", "Acenar 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["assobiar"] = {"taxi_hail", "hail_taxi", "Assobiar", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["assobiar2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Assobiar 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["boleia"] = {"random@hitch_lift", "idle_f", "Pedir Boleia", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["estatua2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Estátua 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["estatua3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Estátua 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gang"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Sinal de Gang", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gang2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Sinal de Gang", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["desmaiar"] = {"missarmenian2", "drunk_loop", "Desmaiar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["desmaiar2"] = {"missarmenian2", "corpse_search_exit_ped", "Desmaiar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["desmaiar3"] = {"anim@gangops@morgue@table@", "body_search", "Desmaiar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["desmaiar4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Desmaiar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["desmaiar5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Desmaiar 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["festinhas"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Fazer festinhas", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rastejar"] = {"move_injured_ground", "front_loop", "Rastejar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mortal2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Mortal 2"},
   ["mortal"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Mortal"},
   ["deslizar"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Deslizar"},
   ["deslizar2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Deslizar 2"},
   ["deslizar3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Deslizar 3"},
   ["tacada"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Tacada"},
   ["dedo3"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Dedo 3", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["dedo4"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Dedo 4", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["venia2"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Vénia 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["venia3"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Vénia 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["trancar"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Trancar", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["golf"] = {"rcmnigel1d", "swing_a_mark", "Golf"},
   ["comer"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Comer", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["coldre"] = {"move_m@intimidation@cop@unarmed", "idle", "Coldre", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar"] = {"random@shop_tattoo", "_idle_a", "Esperar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar2"] = {"missbigscore2aig_3", "wait_for_van_c", "Esperar 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar12"] = {"rcmjosh1", "idle", "Esperar 12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["esperar13"] = {"rcmnigel1a", "base", "Esperar 13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Lapdance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["estalo"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Estalo", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["cabecada"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Cabeçada"},
   ["dance10"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Dança 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["paz"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Paz", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["paz2"] = {"anim@mp_player_intupperpeace", "idle_a", "Paz 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["aviao2"] = {"missfbi1", "ledge_loop", "Avião 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["aviao"] = {"missfbi1", "ledge_loop", "Avião", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["espreitar"] = {"random@paparazzi@peek", "left_peek_a", "Espreitar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tossir"] = {"timetable@gardener@smoking_joint", "idle_cough", "Tossir", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["alongar"] = {"mini@triathlon", "idle_e", "Alongar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["alongar2"] = {"mini@triathlon", "idle_f", "Alongar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["alongar3"] = {"mini@triathlon", "idle_d", "Alongar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["alongar4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Alongar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["celebrar"] = {"rcmfanatic1celebrate", "celebrate", "Celebrar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["socar"] = {"rcmextreme2", "loop_punching", "Socar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["superheroi"] = {"rcmbarry", "base", "Super-herói", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superheroi2"] = {"rcmbarry", "base", "Super-herói 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lermente"] = {"rcmbarry", "mind_control_b_loop", "Ler mente", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lermente2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Ler mente 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palhaco"] = {"rcm_barry2", "clown_idle_0", "Palhaço", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palhaco2"] = {"rcm_barry2", "clown_idle_1", "Palhaço 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palhaco3"] = {"rcm_barry2", "clown_idle_2", "Palhaço 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palhaco4"] = {"rcm_barry2", "clown_idle_3", "Palhaço 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["palhaco5"] = {"rcm_barry2", "clown_idle_6", "Palhaço 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["roupa"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Experimentar roupa", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["roupa2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Experimentar roupa 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["roupa3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Experimentar roupa 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nervoso2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Nervoso 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervoso"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Nervoso", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervoso3"] = {"rcmme_tracey1", "nervous_loop", "Nervoso 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["desalgemar"] = {"mp_arresting", "a_uncuff", "Desalgemar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mirararma2"] = {"random@atmrobberygen", "b_atm_mugging", "Mirar Arma 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["radio"] = {"random@arrests", "generic_radio_chatter", "Rádio", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["puxar"] = {"random@mugging4", "struggle_loop_b_thief", "Puxar", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["assustado3"] = {"missheist_agency2ahands_up", "handsup_anxious", "Assustado 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["passaro"] = {"random@peyote@bird", "wakeup", "Pássaro"},
   ["galinha"] = {"random@peyote@chicken", "wakeup", "Galinha", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ladrar"] = {"random@peyote@dog", "wakeup", "Ladrar"},
   ["coelho"] = {"random@peyote@rabbit", "wakeup", "Coelho"},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["discutir4"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "Discutir 4", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["ajustar"] = {"missmic4", "michael_tux_fidget", "Ajustar", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["maosnoar"] = {"missminuteman_1ig_2", "handsup_base", "Mãos no ar", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["estatua"] = {"scenario", "WORLD_HUMAN_HUMAN_STATUE", "Estátua", AnimationOptions =
   {
      EmoteDuration = 1000,
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["mijar"] = {"misscarsteal2peeing", "peeing_loop", "Mijar", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},

-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------

   ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
   ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
   ["procurar"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Procurar"},
   ["dormir2"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Dormir 2"},
   ["festejar"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Festejar"},
   ["elevacoes"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Elevações"},
   ["notas3"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Bloco de apontamentos 3"},
   ["policia"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Polícia"},
   ["sinaleiro"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Polícia Sinaleiro"},
   ["filmar"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Filmar"},
   ["musculos"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Musculos"},
   ["guarda"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Guarda"},
   ["martelo"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Martelo"},
   ["bracos10"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Braços 10"},
   ["impaciente"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Impaciente"},
   ["vassoura"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Vassoura"},
   ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Correr"},
   ["ajoelhar"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Ajoelhar"},
   ["soprarfolhas"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Soprar folhas"},
   ["encostar"] = {"Scenario", "WORLD_HUMAN_LEANING", "Encostar"},
   ["bar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Bar"},
   ["olhar"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Olhar"},
   ["limpar3"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Limpar 3"},
   ["medico"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Médico"},
   ["musico"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Músico"},
   ["notas2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Bloco de notas 2"},
   ["parquimetro"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Parquímetro"},
   ["festa"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Festa"},
   ["mensagem"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Mandar mensagens"},
   ["prostituta"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostituta Alto"},
   ["prostituta2"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostituta Baixo"},
   ["charco"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Charco"},
   ["gravar"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Gravar"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["sentarcadeira"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sentar na cadeira"},
   ["fumar"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Fumar"},
   ["fumarerva"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Fumar Ganza"},
   ["apanharsol3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Apanhar sol 3"},
   ["apanharsol6"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Apanhar sol 6"},
   ["soldar"] = {"Scenario", "WORLD_HUMAN_WELDING", "Soldar"},
   ["olhar2"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Olhar 2"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["cortargarganta"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Corte na garganta"},
   ["cortargarganta2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Corte na garganta 2"},
   ["wtf"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "WTF", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["wtf2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "WTF 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boxing", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boxing 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["maucheiro"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Mau cheiro", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["pensar4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Pensar 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gravata"] = {"clothingtie", "try_tie_positive_a", "Ajustar gravata", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
}

DP.PropEmotes = {
   ["guardachuva"] = {"amb@world_human_drinking@coffee@male@base", "base", "Guarda-chuva", AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
-----------------------------------------------------------------------------------------------------

   ["notas"] = {"missheistdockssetup1clipboard@base", "base", "Bloco de notas", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["caixa"] = {"anim@heists@box_carry@", "idle", "Caixa", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rosa"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Rosa", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fumar2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Fumar 2", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fumar3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Fumar 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["fumar4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Fumar 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bongo"] = {"anim@safehouse@bong", "bong_stage3", "Bongo", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["mala"] = {"missheistdocksprep1hold_cellphone", "static", "Mala", AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mala2"] = {"missheistdocksprep1hold_cellphone", "static", "Mala 2", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Foto de identificação", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cafe"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Café", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cerveja"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Super Bock", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["copo"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Copo", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["hamburguer"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Hamburguer", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["sandes"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandes", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["barrita"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Barrita Chocolate", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["vinho"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Vinho tinto", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["copo2"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Copo de champagne", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["charuto"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Charuto", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["charuto2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Charuto 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["guitarra"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitarra", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarra2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Guitarra 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarraeletrica"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitarra Elétrica", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarraeletrica2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitarra Elétrica 2", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["livro"] = {"cellphone@", "cellphone_text_read_base", "Livro", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["flores"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Ramo de flores", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["urso"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Ursinho ", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["mochila"] = {"move_p_m_zero_rucksack", "idle", "Mochila", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["notas4"] = {"missfam4", "base", "Bloco de apontamentos 4", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["mapa"] = {"amb@world_human_tourist_map@male@base", "base", "Mapa", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["implorar"] = {"amb@world_human_bum_freeway@male@base", "base", "Implorar", AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Make It Rain", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "Camera", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
   ["champagne2"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Esgaçar champagne", AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
       PtfxWait = 500,
   }},
   ["ganza"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Ganza", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigarro"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigarro", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["mala3"] = {"missheistdocksprep1hold_cellphone", "static", "Mala 3", AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["chamada"] = {"cellphone@", "cellphone_call_listen_base", "Chamada de telemóvel", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["telemovel"] = {"cellphone@", "cellphone_text_read_base", "Telemóvel", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["limpar"] = {"timetable@floyd@clean_kitchen@base", "base", "Limpar", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["limpar2"] = {"amb@world_human_maid_clean@", "base", "Limpar 2", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
}