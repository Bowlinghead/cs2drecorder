--[[
	If you want to record a match then ONLY load this file
	
]]












pathRoot = "sys/lua/GameReplay/";
path = pathRoot.."Recorder/";


dofile(pathRoot.."config.lua")


dofile(path.."Assembler.lua")
dofile(path.."GameState.lua");
dofile(path.."GameReplay.lua");
dofile(path.."Addhooks.lua");