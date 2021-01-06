--[[
	"Global" variables both used by Replay and Record lua
]]--

Config = {};


--[[
	Note that you can change the interval of each tick.
	Please enter one of the hooks provided by CS2D:
	always
	ms100
	second	-- ever watched a video with one fps?
	minute 	-- are you kiddin..
]]
Config.updateHook = "second";


--[[
	Note that you can change them, please follow the shematics from the player lua cmd
]]
Config.playerStats = {
		"name",
		"usgn",
		"steamid",
		"team",
		"look",
		"x",
		"y",
		"rot",
		"health",
		"maxhealth",
		"armor",
		"money",
		"score",
		"deaths",
		"mvp",
		"assists",
		"speedmod",
};



--[[
	Same applies but with the game lua cmd
]]
Config.gameStats = {
		-- see game() cmd
		"version",
		"phase",
		"round",
		"timeleft",		-- seconds
		"maptimeleft",	--seconds; float precision, 1000000 if unlimited
		"score_t",
		"score_ct",
		"ticks",		-- 
		"bombplanted",	-- bool true/false
	
		-- generic server commands. 
		"sv_fow",
		"sv_friendlyfire",
		"sv_gamemode",
		"sv_name",
		"sv_offscreendamage", -- bool 0/1
		"mp_autoteambalance",
		"mp_buymenu",
		"mp_buytime",
		"mp_c4timer",
		"mp_damagefactor",
		"mp_deathdrop", -- 0 everything, 1 Prim+Sec+Defuse+NV, 2 Prim+Sec+Defuse, 3 Prim+Sec, 4 Nothing
		"mp_dropgrenades",
		"mp_flashlight",
		"mp_freezetime",
		"mp_grenaderebuy",
		"mp_hostagepenalty",
		"mp_hovertext",
		"mp_hud",
		"mp_idleaction",
		"mp_infammo",
		"mp_kevlar",
		"mp_radar",
		"mp_recoil",
		"mp_roundlimit",
		"mp_roundtime",
		"mp_startmoney",
		"mp_teamkillpenalty",
		"mp_winlimit",
		
		
		
		
	};
	
	
	
	
	
	