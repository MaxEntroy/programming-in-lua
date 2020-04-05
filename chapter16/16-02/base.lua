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
