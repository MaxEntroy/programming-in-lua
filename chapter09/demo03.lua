-- syntatic sugar
local function fib(n)
    if n == 0 or n == 1 then
        return 1
    else
        return fib(n-1) + fib(n-2)
    end
end

print(fib(3))

-- 如下的形式wrong way
-- fact还未被定义完成
-- local fact = function(n)
--     if n == 0 then
--         return 1
--     else
--         return n * fact(n-1)
--     end
-- end

-- print(fact(3))

-- syntatic sugar的形式展开如下
local fib1
fib1 = function(n)
    if n == 0 or n == 1 then
        return 1
    else
        return fib1(n-1) + fib1(n-2)
    end
end

print(fib1(3))
