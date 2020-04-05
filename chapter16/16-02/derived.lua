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
