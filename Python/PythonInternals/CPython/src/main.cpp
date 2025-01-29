#include <iostream>


#include "my_math.h"


int main()
{

    MyMath math;

    std::cout << "Add 1+2 = " << math.add(1,2) << std::endl;
    std::cout << "Divide 1/2 = " << math.divide(1, 2) << std::endl;

    return 0;
}