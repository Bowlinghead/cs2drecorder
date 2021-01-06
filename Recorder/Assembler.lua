
--[[
	Basic String Builder
]]--


Assembler = { };
Assembler.delimiter = "; "
Assembler.list = {};
Assembler.counter = 0;


function Assembler:SetEntry(parameter)
	self.counter = self.counter + 1;
	self.list[self.counter] = parameter;
end

function Assembler:Assemble() 
	local output = "";
	for k,v in ipairs(self.list) do
		output = output..tostring(v)..self.delimiter;
	end
	return output;
end

function Assembler:New(object)
	object = object or {};   				-- create object if user does not provide one
	setmetatable(object, self);
	self.__index = self; 
	object.list = {};
	return object;
end






