--[[
	If you want to record a match then ONLY load this file
	
]]
pathRoot = "sys/lua/GameReplay/";
path = pathRoot.."Recorder/";



dofile(pathRoot.."config.lua")


msg("hehe1")
dofile(path.."GameState.lua");
msg("hehe2")

dofile(path.."GameReplay.lua");
msg("hehe3")

dofile(path.."Assembler.lua");
msg("hehe4")

dofile(path.."Addhooks.lua");
msg("hehe5")