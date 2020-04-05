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
