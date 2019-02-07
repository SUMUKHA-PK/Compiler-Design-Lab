%{
    #include<stdio.h>
    // #include "symbolTable.h"

    void yyerror(const char *s);

    extern char *yytext;
    extern int yylineno;

    #define RED   "\x1B[31m"
    #define RESET "\x1B[0m"
    #define GREEN "\x1B[32m"
    #define BLUE  "\x1B[34m"
%}

%locations


%token CHAR
%token INT
%token FLOAT
%token DOUBLE
%token SHORT
%token UNSIGNED
%token LONG

%token RETURN
%token IF
%token ELSE
%token WHILE
%token L_FLOWER_BRKT    
%token R_FLOWER_BRKT
%token L_PAREN
%token R_PAREN
%token STRING 
%token VOID
%token BREAK
%token L_SQR_BRKT
%token R_SQR_BRKT

%token IDENTIFIER
%token NUM_INTEGER 
%token NUM_FLOAT
%token SEMICOLON
%token COMMA   

%left REL_LESSEQUAL REL_GREATEQUAL REL_EQUAL REL_NOTEQUAL REL_LESSTHAN REL_GREATERTHAN
%left AR_PLUS AR_MINUS AR_MUL AR_DIV AR_MOD BITWISE_XOR BITWISE_AND BITWISE_OR
%left LOG_AND LOG_OR LOG_COMPARE
%start ED

%%
ED: 
    SEMICOLON_FOUND 
|   expr ED 
|   while ED 
|   if_elses ED 
|   var_func_dec_def ED 
| 
;

SEMICOLON_FOUND: 
    SEMICOLON               {printf("Line %d. Semicolon found\n", yylineno);}
;



expr:
    expr AR_PLUS expr       {$$ = $1 + $3; printf("Line %d. Addition operator found!\n", yylineno);}
|   expr AR_MINUS expr       {$$ = $1 - $3; printf("Line %d. Minux operator found\n", yylineno);}
|   expr AR_MUL expr       {$$ = $1 * $3; printf("Line %d. Multiplication operator found\n", yylineno);}
|   expr AR_DIV expr       {$$ = $1 / $3; printf("Line %d. Division operator found\n", yylineno);}
|   expr AR_MOD expr       {$$ = $1 % $3; printf("Line %d. Modulo operator found\n", yylineno);}
|   expr AR_PLUS AR_PLUS      {$$ = $1++; printf("Line %d. Increment operator found\n", yylineno);}
|   expr BITWISE_XOR expr       {$$ = $1 ^ $3; printf("Line %d. Bitwise Xor expression found\n", yylineno);}
|   expr BITWISE_OR expr       {$$ = $1 | $3; printf("Line %d. Bitwise or expression found\n", yylineno);}
|   expr BITWISE_AND expr       {$$ = $1 & $3; printf("Line %d. Bitwise and expression found\n", yylineno);}
|   expr BITWISE_AND BITWISE_AND expr   {$$ = $1 && $4; printf("Line %d. Logical and expression found\n", yylineno);}
|   expr BITWISE_OR BITWISE_OR expr   {$$ = $1 || $4; printf("Line %d. Logical or expression found\n", yylineno);}
|   expr REL_EQUAL REL_EQUAL expr   {$$ = $1 == $4; printf("Line %d. Compare expression found\n", yylineno);}
|   expr REL_LESSTHAN expr       {$$ = $1 < $3; printf("Line %d. Less than\n expression found", yylineno);}
|   expr REL_LESSEQUAL expr   {$$ = $1 <= $3; printf("Line %d. Less than or equal expression found\n", yylineno);}
|   expr REL_EQUAL expr       {$$ = $1 = $3; printf("Line %d. Equal\n expression found", yylineno);}      
|   expr REL_GREATEQUAL expr   {$$ = $1 >= $3; printf("Line %d. Greater than or equal expression found\n", yylineno);}
|   expr REL_GREATERTHAN expr       {$$ = $1 > $3; printf("Line %d. Greater than expression found\n", yylineno);}
|   expr REL_NOTEQUAL expr   {$$ = $1 != $3; printf("Line %d. Not equal expression found\n", yylineno);}
|   NUM_INTEGER                 {printf("Line %d. Integer found\n", yylineno);}
|   NUM_FLOAT                   {printf("Line %d. Floating Number found\n", yylineno);}
|   IDENTIFIER                  {printf("Line %d. An Identifier found\n", yylineno);}
;

datatype: 

    FLOAT                 {printf("Line %d. Found float datatype\n", yylineno);}
|   DOUBLE                {printf("Line %d. Found double datatype\n", yylineno);}
|   CHAR                    {printf("Line %d. Found char datatype\n", yylineno);}
|   UNSIGNED CHAR                   {printf("Line %d. Found unsigned char datatype\n", yylineno);}
|   INT                 {printf("Line %d. Found int datatype\n", yylineno);}
|   UNSIGNED INT                    {printf("Line %d. Found unsigned int datatype\n", yylineno);}
|   SHORT INT                   {printf("Line %d. Found short int datatype\n", yylineno);}
|   SHORT UNSIGNED INT                  {printf("Line %d. Found short unsigned int datatype\n", yylineno);}
|   LONG INT                    {printf("Line %d. Found long int datatype\n", yylineno);}
|   LONG UNSIGNED INT                   {printf("Line %d. Found long unsigned int\n", yylineno);}
|   VOID                          {printf("Line %d. Found void\n", yylineno);}
;



// NUMBER: 
//     NUM_INTEGER                 {printf("Line %d. Found integer\n", yylineno);}
// |   NUM_FLOAT                   {printf("Line %d. Found floating point number\n", yylineno);}

;

block: 
    ED                              {printf("Line %d. Found code block\n", yylineno);}
;

else_if:
    IF L_PAREN expr R_PAREN L_FLOWER_BRKT R_FLOWER_BRKT elses
|   L_FLOWER_BRKT R_FLOWER_BRKT 
;

elses:
    ELSE else_if                    {printf("ELSES\n");}
| 
;


if_elses:
    IF L_PAREN expr R_PAREN L_FLOWER_BRKT R_FLOWER_BRKT  elses            {printf("if else\n");}
;


while: 
    WHILE L_PAREN expr R_PAREN L_FLOWER_BRKT block R_FLOWER_BRKT    {printf("Line %d. Found a while loop\n", yylineno);}
;

var_func_dec_def: 

    datatype X          {printf("In var_func. Line %d. Found datatype!\n", yylineno);}
;

X: 
    IDENTIFIER Y        {printf("In X. Line %d. Found an identifier\n", yylineno);}
;

Y: 
    L_PAREN func        {printf("In Y. Taken the path of a function\n");}
|   REL_EQUAL expr Z    {printf("In Y. Taken the path of = expr Z\n");}
|   Z                   {printf("In Y. Taken the path of Z\n");}
;


Z: 
    COMMA IDENTIFIER A  {printf("In Z. Taken the path of Comma Identifier A\n");}
|   SEMICOLON_FOUND     {printf("In Z. Stopped at ;\n");}
;

A: 
    REL_EQUAL expr Z    {printf("In A. Taken the path of = expr Z\n");}
|   Z                   {printf("In A. Taken the path of Z\n");}
;

func: 
    R_PAREN C
|   datatype IDENTIFIER B
;

C: 
    SEMICOLON_FOUND 
|   L_FLOWER_BRKT block R_FLOWER_BRKT
;

B: 
    R_PAREN C
|   COMMA datatype IDENTIFIER B
;  


%%

void yyerror(const char *s){
   printf("Error: %s at token %s in Line %d\n",s, yytext, yylineno );
}

int main()
{
    initTables();

    printf("Enter expression: \n\n");
    if(!yyparse()){
        printf("\nParsing complete\n");
        printf(GREEN "\n\nSYMBOL TABLE" RESET);
        printf("\n-----------------------------------------------------------------\n");
        printf(BLUE "%-20s%10s%24s\n","VALUE","TYPE","LINE NUMBER" RESET);
        printf("-----------------------------------------------------------------\n");
        printTable(0);

        printf(GREEN "\n\nCONSTANT TABLE" RESET);
        printf("\n-----------------------------------------------------------------\n");
        printf(BLUE "%-20s%10s%24s\n","VALUE","TYPE","LINE NUMBER" RESET);
        printf("-----------------------------------------------------------------\n");
        printTable(1);
    }
        
    else
        printf("\nParsing error!\n");
    

}
