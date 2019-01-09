#include<stdio.h>

extern int yylex();
extern int yylineno();


int main() {
    int ntoken,vtoken;
    ntoken = yylex();
    
    while(ntoken){
        printf("%d\n",ntoken);
        ntoken=yylex();
    }
    return 0;
}

int yywrap(void) {
    return 1;
}