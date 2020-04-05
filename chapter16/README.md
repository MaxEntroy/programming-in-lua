## Object Oriented Programming

### base-demo

这个小节尝试用table来模拟object，这么做可行的原因是
- like objects, tables have a state.
- like objects, tables have an identy.
  - two tables with the same value are different objects.
  - an object can have different value at difference times, but it is always the same object.
- like objects, tables have a life cycle.

```lua
Account = {balance = 0}
function Account.withdraw(self, v)
  self.balance = self.balance - v
end

a1 = Account
Account = nil

a1.withdraw(a1, 100)
print(a1.balance)

a2 = {balance = 0, withdraw = a1.withdraw}
a2.withdraw(a2, 200)
print(a2.balance)
```

以上的实现，还有一些问题
- they lack class system(which means How can we create several objects with similar behavior)
- they lack inheritance
- they lack polomophism

### Classes

基本思路是
- prototype-based
- prototype table and object table

```lua
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
```

### Inheritance

继承所采用的思路，和class一致，此时基类可以充当派生类的元表。还是采用prototype-based这样的一种机制来进行模拟。
注意基类写法当中self的用途，可以避免在派生类当中重新定义new方法

```lua
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
```

但是，这回带来的问题就是，性能上的损耗，因为需要两次元表访问，才能访问基类当中定义的成员。如果为了避免性能损耗，可以不使用基类的成员，派生类重新定义，可是这样继承的意义又何在？
我不知道我的思考是否有方向性问题，因为任何其他实现了oo的语言，也一样会面临性能的考量。但是他们不还是实现了。