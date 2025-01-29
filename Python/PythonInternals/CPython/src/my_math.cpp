#include "my_math.h"


int MyMath::add(int x, int y) {
    return x + y;
}

int MyMath::subtract(int x, int y) {
    return x - y;
}

int MyMath::multiply(int x, int y) {
    return x * y;
}

float MyMath::divide(int x, int y) {
    return static_cast<float>(x) / y;
}