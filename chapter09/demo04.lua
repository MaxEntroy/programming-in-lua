local names = {"peter", "paul", "marry"}
local grades = {
    peter = 8,
    paul = 7,
    marry = 10
}

-- 定义闭包SortByGrades
-- 内部匿名函数function(lhs, rhs) 有访问外部函数的局部变量grades的能力
-- 这样就不像C++当中只能写成全局变量
local SortByGrades = function(names, grades)
    table.sort(names, function(lhs, rhs)
        return grades[lhs] > grades[rhs]
    end)
end

SortByGrades(names, grades)

for _, name in ipairs(names) do
    print(name)
end
