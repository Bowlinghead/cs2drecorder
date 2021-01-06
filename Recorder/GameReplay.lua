


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

GameReplay.stateList = {};


function GameReplay:Tick()
	if (GameReplay.isRecording) then
		self.stateList[GameReplay.timeStamp] = self.actualState;
		self.actualState = GameState:new();	
		GameReplay.timeStamp = GameReplay.timeStamp + 1;
	end
end


function GameReplay:Save()
	if (GameReplay.isRecording) then
		
		for timeStamp,state in pairs(self.stateList) do
			if (state ~= nil) then
				io.write(tostring(timeStamp).." = "..state:ToString());
			end
		end
		self.stateList = {};
	end

end

function GameReplay:SaveSome(amount)
	local counter = 0;
	
	for timeStamp, state in pairs(self.stateList) do
		if (counter >= amount) then
			return;
		end
		
		if (state ~= nil) then
			io.Write(tostring(timeStamp).." = "..self.stateList[timeStamp]:ToString());
			
			self.stateList[timeStamp] = nil;
			
			counter = counter + 1;
		end
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
		GameReplay.timeStamp = 1;
		GameReplay.isRecording = true;
	end
	
	

	-- IO stuff
	self.file = io.open(self.defaultPath..savefile..self.format,"a");
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
	if (GameReplay.isRecording) then

		self:Save();

		io.close()
		
		msg("\169255255255Stopped the recording!");
		GameReplay.isRecording = false;
	end
end


