-- 参考 https://blog.csdn.net/qq_26958473/article/details/79392222
local function OperatorConcat(str, n)
    local ret = ""
    --local sep = "|"
    for i = 1, n do
        ret = ret..str
    end
    return ret
end

local function TableConcat(str, n)
    local tb = {}
    --local sep = "|"
    for i = 1, n do
        table.insert(tb, str)
    end
    local ret = table.concat(tb)
    return ret
end

local function Contrast(str, n)
    local sep_line = "------------------------------"
    print(sep_line)
    print("count = "..n)

    local start = os.clock()
    OperatorConcat(str, n)
    local stop = os.clock()
    local diff = stop - start
    print(string.format("%-20s %f", "OperatorConcat:", diff))

    start = os.clock()
    OperatorConcat(str, n)
    stop = os.clock()
    diff = stop - start
    print(string.format("%-20s %f", "TableConcat:", diff))
end

local function Test()
    local test_str = "20220520A9JFUS11"
    local test_count = {10, 100, 1000, 10000, 100000}
    for _, count in ipairs(test_count) do
        Contrast(test_str, count)
    end
end

Test()
