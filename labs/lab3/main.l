%{


extern int yylval;

%}



%%

[0-9]+ {

          yylval=atoi(yytext);

          return NUMBER;

       }

[\t] ;

[\n] return 0;

. return yytext[0];

%%

#include<stdio.h>

#include "y.tab.h"

int yywrap()

{

return 1;

}