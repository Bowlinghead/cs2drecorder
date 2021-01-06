
ChatCommand = { };




function ChatCommand:New(object)
	object = object or {};   				-- create object if user does not provide one
	setmetatable(object, self);
	self.__index = self; 
	return object;
end