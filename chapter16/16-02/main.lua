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
