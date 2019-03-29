int func(int a, float b, char c);

int main(int argc, char argv) {

    int x = 123;
    float y = 23.3454;
    char z = 'e';

    int y = func(x, y, z);

    return y;
}

int func(int a, float b, char c) {

    if(a < 123) {
        return a;
    }
    else if(b == 23) {
        return a + 10;
    }
    else if(c == 'w'){
        return a + 34;
    }
    else {
        return -1;
    }


}