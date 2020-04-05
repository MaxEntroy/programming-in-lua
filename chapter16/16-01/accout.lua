Account = {balance = 0}
function Account:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = Account
  return o
end

function Account:withdraw(v)
  self.balance = self.balance - v
end

--[[
function Accout.new()
  local o = {}
  return setmetatable(o, {__index = Account})
end
]]

local a = Account:new({balance = 20})
a:withdraw(10)
print(a.balance)


local b = Account:new({balance = 30})
b:withdraw(10)
print(b.balance)
