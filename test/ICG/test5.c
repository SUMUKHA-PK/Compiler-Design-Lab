int func();

int func() {

    int x = 10;

    if(x > 10) {
        x = 20;
    }
    else if(x < 10) {
        x = 0;
    }
    else 
        x = 10;

    return x - 1;
}