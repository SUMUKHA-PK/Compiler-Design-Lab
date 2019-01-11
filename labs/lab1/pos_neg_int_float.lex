%{
    int num_posint = 0, num_negint = 0, num_posfloat = 0, num_negfloat = 0;
%}

posint "+"?" "*[0-9]+
negint "-"" "*[0-9]+
int [0-9]+

%%

{posint} {num_posint++;}
{negint} {num_negint++;}
{posint}"."{int} {num_posfloat++;}
{negint}"."{int} {num_negfloat++;}

%%

int yywrap(){} 

int main(){
    yylex(); 
    printf("Positive Integers = %d and decimals = %d \nNegative Integers = %d and decimals = %d\n", num_posint, num_posfloat, num_negint, num_negfloat);
    return 0; 
} 