#include "blur.hpp"
#include <iostream>

int main() {

    constexpr int rows = 3 ;
    constexpr int columns = 3;
    constexpr int npixels = rows * columns;

    int* image = new int[rows*columns];

    int value = 0 ;
    for (int i = 0 ; i < rows; i++) {
        for (int j = 0 ; j < columns; j++) {
            image[i*columns+j] = ++value;
        }
    }

    int* blurredImage = BlurKernelCuda(image, rows, columns);
    for (int i = 0 ; i < rows; i++) {
        for (int j = 0 ; j < columns; j++) {
            std::cout << blurredImage[i*columns+j]  ;
        }
        std::cout << "\n";
    }


    return 0 ;
}