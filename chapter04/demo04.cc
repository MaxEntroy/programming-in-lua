#include <iostream>
#include <algorithm>
#include <string>
#include <map>

std::map<std::string, int> grades;

// C++也可以实现
// 但是 order_function只能接受字符串参数
// grades只能写成全局 不然怎么访问到grades
//
// 对比Lua其实可以发现
// 把std::sort和order_function封装了一个closure SortByGrade
// 使得 order_function有能力访问函数外的局部变量 grades
// 这种实现保证了grades作为局部变量
// 但是C++没有这个能力 不支持嵌套函数以及闭包
bool order_function(const std::string& lhs, const std::string& rhs) {
    return grades[lhs] > grades[rhs];
}

void TestClosure() {
    std::string names[] = {"peter", "paul", "marry"};
    int sz = sizeof(names)/sizeof(names[0]);

    grades.insert(std::pair<std::string, int>("peter", 8));
    grades.insert(std::pair<std::string, int>("paul", 7));
    grades.insert(std::pair<std::string, int>("marry", 10));

    std::sort(names, names + sz, order_function);

    for(int i = 0; i < sz; ++i) {
        std::cout << names[i] << std::endl;
    }
}

int main(void) {
    TestClosure();
    return 0;
}
