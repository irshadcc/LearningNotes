
find . -regex '.*\.\(cpp\|hpp\|cc\|cxx\|cu\|cuh\)' -exec clang-format -style=file -i {} \;


cd build
make
cd -

./build/src/cuda_example
