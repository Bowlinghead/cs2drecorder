


--[[ GameReplay 
	Creates a big table including every action happened at the whole game.
	GameReplay = { GameState, GameState, GameState, GameState };
	
]]--


GameReplay = { };

GameReplay.format = ".replay";
GameReplay.isRecording = false;

GameReplay.version = 1;			--OBSELETE internal version number. Used to check that Recorder/Replay dont mismatch duo to the Savefile.txt format
GameReplay.timeStamp = 1;		-- ticks every 100ms



--GameReplay.file =;
GameReplay.defaultPath = "sys/lua/GameReplay/Records/"
GameReplay.actualState = GameState:new();		-- providing an temporary actualState you should use


function GameReplay:Tick()
	if (GameReplay.isRecording) then
		
		io.write(tostring(self.timeStamp).. " = "..self.actualState:ToString());
		
		--table.insert(gameStateEntry, self); -- Just write; no need for 16gig RAM
		
		self.timeStamp = self.timeStamp + 1
		
		self.actualState = GameState:new();		-- Create a new actualState
		
	end
end

function GameReplay:New(object)
	object = object or {};   				-- create object if user does not provide one
	
	
	setmetatable(object, self);
	self.__index = self;
	return object;
end

function GameReplay:StartRecord(savefile)
	
	if (GameReplay.isRecording) then
		msg("\169255255255Already recording...")
		return;
	else
		GameReplay.isRecording = true;
	end
	
	

	-- IO stuff
	self.file = io.open(self.defaultPath..savefile..self.format,"w");
	io.output(self.file);
	local strWrite = tostring(self.version).." = [ \n";

	
	-- foreach gameStat to save
	for _,v in ipairs(Config.gameStats) do
		strWrite = strWrite.. "   "..v.." = "..tostring(game(v)).."\n";
	end

	strWrite = strWrite.."]; \n";	
	
	-- foreach player
	for _,id in ipairs(player(0,"tableliving")) do
		strWrite = strWrite..tostring(id).." = ( \n";
		
		for _,v in ipairs(Config.playerStats) do
			strWrite = strWrite.."   "..v.." = "..player(id,v).."\n";
		end
		
		strWrite = strWrite.."); \n";
	end
	
	io.write(strWrite);
	msg("\169255255255Started to record: "..savefile..self.format.."!");
	
end





function GameReplay:EndRecord()


	msg("\169255255255Stopped the recording!");
	io.close()
	GameReplay.isRecording = false;
end


