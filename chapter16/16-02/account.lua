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

function SpecialAccount.withdraw(self, v)
  self.balance = self.balance - v * 2
end

local c = SpecialAccount:new({balance = 100})
c:withdraw(20)
print(c.balance)
