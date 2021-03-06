## 兼容性
- Lua5.2及其之前版本，数值类型都定义双精度浮点类型表示.即没有整型类型
- Lua5.3开始，数值类型有一下两种选择：
    - interger: 64位整型
    - float: 双精度浮点类型(不同于c/c++中，float代表单精度)
    - Lua5.3支持编译为small lua模式
        - 32位整型
        - 单精度浮点类型

上述兼容性，会带来如下**问题**：
- lua5.2和lua5.3表示的整数范围不一致
    - 当做一般计数值不会有明显问题
    - 如果当做bit vector，区别可能很重要

- 浮点数类型转化为整型
    - lua5.2没有规定浮点数类型转化为整型的转换方法
        - 官方文档说道：数值会以某种不确定的方式被截断
        - 因此，-3.2可能转为为-3，也可能转化为-4
    - lua5.3则有明确规定

- 整型类型操作相关变量不支持
    - lua5.2没有interger这种类型，所以不支持math.type
    - 同理，不支持math.maxinteger, min.mininterger
```lua
print(math.mininteger)
-- lua5.3.5 正常输出
-- lua5.1.5 输出nil
-- luajit2.0.5 输出nil
```

- floor除法
    - lua5.3引入了floor除法
    - 背景：
        - lua5.3引入整型，建议**开发人员，要么忽略整型和浮点型二者之间的区别，要么完整的控制每一个值得表示**
        - 如果两个操作数都是整型，结果也是整型。否则为浮点数类型。
        - 但是，所有除法计算操作，不管是整型还是浮点型，计算结果都是浮点型。不遵循
        - 但是这样会带来一个问题，既然引入了整型，但是在做除法操作的时候，即使都是整型，也会得到浮点类型结果的值
            - 这样的结果，在逻辑上表达了不能整除的语义，从结果的类型获得
            - 为了让lua的除法，和其他加，减，乘保持一样的规则(整数计算的结果还是整数)，引入了floor除法
        - 所以，引入了floor除法
    - lua5.2及其以前版本不支持floor除法
    ```lua
    local m = 6
    local n = 3
    print(m/n)    -- lua5.3.5 输出2.0
    print(m//n)   -- lua5.3.5 输出2
    ```

- 数字转字符串
    - 对于浮点数类型，但实际表示的整型数值，二者存在区别
    - lua5.3 会保留浮点数类型
    - lua5.2 不会保留浮点数类型格式
    - 我自己理解，在做计算的时候，没有丢失精度，值得结果不影响。其它潜在的影响，暂不清楚
```lua
local a = 3.45
local str = "this is "
print(str..a)

local b = 3.0
print(str..b)
--[[
lua5.3.5输出
this is 3.45
this is 3.0

lua5.1.5
this is 3.45
this is 3.0
]]
```