Account = {balance = 0}

function Account.new(self, o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Account.withdraw(self, v)
  self.balance = self.balance - v
end

function Account.deposit(self, v)
  self.balance = self.balance + v
end

function Account.get_balance(self)
  return self.balance
end

local a = Account:new({balance = 30})

a:deposit(20)
print(a.balance)

a:withdraw(10)
print(a.balance)

local b = Account:new({balance = 50})
b:deposit(20)
print(b.balance)

b:withdraw(10)
print(b.balance)

SpecialAccount =  Account:new()

function SpecialAccount.new(self, conf)
  self.balance = conf.balance
  local o = {
    max = conf.max
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function SpecialAccount.withdraw(self, v)
  self.balance = self.balance - v * 2
end

local conf = {balance = 200, max = 30}
local c = SpecialAccount:new(conf)

print(c:get_balance())
