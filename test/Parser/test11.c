void func_name(int x, float y, char z);

int main() {

    float w = 123.123123;

    if(w == 123) {
        func_name(1, 2, 3);
    }
    
    else if(w == 123.1) {
        func_name(2, 1, 3);
    }

    else if(w == 123.123123) {
        func_name(3, 2, 1);
    }

    else {
        func_name(4, 3, 2);
    }
    
    w = 10;

    while(w < 100) {
        w = w + 1;
    }

    return 234;

}

void func_name(int x, int y, int z) {

    int a, b, c;

    a = x + y;
    b = y + z;
    c = z + x;

    return;
}

