#include <iostream>

double f1(double x) {
    return x;
}

double f2(double x) {
    return x*x;
}

double f3(double x) {
    return x*x*x;
}

typedef double (*PowFunction)(double);

// 缺点
// 1.每次调用需要带着原函数
// 2.原函数标签改变 需要再写一个相应函数的导函数 其实过程都一样
double pow_deriative(PowFunction pow_func, double x) {
    double delta = 1e-4;
    double res = ((*pow_func)(x + delta) - (*pow_func)(x)) / delta;
    return res;
}

int main(void) {
    double val = 2;

    double der = pow_deriative(f1, val);
    std::cout << "der of f1 at " << val << " is " << der << std::endl;

    der = pow_deriative(f2, val);
    std::cout << "der of f2 at " << val << " is " << der << std::endl;

    der = pow_deriative(f3, val);
    std::cout << "der of f3 at " << val << " is " << der << std::endl;
    return 0;
}
