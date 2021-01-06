


--[[ GameState 
	Creates a big table including every action happened at this tick
	
	GameReplay got an actualState, this is a GameState object.
	
	Addhooks.lua uses its GameReplay.actualState to set the entries.
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