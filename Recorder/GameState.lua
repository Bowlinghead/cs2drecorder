


--[[ GameState 
	Creates a big table including every action happened at this tick
	GameState = {   
		{ "hookname" , pid, "parameter_see_Addhooks_dot_lua"}
		
		
		--example: (string view: Records/example.txt 
		{ "rotation", 3, "128" },  	-- every 100ms
		{ "move", 5, "64; 64" },	-- every 100ms
		{ "attack", 5, "128" },
		{ "attack2", 5, "128" },
		{ "hit", 3, "5; 50; 30; 10; 0" },
		{ "spray", 5, "" },
		{ "bombdefuse", 5, "" },
		{ "bombplant", 5, "32; 64" },
		{ "die", 5, "3; 50; 32; 64; 0" },
		...
		
		drop
		buy
		reload
		select
		spawn
		use
		
		
	}
]]--

GameState = { };
GameState.list = {}; -- entry, entry , entry = { {x,y,z}, {x,y,z}, {x,y,z} } 

function GameState:SetEntry(strAction, intPlayerId, strParam)
	local entry = {strAction, intPlayerId, strParam };
	table.insert(self.list, entry);
end

function GameState:ToString()
	local strReturn = "{ \n"
	
	for _,v in pairs(self.list) do
	
		strReturn = strReturn.." { '"..tostring(v[1]).."'";
	
		for i=2,3 do
			strReturn = strReturn..", '"..tostring(v[i]).."'";
		end
		
		strReturn = strReturn.." }, \n"
	end

	strReturn = strReturn .. "}; \n"

	return strReturn;
end

function GameState:new(object)
	object = object or {};   				-- create object if user does not provide one
	setmetatable(object, self);
	self.__index = self;
	return object;
end