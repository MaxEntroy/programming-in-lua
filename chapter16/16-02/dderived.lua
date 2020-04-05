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
