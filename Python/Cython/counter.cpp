#include <iostream>
#include <ostream>

class Counter {
    public:
        void increment() { count++; }
        void decrement() { count--; }
        void print() { std::cout << *this; }

        friend std::ostream& operator<<(std::ostream& stream, const Counter& counter) {
            stream << counter.count ;
            return stream;
        }

    private:
        int count = 0;

};

extern "C" {
    Counter* make_counter() {
        Counter* counter = new Counter();
        return counter;
    }
}


int main() {
    Counter counter;

    for (int i = 0 ; i < 10; i++) {
        std::cout << counter << std::endl;
    }

    return 0 ;
}