local derivative = function(f, delta)
    delta = delta or 1e-4
    return function(x)
        return 1.0 / delta * (f(x + delta) - f(x))
    end
end

-- deria_sin 是math.sin()的导函数
-- 语义看起来更加自然
local deria_sin = derivative(math.sin)

print(deria_sin(5.2))
print(deria_sin(10))
