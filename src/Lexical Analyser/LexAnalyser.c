#include<stdio.h>

extern int yylex();
extern int yylineno;
extern char* yytext;
// int yywrap(void);

int yywrap(void) {
    return 1;
}

int main(void) {

    int ntoken,vtoken;
    ntoken = yylex();
    printf("token is : %d",yylineno);
    while(ntoken){
        printf("%d\n",ntoken);
        ntoken=yylex();
        printf("%d %s",yylineno,yytext);
    }
    return 0;
}
