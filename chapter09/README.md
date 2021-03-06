## 闭包

### 概述

- Lua语言中的函数严格遵循词法定界，且是第一类值
    - 第一类值：具备以下权限
        - 可以保存到变量中
        - 可以作为参数传递给其他函数
        - 可以作为函数返回值
    - 词法定界：函数有能力访问包含其自身的外部函数中的变量(当然，这不是词法定界本身的含义，只是说闭包当中的内嵌函数可以访问外部函数局部变量的能力，由词法定界保证)
    - 优点：以上两个特点为Lua函数带来很强的灵活性
        - 第一类值：
            - 方便支持对函数功能的重定义，支持沙箱场景
            - 函数式编程
        - 词法定界：
            - 回调场景

对几个概念进行解释：

- **定界**
变量与变量所对应的实体之间，绑定关系的有效范围。分为词法定界(静态定界)以及动态定界。
>怎么理解呢？为什么上述词法定界是很具体的定义？
我自己是这个理解，词法定界只是保证，一个变量的可见性范围，仅仅严格的与组成程序的静态具体词法上下文有关。即，只要一个程序写好了，在compile time, compiler可以根据上下文判断出一个变量的可见性。在Lua中，支持嵌套函数的定义，词法定界增加了一条规则：一个闭包当中，闭包函数的局部变量对于内嵌函数是可见的。其实在C++中命名空间也具有这样的能力，但是，这是不同的语境，如果在嵌套函数要支持，编译器必须要通过规则去支持。所以，特别地说道，词法定界支持内嵌函数对于闭包函数中局部变量的访问能力。

### 函数是第一类值

- 所有函数都是匿名的
    - 函数的定义本质是匿名函数对于变量的赋值
    - 函数体是函数构造器
    - 以函数作为参数的函数，称作高阶函数

### 非全局函数

- 递归函数的定义要注意

### 词法定界

- Lua中变量从作用域角度说有三种
    - 全局(global)
    - 局部(local)
    - 非局部(non-local)
- non-local变量使用场景固定
    - 词法定界支持
    - 本质上用来支持闭包
    - 在Lua中也叫做上值(upvalue)
- 闭包
    - 内嵌函数对于upvalue的访问，可以逃逸出upvalue原始的定界范围
    - 上述能力通过闭包来支持
    - 闭包本质上是一种机制，它支持了：内嵌函数对于upvalue的访问

### 函数式编程
- 我的理解，通过集合论来理解世界
- 特征函数本质上是集合的条件
- Lua中函数作为第一类值，天生支持函数式编程(泛函，把函数当做自变量)

参考
[Scope tutial](http://lua-users.org/wiki/ScopeTutorial)
