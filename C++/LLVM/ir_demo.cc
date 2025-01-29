
class StringUtil {

public:
    int len(char* msg) {
        int len = 0;
        char* current = msg;
        while (*current != '\0') {
            len++;
            current++;
        }
        return len;
    }

};

int add(int a, int b) {
    return a+b;
}

int main() {

    StringUtil util;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wwritable-strings"
    int l = util.len("hi");
    #pragma clang diagnostic pop

    int r = add(1,l);

    return 0;
}
