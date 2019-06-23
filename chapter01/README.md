## 程序段(lua chunk)
- 定义
```
Each piece of code that Lua executes, such as a file or a single line in interactive mode, is a chunk.
A chunk may be as simple as a single statement.
A chunk may be as large as you wish.
```
- 我的理解
我对Lua chunk的理解是从```A chunk may be as simple as a single statement```开始的。lua作为一门脚本语言，它的最小执行单元，就是一条statement.

## 类型和值
- Lua是一门动态语言(Dynamically-typed languages)，这意味着：
    - Lua中没有类型定义(type definition)
    - 每个值都带有其自身的类型信息

需要特别注意的是，**变量首次使用即定义**，考虑下面程序段
```lua
local function Add(left, right)
    return left + rieht -- right写成rieht
end

local ret = Add(3,5)
print(ret)
```

lua作为一门脚本语言，只有执行的时候才会触发异常逻辑，导致程序错误。

- 基本类型
    - nil, boolean, number, string
    - userdata, function, thread, table
    - 注意：
        - 前4种属于基本类型
        - 后4种属于对象类型，这回使得变量在参数传递，函数返回时，均操作的是对象的引用
        - function, thread均作为基本类型，和c/c++这类语言相比，被提升为"一等公民"

- nil类型
    - nil类型的取值只有一个，就是nil
    - 无逻辑意义，只是为了和其他有逻辑意义值做区分。exist and non-exist.