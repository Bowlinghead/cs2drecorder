--[[

	Save every relevant addhook in gameReplay together with the timestamp for later replay

]]

-- Variables
local gameReplay = GameReplay:New();	-- Writes down every 
local assembler = Assembler:New();		-- helps in creating strings




--[[

	When to start record/end record. Note that you always need to EndRecord duo to io.close() inside EndRecord()

]]--


-- START RECORD
addhook("say","SayHook")
function SayHook(id,txt)

	if (string.sub(txt, 1, 7) == "!record") then 
		gameReplay:StartRecord(string.sub(txt, 9));
	
	elseif (string.sub(txt, 1, 5) == "!stop") then
		gameReplay:EndRecord();
	end
end

-- END RECORD
addhook("shutdown","ShutdownHook") 
function ShutdownHook()
	gameReplay:EndRecord();
end

addhook(Config.saveHook,"SaveHook")
function SaveHook()
	--gameReplay:SaveSome(10);
end

addhook("startround","StartroundHook")
function StartroundHook()
	gameReplay:Save();
end


--[[
	All below hooks work the same: 
	Once they fire, remember all parameter like who shot with which weapon etc.
	
	INCLUDING FOR NOW:
	
	rotation 		-- every updateHook
	move			-- every updateHook
	
	move
	attack
	attack2
	hit
	spray
	bombdefuse
	bombplant
	die
	drop
	buy
	reload
	select
	spawn
	use

]]



addhook(Config.updateHook,"UpdateHook")
function UpdateHook()
	
	
	for _,id in ipairs(player(0,"tableliving")) do
		msg("pId:  "..id.."  /// Tick:  "..gameReplay.timeStamp)

		-- Save rotation
		assembler = Assembler:New();
		assembler:SetEntry(player(id,"rot"));
		
		gameReplay.actualState:SetEntry("rotation", id, assembler:Assemble());
	end

	-- Increment the timestamp
	gameReplay:Tick();
end


addhook("move","MoveHook")
function MoveHook(id,x,y)
	assembler = Assembler:New();
	assembler:SetEntry(x);
	assembler:SetEntry(y);
	
	gameReplay.actualState:SetEntry("move", id, assembler:Assemble());
end

addhook("attack","AttackHook")
function AttackHook(id)
	assembler = Assembler:New();
	assembler:SetEntry(player(id,"angle"));
	
	gameReplay.actualState:SetEntry("attack", id, assembler:Assemble());
end


addhook("attack2","AttackHook")
function AttackHook(id)
	assembler = Assembler:New();
	assembler:SetEntry(player(id,"angle"));
	
	gameReplay.actualState:SetEntry("attack2", id, assembler:Assemble());
end


addhook("hit","HitHook")
function HitHook(vic, src, wpn, hp, ap, obj)
	assembler = Assembler:New();
	assembler:SetEntry(src);
	assembler:SetEntry(wpn);
	assembler:SetEntry(hp);
	assembler:SetEntry(ap);
	assembler:SetEntry(obj);
	
	gameReplay.actualState:SetEntry("hit", vic, assembler:Assemble());
end

addhook("spray", "SprayHook")
function SprayHook(id)
	gameReplay.actualState:SetEntry("spray", id, "");
end


addhook("bombdefuse", "BombdefuseHook")
function BombdefuseHook(id)
	gameReplay.actualState:SetEntry("bombdefuse", id, "");
end

addhook("bombplant", "BombplantHook")
function BombplantHook(id,x,y)
	assembler = Assembler:New();
	assembler:SetEntry(x);
	assembler:SetEntry(y);
	
	
	gameReplay.actualState:SetEntry("bombplant", id, assembler:Assemble());
end

addhook("die","DieHook")
function DieHook(vic, kil, wpn, x, y, kobj)
	assembler = Assembler:New();
	assembler:SetEntry(kil);
	assembler:SetEntry(wpn);
	assembler:SetEntry(x);
	assembler:SetEntry(y);
	assembler:SetEntry(kobj);
	
	
	gameReplay.actualState:SetEntry("die", vic, assembler:Assemble());
end

addhook("drop","DropHook")
function DropHook(id, iid, wtype, ammoIn, ammoSpare, mode, xTile, yTile)
	assembler = Assembler:New();
	assembler:SetEntry(iid);
	assembler:SetEntry(wtype);
	assembler:SetEntry(ammoIn);
	assembler:SetEntry(ammoSpare);
	assembler:SetEntry(mode);
	assembler:SetEntry(xTile);
	assembler:SetEntry(yTile);
	
	gameReplay.actualState:SetEntry("drop", id, assembler:Assemble());
end

addhook("buy","BuyHook")
function BuyHook(id,wpn)
	assembler = Assembler:New();
	assembler:SetEntry(wpn);
	gameReplay.actualState:SetEntry("buy", id, assembler:Assemble());
end

addhook("reload","ReloadHook")
function ReloadHook(id, mode)
	assembler = Assembler:New();
	assembler:SetEntry(mode);
	
	gameReplay.actualState:SetEntry("reload", id, assembler:Assemble());
end


addhook("select","SelectHook")
function SelectHook(id, wtype, mode)

	assembler = Assembler:New();
	assembler:SetEntry(wtype);
	assembler:SetEntry(mode);
	
	
	gameReplay.actualState:SetEntry("select", id, assembler:Assemble());

end



addhook("spawn", "SpawnHook")
function SpawnHook(id)
	assembler = Assembler:New();
	assembler:SetEntry(player(id,"x"));
	assembler:SetEntry(player(id,"y"));
	gameReplay.actualState:SetEntry("respawn", id, assembler:Assemble());
end

addhook("use", "UseHook")
function UseHook(id, event, data, x, y)
	assembler = Assembler:New();
	assembler:SetEntry(event);
	assembler:SetEntry(data);
	assembler:SetEntry(x);
	assembler:SetEntry(y);
	
	gameReplay.actualState:SetEntry("use", id, assembler:Assemble());


end



