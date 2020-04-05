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

但是，这会带来的问题就是，性能上的损耗，因为需要两次元表访问，才能访问基类当中定义的成员。如果为了避免性能损耗，可以不使用基类的成员，派生类重新定义，可是这样继承的意义又何在？
我不知道我的思考是否有方向性问题，因为任何其他实现了oo的语言，也一样会面临性能的考量。但是他们不还是实现了。

参考了lua-users wiki当中对于性能的讨论，这让我觉得，好像过于担心性能不是非常必要，尤其在继承层次不深的情况下。但是又有新的问题

q:派生类如何对于基类的成员进行构造?因为lua其实不太有interface的概念，所以唯一可以使用继承的原因就在于，我们可以从基类当中复用
>这个问题困扰了我一会，因为在派生类当中需要重定义new函数，因为基类的new函数无法接受全部参数，所以必须重定义。
但是，如果重定义，又不能调用基类的new函数。只能单独赋值，其实这么做还好。只是没有那么优雅。
>
>我受到云风，以及知乎上一篇文章的启发，采用ctor，即抽离出构造的过程，这种思路能较好的解决这个问题

```lua
-- base.lua
local Base = {}

function Base.New(self)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Base.BaseCtor(self, x)
  self.x = x
end

function Base.PrintX(self)
  print(self.x)
end

return Base

-- derived.lua
local Base = require "bbase"

local Derived = Base:New()

function Derived.DerivedCtor(self, x, y)
  self:BaseCtor(x)
  self.y = y
end

function Derived.PrintY(self)
  print(self.y)
end

return Derived


-- main.lua
local Base = require "bbase"
local Derived = require "dderived"

local base_obj = Base:New()
base_obj:BaseCtor(3)
base_obj:PrintX()

local deri_obj = Derived:New()
deri_obj:DerivedCtor(1, 2)
deri_obj:PrintX()
deri_obj:PrintY()

local deri_obj_b = Derived:New()
deri_obj_b:DerivedCtor(3, 4)
deri_obj_b:PrintX()
deri_obj_b:PrintY()
```

这么实现完全没有问题，让我们来分析一个调用```deri_obj:PrintX()```
1. deri_obj没有Print方法，经过两次metatable查询
2. PrintX当中访问self.x，self此时是deri_obj，没有这个成员，经过两次metatable查询
所以，我们可以分析得到，在一层派生的情况下，如果派生类复用基类的方法，需要4次metatable查询

我们不放看看下面的实现：

```lua
-- base.lua
local Base = {}

function Base.New(self)
  local o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Base.Ctor(self, x)
  self.x = x
end

function Base.PrintX(self)
  print(self.x)
end

return Base

-- derived.lua
local Base = require "base"

local Derived = Base:New()

function Derived.Ctor(self, x, y)
  self.x = x
  self.y = y
end

function Derived.PrintY(self)
  print(self.y)
end

return Derived

-- main.lua
local Base = require "base"
local Derived = require "derived"

local base_obj = Base:New()
base_obj:Ctor(3)
base_obj:PrintX()

local deri_obj = Derived:New()
deri_obj:Ctor(1, 2)
deri_obj:PrintX()
deri_obj:PrintY()

local deri_obj_b = Derived:New()
deri_obj_b:Ctor(3, 4)
deri_obj_b:PrintX()
deri_obj_b:PrintY()
```

上面实现的特点在于:
1. 派生类不再访问基类的数据成员，只访问基类的函数成员
2. 一次基类方法调用，开销减少到2次
3. 总结就是，数据没有复用，但是方法得到了复用。