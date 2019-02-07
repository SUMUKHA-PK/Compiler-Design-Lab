int main() {

    int a, b = 10, c = 12, array[10];

    a = 0;

    while(a < b) {
        array[a] = a + c;
        c = c + a;
        a = a + 1;
    }
}